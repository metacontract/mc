import { parse } from '@solidity-parser/parser';
import * as fs from 'fs-extra';
import * as path from 'path';
import * as yaml from 'js-yaml';

// Load facade configuration
interface FacadeConfig {
    bundleName: string;
    bundleDirName: string;
    facades: FacadeDefinition[];
}

interface FacadeDefinition {
    name: string;
    excludeFileNames: string[];
    excludeFunctionNames: string[];
}

interface FacadeObjects {
    files: FileSignature[],
    errors: ErrorSignature[],
    events: EventSignature[],
    functions: FunctionSignature[],
}

interface FileSignature {
    name: string;
    origin: string; // Name of the origin file
}
interface ErrorSignature {
    name: string;
    parameters: string;
    origin: string; // Name of the origin file
}
interface EventSignature {
    name: string;
    parameters: string;
    origin: string; // Name of the origin file
}
interface FunctionSignature {
    name: string;
    visibility: string;
    stateMutability: string;
    parameters: string;
    returnParameters: string;
    origin: string; // Name of the origin file
}

const facadeConfigPath = './facade.yaml'; // Configuration file path
const outputDir = './generated'; // Output directory for generated files

async function main() {
    const projectRoot = path.resolve(__dirname, '../../');
    process.chdir(projectRoot);

    // Ensure output directory exists
    await fs.ensureDir(path.resolve(outputDir));

    // Load facade configuration
    const facadeConfigs: FacadeConfig[] = await loadFacadeConfig();

    for (const facadeConfig of facadeConfigs) {
        // Ensure required fields are present
        if (!facadeConfig.bundleName || !facadeConfig.bundleDirName) {
            console.error('Error: bundleName and bundleDirName are required in facade.yaml');
            process.exit(1);
        }

        if (!facadeConfig.facades || facadeConfig.facades.length === 0) {
            console.error('Error: At least one facade must be defined in facade.yaml');
            process.exit(1);
        }

        for (const facade of facadeConfig.facades) {
            if (!facade.name) {
                console.error('Error: Each facade must have a name');
                process.exit(1);
            }
        }

        // Process each facade
        for (const facade of facadeConfig.facades) {
            const facadeObject: FacadeObjects = {
                files: [],
                errors: [],
                events: [],
                functions: []
            };
            const functionDir = `./src/${facadeConfig.bundleDirName}/functions`; // Adjust the path as needed
            const interfaceDir = `./src/${facadeConfig.bundleDirName}/interfaces`; // Adjust the path as needed
            // Recursively read all Solidity files in the source directory
            const functionFiles = await getSolidityFiles(functionDir);
            const interfaceFiles = await getSolidityFiles(interfaceDir);

            const regex = /^(I)?.*(Errors|Events)\.sol$/;

            for (const file of interfaceFiles) {
                const fileName = path.basename(file);

                if (regex.test(fileName)) {
                    facadeObject.files.push({ name: fileName.replace(/\.sol$/, ""), origin: file.replace(/\\/g, '/') });
                }
            }

            for (const file of functionFiles) {
                const fileName = path.basename(file);

                // Exclude files based on facade configuration
                if (facade.excludeFileNames.includes(fileName)) {
                    continue;
                }

                const content = await fs.readFile(file, 'utf8');
                try {
                    const ast = parse(content, { tolerant: true });

                    // Extract functions from the AST
                    traverseASTs(ast, facadeObject, fileName, facade);
                } catch (err) {
                    console.error(`Error parsing ${file}:`, err);
                }
            }

            // Generate facade contract
            await generateFacadeContract(facadeObject, facade, facadeConfig);
        }
    }
}

async function loadFacadeConfig(): Promise<FacadeConfig[]> {
    try {
        const configContent = await fs.readFile(facadeConfigPath, 'utf8');
        const configRaws = yaml.load(configContent) as any;

        for (let configRaw of configRaws) {
            if (!configRaw.bundleDirName) {
                configRaw.bundleDirName = configRaw.bundleName
            }
            // Ensure excludeFileNames and excludeFunctionNames are arrays
            for (const facade of configRaw.facades) {
                if (!facade.excludeFileNames) {
                    facade.excludeFileNames = [];
                }
                if (!facade.excludeFunctionNames) {
                    facade.excludeFunctionNames = [];
                }
            }
        }

        const config = configRaws as FacadeConfig[];
        return config;
    } catch (err) {
        console.error(`Could not load facade configuration from ${facadeConfigPath}.`);
        process.exit(1);
    }
}

async function getSolidityFiles(dir: string): Promise<string[]> {
    let files: string[] = [];
    const items = await fs.readdir(dir);

    for (const item of items) {
        const fullPath = path.join(dir, item);
        const stat = await fs.stat(fullPath);

        if (stat.isDirectory()) {
            const subFiles = await getSolidityFiles(fullPath);
            files = files.concat(subFiles);
        } else if (stat.isFile() && path.extname(item) === '.sol') {
            files.push(fullPath);
        }
    }

    return files;
}

function traverseASTs(
    ast: any,
    facadeObjects: FacadeObjects,
    origin: string,
    facade: FacadeDefinition
) {
    if (ast.type === 'FunctionDefinition' && ast.isConstructor === false) {
        extractFunctions(ast, facadeObjects.functions, origin, facade);
    } else if (ast.type === 'ContractDefinition') {
        // Traverse contract sub-nodes
        for (const subNode of ast.subNodes) {
            traverseASTs(subNode, facadeObjects, origin, facade);
        }
    } else if (ast.type === 'SourceUnit') {
        // Traverse source unit nodes
        for (const child of ast.children) {
            traverseASTs(child, facadeObjects, origin, facade);
        }
    } else if (ast.type === 'CustomErrorDefinition') {
        extractErrors(ast, facadeObjects.errors, origin);
    } else if (ast.type === 'EventDefinition') {
        extractEvents(ast, facadeObjects.events, origin);
    }
}

function extractErrors(
    ast: any,
    errors: ErrorSignature[],
    origin: string
) {
    const error: ErrorSignature = {
        name: ast.name,
        parameters: ast.parameters
            .map((param: any) => getParameter(param))
            .join(', '),
        origin: origin
    };
    errors.push(error);
}

function extractEvents(
    ast: any,
    events: EventSignature[],
    origin: string
) {
    const event: EventSignature = {
        name: ast.name,
        parameters: ast.parameters
            .map((param: any) => getParameter(param))
            .join(', '),
        origin: origin
    };
    events.push(event);
}

function extractFunctions(
    ast: any,
    functions: FunctionSignature[],
    origin: string,
    facade: FacadeDefinition
) {
    // Skip functions based on the criteria
    if (
        !ast.name || // Skip unnamed functions (constructor, fallback, receive)
        ast.name.startsWith('test') ||
        ast.name === 'setUp' ||
        ast.visibility === 'private' ||
        ast.visibility === 'internal' ||
        facade.excludeFunctionNames.includes(ast.name)
    ) {
        return;
    }

    const func: FunctionSignature = {
        name: ast.name,
        visibility: ast.visibility || 'default',
        stateMutability: ast.stateMutability || '',
        parameters: ast.parameters
            .map((param: any) => getParameter(param))
            .join(', '),
        returnParameters: ast.returnParameters
            ? ast.returnParameters
                .map((param: any) => getParameter(param))
                .join(', ')
            : '',
        origin: origin, // Set the origin to the file name
    };

    // Add to functions array
    functions.push(func);
}

function getParameter(param: any): string {
    const typeName = getTypeName(param.typeName);
    return `${typeName}${param.storageLocation ? ' ' + param.storageLocation : ''}${param.name ? ' ' + param.name : ''
        }`;
}

function getTypeName(typeName: any): string {
    if (!typeName) return '';
    if (typeName.type === 'ElementaryTypeName') {
        return typeName.name;
    } else if (typeName.type === 'UserDefinedTypeName') {
        return typeName.namePath;
    } else if (typeName.type === 'Mapping') {
        return `mapping(${getTypeName(typeName.keyType)} => ${getTypeName(
            typeName.valueType,
        )})`;
    } else if (typeName.type === 'ArrayTypeName') {
        return `${getTypeName(typeName.baseTypeName)}[]`;
    } else if (typeName.type === 'FunctionTypeName') {
        // Simplify function type names for parameters
        return 'function';
    } else {
        return 'unknown';
    }
}

async function generateFacadeContract(
    objects: FacadeObjects,
    facade: FacadeDefinition,
    config: FacadeConfig
) {
    const facadeFilePath = path.join(outputDir, `${facade.name}.sol`);
    let code = `// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Schema} from "src/${config.bundleDirName}/storage/Schema.sol";
`;

    for (const file of objects.files) {
        code += `import {${file.name}} from "${file.origin}";\n`;
    }

    code += `\ncontract ${facade.name} is Schema, ${objects.files.map((file) => file.name).join(', ')} {\n`;

    for (const error of objects.errors) {
        code += generateError(error);
    }
    code += `\n`;
    for (const event of objects.events) {
        code += generateEvent(event);
    }
    code += `\n`;
    for (const func of objects.functions) {
        code += generateFunctionSignature(func);
    }

    code += `}\n`;

    // Write the facade contract to the output file
    await fs.writeFile(facadeFilePath, code);
    console.log(`Facade contract generated at ${facadeFilePath}`);
}

function generateError(error: ErrorSignature) {
    return `    error ${error.name}(${error.parameters});\n`
}
function generateEvent(event: EventSignature) {
    return `    event ${event.name}(${event.parameters});\n`
}
function generateFunctionSignature(func: FunctionSignature): string {
    const visibility =
        func.visibility !== 'default' ? func.visibility : 'public';
    const stateMutability = func.stateMutability
        ? ' ' + func.stateMutability
        : '';
    const returns = func.returnParameters
        ? ` returns (${func.returnParameters})`
        : '';
    return `    function ${func.name}(${func.parameters}) ${visibility}${stateMutability}${returns} {}\n`;
}

main().catch((err) => {
    console.error('Error:', err);
});


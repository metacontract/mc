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

    for(const facadeConfig of facadeConfigs) {
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

        const sourceDir = `./src/${facadeConfig.bundleDirName}/functions`; // Adjust the path as needed

        // Recursively read all Solidity files in the source directory
        const allFiles = await getSolidityFiles(sourceDir);

        // Process each facade
        for (const facade of facadeConfig.facades) {
            const functionSignatures: FunctionSignature[] = [];

            for (const file of allFiles) {
                const fileName = path.basename(file);

                // Exclude files based on facade configuration
                if (facade.excludeFileNames.includes(fileName)) {
                    continue;
                }

                const content = await fs.readFile(file, 'utf8');
                try {
                    const ast = parse(content, { tolerant: true });

                    // Extract functions from the AST
                    const functions: FunctionSignature[] = [];
                    extractFunctions(ast, functions, fileName, facade);

                    if (functions.length > 0) {
                        functionSignatures.push(...functions);
                    }
                } catch (err) {
                    console.error(`Error parsing ${file}:`, err);
                }
            }

            // Generate facade contract
            await generateFacadeContract(functionSignatures, facade, facadeConfig);
        }
    }
}

async function loadFacadeConfig(): Promise<FacadeConfig[]> {
    try {
        const configContent = await fs.readFile(facadeConfigPath, 'utf8');
        const configRaws = yaml.load(configContent) as any;

        for(let configRaw of configRaws) {
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

function extractFunctions(
    ast: any,
    functions: FunctionSignature[],
    origin: string,
    facade: FacadeDefinition
) {
    if (ast.type === 'FunctionDefinition' && ast.isConstructor === false) {
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
    } else if (ast.type === 'ContractDefinition') {
        // Traverse contract sub-nodes
        for (const subNode of ast.subNodes) {
            extractFunctions(subNode, functions, origin, facade);
        }
    } else if (ast.type === 'SourceUnit') {
        // Traverse source unit nodes
        for (const child of ast.children) {
            extractFunctions(child, functions, origin, facade);
        }
    }
}

function getParameter(param: any): string {
    const typeName = getTypeName(param.typeName);
    return `${typeName}${param.storageLocation ? ' ' + param.storageLocation : ''}${
        param.name ? ' ' + param.name : ''
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
    functionSignatures: FunctionSignature[],
    facade: FacadeDefinition,
    config: FacadeConfig
) {
    const facadeFilePath = path.join(outputDir, `${facade.name}.sol`);
    let code = `// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Schema} from "src/${config.bundleDirName}/storage/Schema.sol";
import {I${config.bundleName}Events} from "src/${config.bundleDirName}/interfaces/I${config.bundleName}Events.sol";
import {I${config.bundleName}Errors} from "src/${config.bundleDirName}/interfaces/I${config.bundleName}Errors.sol";

contract ${facade.name} is Schema, I${config.bundleName}Events, I${config.bundleName}Errors {\n`;

    for (const func of functionSignatures) {
        code += generateFunctionSignature(func);
    }

    code += `}\n`;

    // Write the facade contract to the output file
    await fs.writeFile(facadeFilePath, code);
    console.log(`Facade contract generated at ${facadeFilePath}`);
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


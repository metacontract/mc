"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g = Object.create((typeof Iterator === "function" ? Iterator : Object).prototype);
    return g.next = verb(0), g["throw"] = verb(1), g["return"] = verb(2), typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (g && (g = 0, op[0] && (_ = 0)), _) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
Object.defineProperty(exports, "__esModule", { value: true });
var solidity_parser_antlr_1 = require("solidity-parser-antlr");
var fs = require("fs-extra");
var path = require("path");
var yaml = require("js-yaml");
var facadeConfigPath = './facade.yaml'; // Configuration file path
var outputDir = './generated'; // Output directory for generated files
function main() {
    return __awaiter(this, void 0, void 0, function () {
        var facadeConfig, _i, _a, facade, sourceDir, allFiles, _b, _c, facade, functionSignatures, _d, allFiles_1, file, fileName, content, ast, functions;
        return __generator(this, function (_e) {
            switch (_e.label) {
                case 0: return [4 /*yield*/, loadFacadeConfig()];
                case 1:
                    facadeConfig = _e.sent();
                    // Ensure required fields are present
                    if (!facadeConfig.bundleName || !facadeConfig.bundleDirName) {
                        console.error('Error: bundleName and bundleDirName are required in facade.yaml');
                        process.exit(1);
                    }
                    if (!facadeConfig.facades || facadeConfig.facades.length === 0) {
                        console.error('Error: At least one facade must be defined in facade.yaml');
                        process.exit(1);
                    }
                    for (_i = 0, _a = facadeConfig.facades; _i < _a.length; _i++) {
                        facade = _a[_i];
                        if (!facade.name) {
                            console.error('Error: Each facade must have a name');
                            process.exit(1);
                        }
                    }
                    sourceDir = "./src/".concat(facadeConfig.bundleDirName, "/functions");
                    return [4 /*yield*/, getSolidityFiles(sourceDir)];
                case 2:
                    allFiles = _e.sent();
                    // Ensure output directory exists
                    return [4 /*yield*/, fs.ensureDir(outputDir)];
                case 3:
                    // Ensure output directory exists
                    _e.sent();
                    _b = 0, _c = facadeConfig.facades;
                    _e.label = 4;
                case 4:
                    if (!(_b < _c.length)) return [3 /*break*/, 11];
                    facade = _c[_b];
                    functionSignatures = [];
                    _d = 0, allFiles_1 = allFiles;
                    _e.label = 5;
                case 5:
                    if (!(_d < allFiles_1.length)) return [3 /*break*/, 8];
                    file = allFiles_1[_d];
                    fileName = path.basename(file);
                    // Exclude files based on facade configuration
                    if (facade.excludeFileNames.includes(fileName)) {
                        return [3 /*break*/, 7];
                    }
                    return [4 /*yield*/, fs.readFile(file, 'utf8')];
                case 6:
                    content = _e.sent();
                    try {
                        ast = (0, solidity_parser_antlr_1.parse)(content, { tolerant: true });
                        functions = [];
                        extractFunctions(ast, functions, fileName, facade);
                        if (functions.length > 0) {
                            functionSignatures.push.apply(functionSignatures, functions);
                        }
                    }
                    catch (err) {
                        console.error("Error parsing ".concat(file, ":"), err);
                    }
                    _e.label = 7;
                case 7:
                    _d++;
                    return [3 /*break*/, 5];
                case 8: 
                // Generate facade contract
                return [4 /*yield*/, generateFacadeContract(functionSignatures, facade, facadeConfig)];
                case 9:
                    // Generate facade contract
                    _e.sent();
                    _e.label = 10;
                case 10:
                    _b++;
                    return [3 /*break*/, 4];
                case 11: return [2 /*return*/];
            }
        });
    });
}
function loadFacadeConfig() {
    return __awaiter(this, void 0, void 0, function () {
        var configContent, configRaw, _i, _a, facade, config, err_1;
        return __generator(this, function (_b) {
            switch (_b.label) {
                case 0:
                    _b.trys.push([0, 2, , 3]);
                    return [4 /*yield*/, fs.readFile(facadeConfigPath, 'utf8')];
                case 1:
                    configContent = _b.sent();
                    configRaw = yaml.load(configContent);
                    // Ensure excludeFileNames and excludeFunctionNames are arrays
                    for (_i = 0, _a = configRaw.facades; _i < _a.length; _i++) {
                        facade = _a[_i];
                        if (!facade.excludeFileNames) {
                            facade.excludeFileNames = [];
                        }
                        if (!facade.excludeFunctionNames) {
                            facade.excludeFunctionNames = [];
                        }
                    }
                    config = configRaw;
                    return [2 /*return*/, config];
                case 2:
                    err_1 = _b.sent();
                    console.error("Could not load facade configuration from ".concat(facadeConfigPath, "."));
                    process.exit(1);
                    return [3 /*break*/, 3];
                case 3: return [2 /*return*/];
            }
        });
    });
}
function getSolidityFiles(dir) {
    return __awaiter(this, void 0, void 0, function () {
        var files, items, _i, items_1, item, fullPath, stat, subFiles;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    files = [];
                    return [4 /*yield*/, fs.readdir(dir)];
                case 1:
                    items = _a.sent();
                    _i = 0, items_1 = items;
                    _a.label = 2;
                case 2:
                    if (!(_i < items_1.length)) return [3 /*break*/, 7];
                    item = items_1[_i];
                    fullPath = path.join(dir, item);
                    return [4 /*yield*/, fs.stat(fullPath)];
                case 3:
                    stat = _a.sent();
                    if (!stat.isDirectory()) return [3 /*break*/, 5];
                    return [4 /*yield*/, getSolidityFiles(fullPath)];
                case 4:
                    subFiles = _a.sent();
                    files = files.concat(subFiles);
                    return [3 /*break*/, 6];
                case 5:
                    if (stat.isFile() && path.extname(item) === '.sol') {
                        files.push(fullPath);
                    }
                    _a.label = 6;
                case 6:
                    _i++;
                    return [3 /*break*/, 2];
                case 7: return [2 /*return*/, files];
            }
        });
    });
}
function extractFunctions(ast, functions, origin, facade) {
    if (ast.type === 'FunctionDefinition' && ast.isConstructor === false) {
        // Skip functions based on the criteria
        if (!ast.name || // Skip unnamed functions (constructor, fallback, receive)
            ast.visibility === 'internal' ||
            ast.name.startsWith('_') ||
            ast.name.startsWith('test') ||
            ast.name === 'setUp' ||
            facade.excludeFunctionNames.includes(ast.name)) {
            return;
        }
        var func = {
            name: ast.name,
            visibility: ast.visibility || 'default',
            stateMutability: ast.stateMutability || '',
            parameters: ast.parameters
                .map(function (param) { return getParameter(param); })
                .join(', '),
            returnParameters: ast.returnParameters
                ? ast.returnParameters
                    .map(function (param) { return getParameter(param); })
                    .join(', ')
                : '',
            origin: origin, // Set the origin to the file name
        };
        // Add to functions array
        functions.push(func);
    }
    else if (ast.type === 'ContractDefinition') {
        // Traverse contract sub-nodes
        for (var _i = 0, _a = ast.subNodes; _i < _a.length; _i++) {
            var subNode = _a[_i];
            extractFunctions(subNode, functions, origin, facade);
        }
    }
    else if (ast.type === 'SourceUnit') {
        // Traverse source unit nodes
        for (var _b = 0, _c = ast.children; _b < _c.length; _b++) {
            var child = _c[_b];
            extractFunctions(child, functions, origin, facade);
        }
    }
}
function getParameter(param) {
    var typeName = getTypeName(param.typeName);
    return "".concat(typeName).concat(param.storageLocation ? ' ' + param.storageLocation : '').concat(param.name ? ' ' + param.name : '');
}
function getTypeName(typeName) {
    if (!typeName)
        return '';
    if (typeName.type === 'ElementaryTypeName') {
        return typeName.name;
    }
    else if (typeName.type === 'UserDefinedTypeName') {
        return typeName.namePath;
    }
    else if (typeName.type === 'Mapping') {
        return "mapping(".concat(getTypeName(typeName.keyType), " => ").concat(getTypeName(typeName.valueType), ")");
    }
    else if (typeName.type === 'ArrayTypeName') {
        return "".concat(getTypeName(typeName.baseTypeName), "[]");
    }
    else if (typeName.type === 'FunctionTypeName') {
        // Simplify function type names for parameters
        return 'function';
    }
    else {
        return 'unknown';
    }
}
function generateFacadeContract(functionSignatures, facade, config) {
    return __awaiter(this, void 0, void 0, function () {
        var facadeFilePath, code, _i, functionSignatures_1, func;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    facadeFilePath = path.join(outputDir, "".concat(facade.name, ".sol"));
                    code = "// SPDX-License-Identifier: MIT\npragma solidity ^0.8.24;\n\nimport {Schema} from \"src/".concat(config.bundleDirName, "/storage/Schema.sol\";\nimport {I").concat(config.bundleName, "Events} from \"src/").concat(config.bundleDirName, "/interfaces/I").concat(config.bundleName, "Events.sol\";\nimport {I").concat(config.bundleName, "Errors} from \"src/").concat(config.bundleDirName, "/interfaces/I").concat(config.bundleName, "Errors.sol\";\n\ncontract ").concat(facade.name, " is Schema, I").concat(config.bundleName, "Events, I").concat(config.bundleName, "Errors {\n");
                    for (_i = 0, functionSignatures_1 = functionSignatures; _i < functionSignatures_1.length; _i++) {
                        func = functionSignatures_1[_i];
                        code += generateFunctionSignature(func);
                    }
                    code += "}\n";
                    // Write the facade contract to the output file
                    return [4 /*yield*/, fs.writeFile(facadeFilePath, code)];
                case 1:
                    // Write the facade contract to the output file
                    _a.sent();
                    console.log("Facade contract generated at ".concat(facadeFilePath));
                    return [2 /*return*/];
            }
        });
    });
}
function generateFunctionSignature(func) {
    var visibility = func.visibility !== 'default' ? func.visibility : 'public';
    var stateMutability = func.stateMutability
        ? ' ' + func.stateMutability
        : '';
    var returns = func.returnParameters
        ? " returns (".concat(func.returnParameters, ")")
        : '';
    return "    function ".concat(func.name, "(").concat(func.parameters, ") ").concat(visibility).concat(stateMutability).concat(returns, " {}\n");
}
main().catch(function (err) {
    console.error('Error:', err);
});

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
var parser_1 = require("@solidity-parser/parser");
var fs = require("fs-extra");
var path = require("path");
var yaml = require("js-yaml");
var facadeConfigPath = './facade.yaml'; // Configuration file path
var outputDir = './generated'; // Output directory for generated files
function main() {
    return __awaiter(this, void 0, void 0, function () {
        var projectRoot, facadeConfigs, _i, facadeConfigs_1, facadeConfig, _a, _b, facade, _c, _d, facade, facadeObject, functionDir, interfaceDir, functionFiles, interfaceFiles, regex, _e, interfaceFiles_1, file, fileName, _f, functionFiles_1, file, fileName, content, ast;
        return __generator(this, function (_g) {
            switch (_g.label) {
                case 0:
                    projectRoot = path.resolve(__dirname, '../../');
                    process.chdir(projectRoot);
                    // Ensure output directory exists
                    return [4 /*yield*/, fs.ensureDir(path.resolve(outputDir))];
                case 1:
                    // Ensure output directory exists
                    _g.sent();
                    return [4 /*yield*/, loadFacadeConfig()];
                case 2:
                    facadeConfigs = _g.sent();
                    _i = 0, facadeConfigs_1 = facadeConfigs;
                    _g.label = 3;
                case 3:
                    if (!(_i < facadeConfigs_1.length)) return [3 /*break*/, 14];
                    facadeConfig = facadeConfigs_1[_i];
                    // Ensure required fields are present
                    if (!facadeConfig.bundleName || !facadeConfig.bundleDirName) {
                        console.error('Error: bundleName and bundleDirName are required in facade.yaml');
                        process.exit(1);
                    }
                    if (!facadeConfig.facades || facadeConfig.facades.length === 0) {
                        console.error('Error: At least one facade must be defined in facade.yaml');
                        process.exit(1);
                    }
                    for (_a = 0, _b = facadeConfig.facades; _a < _b.length; _a++) {
                        facade = _b[_a];
                        if (!facade.name) {
                            console.error('Error: Each facade must have a name');
                            process.exit(1);
                        }
                    }
                    _c = 0, _d = facadeConfig.facades;
                    _g.label = 4;
                case 4:
                    if (!(_c < _d.length)) return [3 /*break*/, 13];
                    facade = _d[_c];
                    facadeObject = {
                        files: [],
                        errors: [],
                        events: [],
                        functions: []
                    };
                    functionDir = "./src/".concat(facadeConfig.bundleDirName, "/functions");
                    interfaceDir = "./src/".concat(facadeConfig.bundleDirName, "/interfaces");
                    return [4 /*yield*/, getSolidityFiles(functionDir)];
                case 5:
                    functionFiles = _g.sent();
                    return [4 /*yield*/, getSolidityFiles(interfaceDir)];
                case 6:
                    interfaceFiles = _g.sent();
                    regex = /^(I)?.*(Errors|Events)\.sol$/;
                    for (_e = 0, interfaceFiles_1 = interfaceFiles; _e < interfaceFiles_1.length; _e++) {
                        file = interfaceFiles_1[_e];
                        fileName = path.basename(file);
                        if (regex.test(fileName)) {
                            facadeObject.files.push({ name: fileName.replace(/\.sol$/, ""), origin: file.replace(/\\/g, '/') });
                        }
                    }
                    _f = 0, functionFiles_1 = functionFiles;
                    _g.label = 7;
                case 7:
                    if (!(_f < functionFiles_1.length)) return [3 /*break*/, 10];
                    file = functionFiles_1[_f];
                    fileName = path.basename(file);
                    // Exclude files based on facade configuration
                    if (facade.excludeFileNames.includes(fileName)) {
                        return [3 /*break*/, 9];
                    }
                    return [4 /*yield*/, fs.readFile(file, 'utf8')];
                case 8:
                    content = _g.sent();
                    try {
                        ast = (0, parser_1.parse)(content, { tolerant: true });
                        // Extract functions from the AST
                        traverseASTs(ast, facadeObject, fileName, facade);
                    }
                    catch (err) {
                        console.error("Error parsing ".concat(file, ":"), err);
                    }
                    _g.label = 9;
                case 9:
                    _f++;
                    return [3 /*break*/, 7];
                case 10:
                    console.log(facadeObject);
                    // Generate facade contract
                    return [4 /*yield*/, generateFacadeContract(facadeObject, facade, facadeConfig)];
                case 11:
                    // Generate facade contract
                    _g.sent();
                    _g.label = 12;
                case 12:
                    _c++;
                    return [3 /*break*/, 4];
                case 13:
                    _i++;
                    return [3 /*break*/, 3];
                case 14: return [2 /*return*/];
            }
        });
    });
}
function loadFacadeConfig() {
    return __awaiter(this, void 0, void 0, function () {
        var configContent, configRaws, _i, configRaws_1, configRaw, _a, _b, facade, config, err_1;
        return __generator(this, function (_c) {
            switch (_c.label) {
                case 0:
                    _c.trys.push([0, 2, , 3]);
                    return [4 /*yield*/, fs.readFile(facadeConfigPath, 'utf8')];
                case 1:
                    configContent = _c.sent();
                    configRaws = yaml.load(configContent);
                    for (_i = 0, configRaws_1 = configRaws; _i < configRaws_1.length; _i++) {
                        configRaw = configRaws_1[_i];
                        if (!configRaw.bundleDirName) {
                            configRaw.bundleDirName = configRaw.bundleName;
                        }
                        // Ensure excludeFileNames and excludeFunctionNames are arrays
                        for (_a = 0, _b = configRaw.facades; _a < _b.length; _a++) {
                            facade = _b[_a];
                            if (!facade.excludeFileNames) {
                                facade.excludeFileNames = [];
                            }
                            if (!facade.excludeFunctionNames) {
                                facade.excludeFunctionNames = [];
                            }
                        }
                    }
                    config = configRaws;
                    return [2 /*return*/, config];
                case 2:
                    err_1 = _c.sent();
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
function traverseASTs(ast, facadeObjects, origin, facade) {
    if (ast.type === 'FunctionDefinition' && ast.isConstructor === false) {
        extractFunctions(ast, facadeObjects.functions, origin, facade);
    }
    else if (ast.type === 'ContractDefinition') {
        // Traverse contract sub-nodes
        for (var _i = 0, _a = ast.subNodes; _i < _a.length; _i++) {
            var subNode = _a[_i];
            traverseASTs(subNode, facadeObjects, origin, facade);
        }
    }
    else if (ast.type === 'SourceUnit') {
        // Traverse source unit nodes
        for (var _b = 0, _c = ast.children; _b < _c.length; _b++) {
            var child = _c[_b];
            traverseASTs(child, facadeObjects, origin, facade);
        }
    }
    else if (ast.type === 'CustomErrorDefinition') {
        extractErrors(ast, facadeObjects.errors, origin);
    }
    else if (ast.type === 'EventDefinition') {
        extractEvents(ast, facadeObjects.events, origin);
    }
}
function extractErrors(ast, errors, origin) {
    var error = {
        name: ast.name,
        parameters: ast.parameters
            .map(function (param) { return getParameter(param); })
            .join(', '),
        origin: origin
    };
    errors.push(error);
}
function extractEvents(ast, events, origin) {
    var event = {
        name: ast.name,
        parameters: ast.parameters
            .map(function (param) { return getParameter(param); })
            .join(', '),
        origin: origin
    };
    events.push(event);
}
function extractFunctions(ast, functions, origin, facade) {
    // Skip functions based on the criteria
    if (!ast.name || // Skip unnamed functions (constructor, fallback, receive)
        ast.name.startsWith('test') ||
        ast.name === 'setUp' ||
        ast.visibility === 'private' ||
        ast.visibility === 'internal' ||
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
function generateFacadeContract(objects, facade, config) {
    return __awaiter(this, void 0, void 0, function () {
        var facadeFilePath, code, _i, _a, file, _b, _c, error, _d, _e, event_1, _f, _g, func;
        return __generator(this, function (_h) {
            switch (_h.label) {
                case 0:
                    facadeFilePath = path.join(outputDir, "".concat(facade.name, ".sol"));
                    code = "\n// SPDX-License-Identifier: MIT\npragma solidity ^0.8.24;\n\nimport {Schema} from \"src/".concat(config.bundleDirName, "/storage/Schema.sol\";\n");
                    for (_i = 0, _a = objects.files; _i < _a.length; _i++) {
                        file = _a[_i];
                        code += "import {".concat(file.name, "} from \"").concat(file.origin, "\";\n");
                    }
                    code += "\ncontract ".concat(facade.name, " is Schema, ").concat(objects.files.map(function (file) { return file.name; }).join(', '), " {\n");
                    for (_b = 0, _c = objects.errors; _b < _c.length; _b++) {
                        error = _c[_b];
                        code += generateError(error);
                    }
                    code += "\n";
                    for (_d = 0, _e = objects.events; _d < _e.length; _d++) {
                        event_1 = _e[_d];
                        code += generateEvent(event_1);
                    }
                    code += "\n";
                    for (_f = 0, _g = objects.functions; _f < _g.length; _f++) {
                        func = _g[_f];
                        code += generateFunctionSignature(func);
                    }
                    code += "}\n";
                    // Write the facade contract to the output file
                    return [4 /*yield*/, fs.writeFile(facadeFilePath, code)];
                case 1:
                    // Write the facade contract to the output file
                    _h.sent();
                    console.log("Facade contract generated at ".concat(facadeFilePath));
                    return [2 /*return*/];
            }
        });
    });
}
function generateError(error) {
    return "    error ".concat(error.name, "(").concat(error.parameters, ");\n");
}
function generateEvent(event) {
    return "    event ".concat(event.name, "(").concat(event.parameters, ");\n");
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

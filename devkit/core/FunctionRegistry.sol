// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core Type
import {Function} from "devkit/core/Function.sol";
// Core Method
import {FunctionRegistryLib} from "devkit/method/core/FunctionRegistryLib.sol";
// Support Method
import {ProcessLib} from "devkit/method/debug/ProcessLib.sol";


/**===========================
    📗 Functions Registry
=============================*/
struct FunctionRegistry {
    mapping(string name => Function) customs;
    string currentName;
}
using FunctionRegistryLib for FunctionRegistry global;
//  Support Methods
using ProcessLib for FunctionRegistry global;

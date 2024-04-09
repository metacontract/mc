// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core Type
import {Function} from "devkit/core/Function.sol";
// Methods
import {FunctionRegistryLib} from "devkit/method/core/FunctionRegistryLib.sol";
import {ProcessLib} from "devkit/method/debug/ProcessLib.sol";


/**===========================
    📗 Functions Registry
=============================*/
struct FunctionRegistry {
    mapping(bytes32 nameHash => Function) customs;
    string currentName;
}
using FunctionRegistryLib for FunctionRegistry global;
//  Support Methods
using ProcessLib for FunctionRegistry global;

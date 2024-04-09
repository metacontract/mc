// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core Type
import {Dictionary} from "./Dictionary.sol";
// Core Method
import {DictionaryRegistryLib} from "devkit/method/core/DictionaryRegistryLib.sol";
// Support Methods
import {ProcessLib} from "devkit/method/debug/ProcessLib.sol";
import {Inspector} from "devkit/method/inspector/Inspector.sol";


/**============================
    📘 Dictionary Registry
==============================*/
struct DictionaryRegistry {
    mapping(bytes32 nameHash => Dictionary) deployed;
    mapping(bytes32 nameHash => Dictionary) mocks;
    Dictionary currentDictionary;
}
using DictionaryRegistryLib for DictionaryRegistry global;
//  Support Methods
using ProcessLib for DictionaryRegistry global;
using Inspector for DictionaryRegistry global;

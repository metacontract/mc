// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core Types
import {Dictionary} from "./Dictionary.sol";
// Methods
import {DictionaryRegistryLib} from "devkit/method/core/DictionaryRegistryLib.sol";
import {ProcessLib} from "devkit/method/debug/ProcessLib.sol";


/******************************
    📚 Dictionary Registry
*******************************/
struct DictionaryRegistry {
    mapping(bytes32 nameHash => Dictionary) deployed;
    mapping(bytes32 nameHash => Dictionary) mocks;
    Dictionary currentDictionary;
}
using DictionaryRegistryLib for DictionaryRegistry global;
using ProcessLib for DictionaryRegistry global;

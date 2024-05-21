// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

// Core
import {Function} from "devkit/core/Function.sol";
// External Lib
import {Dictionary} from "@ucs.mc/dictionary/Dictionary.sol";

/**
    @title Mock Dictionary Contract
 */
contract MockDictionary is Dictionary {
    constructor (address owner, Function[] memory functions) Dictionary(owner) {
        for (uint i; i < functions.length; ++i) {
            _setImplementation(functions[i].selector, functions[i].implementation);
        }
    }
}

// TODO DictionaryWithPermissionsMock.sol

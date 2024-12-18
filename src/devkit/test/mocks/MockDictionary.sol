// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

// Core
import {Function} from "@mc-devkit/core/Function.sol";
// External Lib
import {Dictionary} from "@ucs.mc/dictionary/Dictionary.sol";

/**
 * @title Mock Dictionary Contract
 */
contract MockDictionary is Dictionary {
    constructor(address owner, Function[] memory functions) Dictionary(owner) {
        for (uint256 i; i < functions.length; ++i) {
            _setImplementation(functions[i].selector, functions[i].implementation);
        }
    }
}

// TODO DictionaryWithPermissionsMock.sol

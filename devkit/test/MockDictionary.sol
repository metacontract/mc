// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core
import {Function} from "devkit/core/Function.sol";
// External Lib
import {DictionaryEtherscan} from "@ucs.mc/dictionary/DictionaryEtherscan.sol";

/**
    @title Mock Dictionary Contract
 */
contract MockDictionary is DictionaryEtherscan {
    constructor (address owner, Function[] memory functions) DictionaryEtherscan(owner) {
        for (uint i; i < functions.length; ++i) {
            setImplementation(functions[i].selector, functions[i].implementation);
        }
    }
}

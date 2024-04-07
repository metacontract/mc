// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core
import {Function} from "../core/functions/Function.sol";
// External Lib
import {DictionaryEtherscan} from "@ucs.mc/dictionary/DictionaryEtherscan.sol";

/**
    @title Mock Dictionary Contract
 */
contract MockDictionary is DictionaryEtherscan {
    constructor (address owner, Function[] memory functionInfos) DictionaryEtherscan(owner) {
        for (uint i; i < functionInfos.length; ++i) {
            setImplementation(functionInfos[i].selector, functionInfos[i].implementation);
        }
    }
}

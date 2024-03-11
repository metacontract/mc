// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core
import {FuncInfo} from "@devkit/core/functions/FuncInfo.sol";
// External Lib
import {DictionaryEtherscan} from "@ucs-contracts/src/dictionary/DictionaryEtherscan.sol";

/**
    @title Mock Dictionary Contract
 */
contract MockDictionary is DictionaryEtherscan {
    constructor (address owner, FuncInfo[] memory functionInfos) DictionaryEtherscan(owner) {
        for (uint i; i < functionInfos.length; ++i) {
            setImplementation(functionInfos[i].selector, functionInfos[i].implementation);
        }
    }
}

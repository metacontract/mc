// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {DictionaryEtherscan} from "@ucs-contracts/src/dictionary/DictionaryEtherscan.sol";
import {FuncInfo} from "../../functions/FuncInfo.sol";

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

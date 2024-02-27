// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {DictionaryEtherscan} from "@ucs-contracts/src/dictionary/DictionaryEtherscan.sol";
import {Op} from "dev-env/UCSDevEnv.sol";

/**
    @title Mock Dictionary Contract
 */
contract MockDictionary is DictionaryEtherscan {
    constructor (address owner, Op[] memory ops) DictionaryEtherscan(owner) {
        for (uint i; i < ops.length; ++i) {
            setImplementation(ops[i].selector, ops[i].implementation);
        }
    }
}

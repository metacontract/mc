// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {IGetDeps} from "../interfaces/functions/IGetDeps.sol";

import {ERC7546Utils} from "@ucs-contracts/src/proxy/ERC7546Utils.sol";
import {DictionaryBase} from "@ucs-contracts/src/dictionary/DictionaryBase.sol";

/**
    < MC Standard Function >
    @title GetDeps
    @custom:version 0.1.0
    @custom:schema v0.1.0
 */
contract GetDeps is IGetDeps {
    /// DO NOT USE STORAGE DIRECTLY !!!

    function getDeps() external view returns(Op[] memory) {
        DictionaryBase dictionary = DictionaryBase(ERC7546Utils.getDictionary()); // TODO IDictionary
        bytes4[] memory selectors = dictionary.supportsInterfaces();
        Op[] memory ops = new Op[](selectors.length);
        for (uint i; i < selectors.length; ++i) {
            ops[i].selector = selectors[i];
            ops[i].implementation = dictionary.getImplementation(selectors[i]);
        }
        return ops;
    }
}

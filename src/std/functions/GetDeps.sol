// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Dep} from "../storage/Schema.sol";

import {ERC7546Utils} from "@ucs.mc/proxy/ERC7546Utils.sol";
import {DictionaryBase} from "@ucs.mc/dictionary/DictionaryBase.sol";

/**
    < MC Standard Function >
    @title GetDeps
    @custom:version 0.1.0
    @custom:schema v0.1.0
 */
contract GetDeps {
    /// DO NOT USE STORAGE DIRECTLY !!!

    function getDeps() external view returns(Dep[] memory) {
        DictionaryBase dictionary = DictionaryBase(ERC7546Utils.getDictionary()); // TODO IDictionary
        bytes4[] memory selectors = dictionary.supportsInterfaces();
        Dep[] memory deps = new Dep[](selectors.length);
        for (uint i; i < selectors.length; ++i) {
            deps[i].selector = selectors[i];
            deps[i].implementation = dictionary.getImplementation(selectors[i]);
        }
        return deps;
    }
}

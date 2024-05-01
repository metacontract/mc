// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Dep} from "../storage/Schema.sol";

import {ProxyUtils} from "@ucs.mc/proxy/ProxyUtils.sol";
import {IDictionary} from "@ucs.mc/dictionary/IDictionary.sol";

/** < MC Standard Function >
 *  @title GetDeps
 *  @custom:version v0.1.0
 *  @custom:schema none
 */
contract GetDeps {
    /// DO NOT USE STORAGE DIRECTLY !!!

    function getDeps() external view returns(Dep[] memory) {
        IDictionary dictionary = IDictionary(ProxyUtils.getDictionary());
        bytes4[] memory selectors = dictionary.supportsInterfaces();
        Dep[] memory deps = new Dep[](selectors.length);
        for (uint i; i < selectors.length; ++i) {
            deps[i].selector = selectors[i];
            deps[i].implementation = dictionary.getImplementation(selectors[i]);
        }
        return deps;
    }
}

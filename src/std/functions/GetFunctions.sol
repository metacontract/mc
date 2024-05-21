// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ProxyUtils} from "@ucs.mc/proxy/ProxyUtils.sol";
import {IDictionary} from "@ucs.mc/dictionary/interfaces/IDictionary.sol";

/** < MC Standard Function >
 *  @title GetFunctions
 *  @custom:version v0.1.0
 *  @custom:schema none
 */
contract GetFunctions {
    /// DO NOT USE STORAGE DIRECTLY !!!
    struct Function {
        bytes4 selector;
        address implementation;
    }

    function getFunctions() external view returns(Function[] memory) {
        IDictionary dictionary = IDictionary(ProxyUtils.getDictionary());
        bytes4[] memory selectors = dictionary.supportsInterfaces();
        Function[] memory deps = new Function[](selectors.length);
        for (uint i; i < selectors.length; ++i) {
            deps[i].selector = selectors[i];
            deps[i].implementation = dictionary.getImplementation(selectors[i]);
        }
        return deps;
    }
}

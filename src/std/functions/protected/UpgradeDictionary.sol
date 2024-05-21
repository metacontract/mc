// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {ProxyUtils} from "@ucs.mc/proxy/ProxyUtils.sol";
import {ProtectionBase} from "./protection/ProtectionBase.sol";

/**
    < MC Standard Function >
    @title UpgradeDictionary
    @custom:version 0.1.0
    @custom:schema v0.1.0
 */
contract UpgradeDictionary is ProtectionBase {
    /// DO NOT USE STORAGE DIRECTLY !!!

    function upgradeDictionary(address newDictionary) external onlyAdmin {
        ProxyUtils.upgradeDictionaryToAndCall({
            newDictionary: newDictionary,
            data: ""
        });
    }
}

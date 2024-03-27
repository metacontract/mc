// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {ERC7546Utils} from "@ucs-contracts/src/proxy/ERC7546Utils.sol";
import {ProtectionBase} from "./utils/ProtectionBase.sol";

/**
    < MC Standard Function >
    @title UpgradeDictionary
    @custom:version 0.1.0
    @custom:schema v0.1.0
 */
contract UpgradeDictionary is ProtectionBase {
    /// DO NOT USE STORAGE DIRECTLY !!!

    function upgradeDictionary(address newDictionary) external onlyAdmin {
        ERC7546Utils.upgradeDictionaryToAndCall({
            newDictionary: newDictionary,
            data: ""
        });
    }
}

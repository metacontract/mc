// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

// storage
import {Storage} from "../../storage/Storage.sol";

import {ProtectionBase} from "./protection/ProtectionBase.sol";

/**
    < MC Standard Function >
    @title FeatureToggle
    @custom:version 0.1.0
    @custom:schema v0.1.0
 */
contract FeatureToggle is ProtectionBase {
    /// DO NOT USE STORAGE DIRECTLY !!!

    function featureToggle(bytes4 selector) external onlyAdmin {
        Storage.FeatureToggle().disabledFeature[selector] = !Storage.FeatureToggle().disabledFeature[selector];
    }

}

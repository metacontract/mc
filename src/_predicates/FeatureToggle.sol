// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {StorageRef} from "../std/storages/StorageRef.sol";
import {console2} from "forge-std/console2.sol";

library FeatureToggle {
    error FeatureNotActive();
    function shouldBeActive(bytes4 selector) internal view {
        if (StorageRef.FeatureToggle().disabledFeature[selector] == true) revert FeatureNotActive();
    }
}

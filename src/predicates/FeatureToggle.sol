// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {StorageLib} from "../StorageLib.sol";
import {console2} from "forge-std/console2.sol";

library FeatureToggle {
    error FeatureNotActive();
    function shouldBeActive(bytes4 selector) internal view {
        if (StorageLib.$FeatureToggle().disabledFeature[selector] == true) revert FeatureNotActive();
    }
}

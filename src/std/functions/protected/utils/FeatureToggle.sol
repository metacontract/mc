// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Storage} from "../../../storage/Storage.sol";

library FeatureToggle {
    error FeatureNotActive();
    function shouldBeActive(bytes4 selector) internal view {
        if (Storage.FeatureToggle().disabledFeature[selector] == true) revert FeatureNotActive();
    }
}

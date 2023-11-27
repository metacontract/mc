// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {console2} from "forge-std/console2.sol";

// predicates
import {UsePredicates} from "../../src/UsePredicates.sol";

// storage
import {StorageLib} from "../../src/StorageLib.sol";

contract Initialize is UsePredicates {
    /// NO DIRECT STORAGE USAGE !!!

    function __pre_conditions__() internal view override {
        console2.log("Before execution...");
    }

    function __post_conditions__() internal override {
        console2.log("AFTER execution...");
    }

    function initialize(address newOwner) public predicates {
        StorageLib.getOwnerStorage().owner = newOwner;
    }
}

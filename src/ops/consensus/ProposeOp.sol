// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

// predicates
import {MsgSender} from "../../predicates/MsgSender.sol";

// storage
// import {StorageLib} from "predicates-lib/StorageLib.sol";

import {console2} from "forge-std/console2.sol";

contract ProposeOp {
    /// DO NOT USE STORAGE DIRECTLY !!!

    modifier requires() {
        MsgSender.shouldBeOwner();
        console2.log("Before execution...");
        _;
    }

    modifier intents() {
        _;
        console2.log("AFTER execution...");
    }

    function propose() public requires intents {
        console2.log("Executing propose...");
    }
}

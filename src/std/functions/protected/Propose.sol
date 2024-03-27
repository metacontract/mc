// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

// predicates
import {MsgSender} from "./utils/MsgSender.sol";

// storage
import {Storage} from "../../storage/Storage.sol";

import {IPropose} from "../../interfaces/functions/IPropose.sol";

import {console2} from "forge-std/console2.sol";

contract Propose is IPropose {
    /// DO NOT USE STORAGE DIRECTLY !!!

    modifier requires() {
        MsgSender.shouldBeMember();
        console2.log("Before execution...");
        _;
    }

    modifier intents() {
        _;
        console2.log("AFTER execution...");
    }

    function propose() public requires intents {
        // StorageLib.$Proposal().proposals.push(proposal);
    }
}

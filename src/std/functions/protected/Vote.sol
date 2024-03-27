// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

// predicates
import {MsgSender} from "./protection/MsgSender.sol";

// storage
// import {StorageLib, Proposal} from "../../StorageLib.sol";

import {IVote} from "../../interfaces/functions/IVote.sol";

import {console2} from "forge-std/console2.sol";

contract Vote is IVote {
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

    function vote() public requires intents {
    }
}

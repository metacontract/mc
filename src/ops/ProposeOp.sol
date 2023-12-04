// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

// predicates
import {MsgSender} from "../predicates/MsgSender.sol";

// storage
import {StorageLib, Proposal} from "../StorageLib.sol";

import {IProposeOp} from "../interfaces/ops/IProposeOp.sol";

import {console2} from "forge-std/console2.sol";

contract ProposeOp is IProposeOp {
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

    function propose(Proposal calldata proposal) public requires intents {
        StorageLib.$Proposal().proposals.push(proposal);
    }
}

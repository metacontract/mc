// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

// predicates
import {MsgSender} from "../predicates/MsgSender.sol";

// storage
import {StorageLib} from "../StorageLib.sol";

import {ERC7546Clones} from "@ucs-contracts/ERC7546Clones.sol";

import {ICloneOp} from "../interfaces/ops/ICloneOp.sol";

import {console2} from "forge-std/console2.sol";

contract CloneOp is ICloneOp {
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

    function clone(bytes calldata initData) external returns (address) {
        return ERC7546Clones.clone(StorageLib.$Clones().dictionary, initData);
    }

}

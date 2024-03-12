// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

// predicates
import {MsgSender} from "../../_predicates/MsgSender.sol";

// storage
import {StorageRef} from "../storages/StorageRef.sol";

import {ERC7546Clones} from "@ucs-contracts/src/ERC7546Clones.sol";
import {ERC7546Utils} from "@ucs-contracts/src/proxy/ERC7546Utils.sol";

import {IClone} from "../interfaces/functions/IClone.sol";

import {console2} from "forge-std/console2.sol";

contract Clone is IClone {
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
        return ERC7546Clones.clone(ERC7546Utils.getDictionary(), initData);
    }

}

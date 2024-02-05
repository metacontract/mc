// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// storage
import {StorageLib} from "../StorageLib.sol";
import {ISetAdminOp} from "../interfaces/ops/ISetAdminOp.sol";

// predicates
import {MsgSender} from "../predicates/MsgSender.sol";

contract SetAdminOp is ISetAdminOp {
    /// DO NOT USE STORAGE DIRECTLY !!!

    modifier requires() {
        MsgSender.shouldBeAdmin();
        _;
    }

    modifier intents() {
        _;
    }

    function setAdmin(address admin) external requires intents {
        StorageLib.$Admin().admin = admin;

    }
}

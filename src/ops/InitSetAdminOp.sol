// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

// storage
import {StorageLib} from "../StorageLib.sol";
import {ISetAdminOp} from "../interfaces/ops/ISetAdmin.sol";

// predicates
import {MsgSender} from "../predicates/MsgSender.sol";

contract InitSetAdminOp {
    /// DO NOT USE STORAGE DIRECTLY !!!

    modifier requires() {
        _;
    }

    modifier intents() {
        _;
    }

    function initSetAdmin(address admin) external requires intents {
        StorageLib.$Admin().admin = admin;

    }
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// storage
import {Storage} from "../storage/Storage.sol";
import {ISetAdmin} from "../interfaces/functions/ISetAdmin.sol";

// predicates
import {MsgSender} from "../../_predicates/MsgSender.sol";

contract SetAdmin is ISetAdmin {
    /// DO NOT USE STORAGE DIRECTLY !!!

    modifier requires() {
        MsgSender.shouldBeAdmin();
        _;
    }

    modifier intents() {
        _;
    }

    function setAdmin(address admin) external requires intents {
        Storage.Admin().admin = admin;

    }
}

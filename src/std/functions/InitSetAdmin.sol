// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// storage
import {StorageRef} from "../storages/StorageRef.sol";
import {IInitSetAdmin} from "../interfaces/functions/IInitSetAdmin.sol";

// predicates
import {Initialization} from "../../_predicates/Initialization.sol";

contract InitSetAdmin is IInitSetAdmin {
    /// DO NOT USE STORAGE DIRECTLY !!!

    modifier requires() {
        Initialization.shouldNotBeCompleted();
        _;
    }

    modifier intents(address admin) {
        _;
        assert(StorageRef.Admin().admin == admin);
        Initialization.willBeCompleted();
    }

    function initSetAdmin(address admin) external requires intents(admin) {
        StorageRef.Admin().admin = admin;
        emit AdminSet(admin);
    }
}

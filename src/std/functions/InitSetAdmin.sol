// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// storage
import {Storage} from "../storage/Storage.sol";
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
        assert(Storage.Admin().admin == admin);
        Initialization.willBeCompleted();
    }

    function initSetAdmin(address admin) external requires intents(admin) {
        Storage.Admin().admin = admin;
        emit AdminSet(admin);
    }
}

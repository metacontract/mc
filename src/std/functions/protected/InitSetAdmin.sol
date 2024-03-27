// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {IInitSetAdmin} from "../../interfaces/functions/IInitSetAdmin.sol";

// storage
import {Storage} from "../../storage/Storage.sol";

// predicates
import {Initialization} from "./utils/Initialization.sol";

/**
    < MC Standard Function >
    @title InitSetAdmin
    @custom:version 0.1.0
    @custom:schema v0.1.0
 */
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

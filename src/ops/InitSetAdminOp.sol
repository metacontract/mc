// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// storage
import {StorageLib} from "../StorageLib.sol";
import {IInitSetAdminOp} from "../interfaces/ops/IInitSetAdminOp.sol";

// predicates
import {Initialization} from "../predicates/Initialization.sol";

contract InitSetAdminOp is IInitSetAdminOp {
    /// DO NOT USE STORAGE DIRECTLY !!!

    modifier requires() {
        Initialization.shouldNotBeCompleted();
        _;
    }

    modifier intents(address admin) {
        _;
        assert(StorageLib.$Admin().admin == admin);
        Initialization.willBeCompleted();
    }

    function initSetAdmin(address admin) external requires intents(admin) {
        StorageLib.$Admin().admin = admin;
        emit AdminSet(admin);
    }
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {StorageRef} from "../std/storages/StorageRef.sol";

library Initialization {
    error InvalidInitialization();

    function shouldNotBeCompleted() internal view {
        if (StorageRef.Initialization().initialized != 0) revert InvalidInitialization();
    }

    event Initialized(uint64 version);
    function willBeCompleted() internal {
        StorageRef.Initialization().initialized = 1;
        emit Initialized(1);
    }
}

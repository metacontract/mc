// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {StorageLib} from "../StorageLib.sol";

library Initialization {
    error InvalidInitialization();

    function shouldNotBeCompleted() internal view {
        if (StorageLib.$Initialization().initialized != 0) revert InvalidInitialization();
    }

    event Initialized(uint64 version);
    function willBeCompleted() internal {
        StorageLib.$Initialization().initialized = 1;
        emit Initialized(1);
    }
}

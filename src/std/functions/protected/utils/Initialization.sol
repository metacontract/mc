// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Storage} from "../../../storage/Storage.sol";

library Initialization {
    error InvalidInitialization();
    function shouldNotBeCompleted() internal view {
        if (Storage.Initialization().initialized != 0) revert InvalidInitialization();
    }

    event Initialized(uint64 version);
    function willBeCompleted() internal {
        Storage.Initialization().initialized = 1;
        emit Initialized(1);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core Types
import {Bundle} from "devkit/core/types/Bundle.sol";
// Support Method
import {ProcessLib} from "devkit/core/method/debug/ProcessLib.sol";
    using ProcessLib for StdBundle global;
import {TypeGuard, TypeStatus} from "devkit/core/types/TypeGuard.sol";
    using TypeGuard for StdBundle global;


/**==========================
    🗼 Standard Bundle
============================*/
struct StdBundle {
    TypeStatus status;
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Initialization} from "./Initialization.sol";
import {MsgSender} from "./MsgSender.sol";

abstract contract ProtectionBase {
    modifier initializer() {
        Initialization.shouldNotBeCompleted();
        _;
        Initialization.willBeCompleted();
    }

    modifier onlyAdmin() {
        MsgSender.shouldBeMember();
        _;
    }
}

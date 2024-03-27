// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {CommonBase} from "forge-std/Base.sol";

import {MCDevKit} from "./MCDevKit.sol";

abstract contract MCBase is CommonBase {
    MCDevKit internal mc;
    uint256 internal deployerKey;
    address internal deployer;
}

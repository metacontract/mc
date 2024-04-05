// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {CommonBase} from "forge-std/Base.sol";

import {MCDevKit} from "devkit/global/MCDevKit.sol";

import {Config} from "./Config.sol";

abstract contract MCBase is CommonBase {
    MCDevKit internal mc;
    uint256 internal deployerKey;
    address internal deployer;

    constructor() {
        if (Config.DEBUG_MODE) mc.startDebug();
        if (Config.SETUP_STD_FUNCS) mc.setupStdFuncs();
    }
}

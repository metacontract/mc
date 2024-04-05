// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {MCDevKit} from "devkit/MCDevKit.sol";

abstract contract MCDevKitTest is Test {
    MCDevKit internal mc;
    function setUp() public {
        mc.stopLog();
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKitTest} from "devkit/MCTest.sol";
import {DeployLib} from "script/DeployLib.sol";
import {MCDevKit} from "devkit/MCDevKit.sol";

import {Clone} from "mc-std/functions/Clone.sol";

contract StdTest is MCDevKitTest {
    using DeployLib for MCDevKit;
    function setUp() public  {
// mc.startDebug();
    }

    function test_Success_DeployStdFunctions() public startPrankWith("TEST_DEPLOYER") {
        mc.deployStdFunctions();
        mc.std.complete();
        // mc.init("STD").use(mc.std.functions.initSetAdmin).deploy();
        mc.deploy(mc.std.all, deployer, "");
        // mc.deploy("STD", mc.std.all, deployer, "");
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKitTest} from "devkit/MCTest.sol";
import {DeployLib} from "script/DeployLib.sol";
import {MCDevKit} from "devkit/global/MCDevKit.sol";

import {Clone} from "mc-std/functions/Clone.sol";

contract StdTest is MCDevKitTest {
    using DeployLib for MCDevKit;
    function setUp() public  {
    }

    function test_Success_DeployStdFunctions() public startPrankWith("TEST_DEPLOYER") {
        mc.deployStdIfNotExists();
    }
}

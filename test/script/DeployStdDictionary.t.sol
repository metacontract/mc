// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {MCTestBase, MCDevKit} from "devkit/Flattened.sol";
import {DeployLib} from "../../script/DeployLib.sol";

contract DeployStdDictionaryTest is MCTestBase {
    using DeployLib for MCDevKit;

    function setUp() public {
        mc.std.functions.fetch();
    }

    function test_Run_Success() public startPrankWith("DEPLOYER_PRIV_KEY") {
        mc.deployStdDictionary();
    }

}

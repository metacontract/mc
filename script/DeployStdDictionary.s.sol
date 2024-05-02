// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCScriptBase} from "devkit/MCBase.sol";
import {DeployLib} from "./DeployLib.sol";
import {MCDevKit} from "devkit/MCDevKit.sol";

contract DeployStdDictionary is MCScriptBase {
    using DeployLib for MCDevKit;

    function setUp() public {
        mc.std.functions.fetch();
    }

    function run() public startBroadcastWith("DEPLOYER_PRIV_KEY") {
        mc.deployStdDictionary();
    }
}

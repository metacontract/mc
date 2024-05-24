// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {MCScriptBase, MCDevKit} from "devkit/Flattened.sol";
import {DeployLib} from "./DeployLib.sol";

contract DeployStdDictionary is MCScriptBase {
    using DeployLib for MCDevKit;

    function setUp() public {
        mc.std.functions.fetch();
    }

    function run() public startBroadcastWith("DEPLOYER_PRIV_KEY") {
        mc.deployStdDictionary();
    }
}

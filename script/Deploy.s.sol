// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCScriptWithoutSetup} from "devkit/MCScript.sol";
import {DeployLib} from "./DeployLib.sol";
import {MCDevKit} from "devkit/global/MCDevKit.sol";

contract DeployScript is MCScriptWithoutSetup {
    using DeployLib for MCDevKit;

    function run() public startBroadcastWith("DEPLOYER_PRIV_KEY") {
        mc.deployStd();
    }
}

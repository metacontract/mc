// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCScript} from "devkit/MCScript.sol";
import {DeployLib} from "./DeployLib.sol";
import {MCDevKit} from "devkit/global/MCDevKit.sol";

contract DeployScript is MCScript {
    using DeployLib for MCDevKit;

    function run() public startBroadcastWith("DEPLOYER_PRIV_KEY") {
        mc.deployStd();
    }
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {MCDevKit} from "devkit/MCDevKit.sol";
import {MCScript} from "devkit/MCScript.sol";
import {DeployLib} from "./DeployLib.sol";

contract DeployScript is MCScript {
    using DeployLib for MCDevKit;

    function run() public startBroadcastWith("DEPLOYER_PRIV_KEY") {
        mc.deployStd();
    }
}

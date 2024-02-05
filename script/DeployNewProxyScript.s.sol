// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {UCSScriptBase} from "../utils/UCSScriptBase.sol";

contract DeployNewProxyScript is UCSScriptBase {
    function setUp() public startBroadcastWithDeployerPrivKey {}

    function run() public {
        address proxy = newProxy();
    }
}

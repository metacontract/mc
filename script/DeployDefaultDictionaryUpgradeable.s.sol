// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {UCSScriptBase} from "../utils/UCSScriptBase.sol";

contract DeployDefaultDictionaryUpgradeableEtherscanScript is UCSScriptBase {
    function setUp() public startBroadcastWithDeployerPrivKey {}

    function run() public {
        address dictionary = deployDeafultDictionaryUpgradeableEtherscan();
    }
}

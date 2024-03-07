// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCScript} from "DevKit/MCScript.sol";
// import {UCSContractList} from "utils/common/UCSTypes.sol";
import "DevKit/MCDevKit.sol";

// import {UCSDeployUtils} from "../utils/UCSDeployUtils.sol";

contract DeployDefaultDictionaryUpgradeableEtherscanScript is MCScript {
    // using UCSDeployUtils for UCSDeployUtils.UCS;
    function setUp() public startBroadcastWithDeployerPrivKey {}

    function run() public {
        // address dictionary = mc.deployDeafultDictionaryUpgradeableEtherscan();
        // address dictionary = mc.deploy(UCSContractList.DeafultDictionaryUpgradeableEtherscan);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {UCSDeployBase} from "./UCSDeployBase.sol";

abstract contract UCSScriptBase is UCSDeployBase, Script {
    modifier startBroadcastWithDeployerPrivKey() {
        deployerKey = getPrivateKey("DEPLOYER_PRIV_KEY");
        deployer = vm.addr(deployerKey);
        vm.startBroadcast(deployerKey);
        _;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// 💬 ABOUT
// Meta Contract's default Script based on Forge Std Script

// 🛠 FORGE STD
import {Script as ForgeScript} from "forge-std/Script.sol";

// 📦 BOILERPLATE
import {MCScriptBase} from "@devkit/MCBase.sol";

// ⭐️ MC SCRIPT
abstract contract MCScript is MCScriptBase, ForgeScript {
    modifier startBroadcastWithDeployerPrivKey() {
        deployerKey = getPrivateKey("DEPLOYER_PRIV_KEY");
        deployer = vm.addr(deployerKey);
        vm.startBroadcast(deployerKey);
        _;
    }
}

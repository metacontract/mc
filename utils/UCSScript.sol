// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// 💬 ABOUT
// UCS's default Script based on Forge Std Script

// 🛠 FORGE STD
import {Script as ForgeScript} from "forge-std/Script.sol";

// 📦 BOILERPLATE
import {UCSScriptBase} from "./UCSBase.sol";

// ⭐️ UCS SCRIPT
abstract contract UCSScript is UCSScriptBase, ForgeScript {
    modifier startBroadcastWithDeployerPrivKey() {
        deployerKey = getPrivateKey("DEPLOYER_PRIV_KEY");
        deployer = vm.addr(deployerKey);
        vm.startBroadcast(deployerKey);
        _;
    }
}

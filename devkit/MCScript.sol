// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// 💬 ABOUT
// Meta Contract's default Script based on Forge Std Script

// 🛠 FORGE STD
import {Script as ForgeScript} from "forge-std/Script.sol";

// 📦 BOILERPLATE
import {MCScriptBase} from "./MCBase.sol";

// ⭐️ MC SCRIPT
abstract contract MCScript is MCScriptBase, ForgeScript {
    modifier startBroadcastWith(string memory envKey) {
        _startBroadcastWith(envKey);
        _;
    }

    modifier startBroadcastWithDeployerPrivKey() {
        _startBroadcastWith("DEPLOYER_PRIV_KEY");
        _;
    }

    function _startBroadcastWith(string memory envKey) internal {
        deployerKey = getPrivateKey("DEPLOYER_PRIV_KEY");
        deployer = vm.addr(deployerKey);
        vm.startBroadcast(deployerKey);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ForgeHelper} from "./utils/ForgeHelper.sol";
import {Config} from "./Config.sol";

// 💬 ABOUT
// Meta Contract's default Script based on Forge Std Script

// 🛠 FORGE STD
import {Script as ForgeScript} from "forge-std/Script.sol";

// 📦 BOILERPLATE
import {MCBase} from "./MCBase.sol";

// ⭐️ MC SCRIPT
abstract contract MCScript is MCBase, ForgeScript {
    constructor() {
        if (Config.DEBUG_MODE) mc.startDebug();
        if (Config.USE_DEPLOYED_STD) mc.setupStdFuncs();
    }

    modifier startBroadcastWith(string memory envKey) {
        _startBroadcastWith(envKey);
        _;
    }

    modifier startBroadcastWithDeployerPrivKey() {
        _startBroadcastWith("DEPLOYER_PRIV_KEY");
        _;
    }

    function _startBroadcastWith(string memory envKey) internal {
        deployerKey = ForgeHelper.getPrivateKey("DEPLOYER_PRIV_KEY");
        deployer = vm.addr(deployerKey);
        vm.startBroadcast(deployerKey);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKit} from "devkit/MCDevKit.sol";

using SetupUtils for MCDevKit;
library SetupUtils {
    string constant LIB_NAME = "MCSetup";

/**********************************
    🏗 Setup
        🧩 Setup Standard Funcs
***********************************/
    function setupStdFuncs(MCDevKit storage mc) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("setupMCStdFuncs");
        mc.functions.std.assignAndLoad()
                        .deployIfNotExists()
                        .configureStdBundle();
        return mc.recordExecFinish(pid);
    }

}

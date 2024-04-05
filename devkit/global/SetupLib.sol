// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKit} from "devkit/MCDevKit.sol";

/**********************************
    🏗 Setup
        🧩 Setup Standard Funcs
***********************************/
library SetupLib {
    using SetupLib for MCDevKit;
    string constant LIB_NAME = "SetupLib";


    /**----------------------------
        🧩 Setup Standard Funcs
    ------------------------------*/
    function setupStdFuncs(MCDevKit storage mc) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("setupStdFuncs");
        mc.functions.std.assignAndLoad()
                        .deployIfNotExists()
                        .configureStdBundle();
        return mc.recordExecFinish(pid);
    }

}

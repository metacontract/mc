// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKit} from "devkit/global/MCDevKit.sol";

/**********************************
    🏗 Setup
        🧩 Setup Standard Funcs
***********************************/
library MCSetupLib {
    using MCSetupLib for MCDevKit;
    string constant LIB_NAME = "MCSetupLib";


    /**----------------------------
        🧩 Setup Standard Funcs
    ------------------------------*/
    function setupStdFunctions(MCDevKit storage mc) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("setupStdFunctions");
        mc.functions.std.assignAndLoad()
                        .deployIfNotExists()
                        .configureStdBundle();
        return mc.recordExecFinish(pid);
    }

}

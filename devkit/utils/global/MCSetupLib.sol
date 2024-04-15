// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKit} from "devkit/MCDevKit.sol";
import {System} from "devkit/system/System.sol";

/**********************************
    🏗 Setup
        🧩 Setup Standard Funcs
***********************************/
library MCSetupLib {
    function loadConfig(MCDevKit storage mc) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("loadConfig");
        System.Config().load();
        return mc.recordExecFinish(pid);
    }

    /**----------------------------
        🧩 Setup Standard Funcs
    ------------------------------*/
    function setupStdFunctions(MCDevKit storage mc) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("setupStdFunctions");
        mc.std.complete();
        return mc.recordExecFinish(pid);
    }

}

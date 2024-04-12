// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKit} from "devkit/MCDevKit.sol";
import {Config} from "devkit/config/Config.sol";
// Debug
import {Debugger} from "devkit/log/debug/Debugger.sol";
import {Logger} from "devkit/log/debug/Logger.sol";


/***********************************************
    🐞 Debug
        ▶️ Start
        🛑 Stop
        📩 Insert Log
        🔽 Record Start
        🔼 Record Finish
************************************************/
library MCDebugLib {
    string constant LIB_NAME = "MCDebugLib";

    /**---------------
        ▶️ Start
    -----------------*/
    function startDebug(MCDevKit storage mc) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("startDebug");
        if (Config().DEBUG_MODE) Debugger.startDebug();
        return mc.recordExecFinish(pid);
    }


    /**-------------
        🛑 Stop
    ---------------*/
    function stopLog(MCDevKit storage mc) internal returns(MCDevKit storage) {
        Debugger.stopLog();
        return mc;
    }


    /**-------------------
        📩 Insert Log
    ---------------------*/
    function insert(MCDevKit storage mc, string memory message) internal returns(MCDevKit storage) {
        Logger.insert(message);
        return mc;
    }


    /**--------------------
        🔽 Record Start
    ----------------------*/
    function recordExecStart(MCDevKit storage mc, string memory funcName, string memory params) internal returns(uint) {
        return Debugger.recordExecStart(LIB_NAME, funcName, params);
    }
    function recordExecStart(MCDevKit storage mc, string memory funcName) internal returns(uint) {
        return mc.recordExecStart(funcName, "");
    }


    /**---------------------
        🔼 Record Finish
    -----------------------*/
    function recordExecFinish(MCDevKit storage mc, uint pid) internal returns(MCDevKit storage) {
        Debugger.recordExecFinish(pid);
        return mc;
    }

}

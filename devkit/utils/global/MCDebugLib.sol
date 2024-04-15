// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKit} from "devkit/MCDevKit.sol";
import {System} from "devkit/system/System.sol";
// Debug
import {DebuggerLib} from "devkit/system/debug/Debugger.sol";
import {Logger} from "devkit/system/debug/Logger.sol";


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
        if (System.Config().DEBUG_MODE) System.Debug().startDebug();
        return mc.recordExecFinish(pid);
    }


    /**-------------
        🛑 Stop
    ---------------*/
    function stopLog(MCDevKit storage mc) internal returns(MCDevKit storage) {
        System.Debug().stopLog();
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
        return DebuggerLib.recordExecStart(LIB_NAME, funcName, params);
    }
    function recordExecStart(MCDevKit storage mc, string memory funcName) internal returns(uint) {
        return mc.recordExecStart(funcName, "");
    }


    /**---------------------
        🔼 Record Finish
    -----------------------*/
    function recordExecFinish(MCDevKit storage mc, uint pid) internal returns(MCDevKit storage) {
        DebuggerLib.recordExecFinish(pid);
        return mc;
    }

}

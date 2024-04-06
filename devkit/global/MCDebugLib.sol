// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKit} from "devkit/global/MCDevKit.sol";
// Debug
import {Debug} from "devkit/debug/Debug.sol";
import {Logger} from "devkit/debug/Logger.sol";


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
        Debug.startDebug();
        return mc;
    }


    /**-------------
        🛑 Stop
    ---------------*/
    function stopLog(MCDevKit storage mc) internal returns(MCDevKit storage) {
        Debug.stopLog();
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
        return Debug.recordExecStart(LIB_NAME, funcName, params);
    }
    function recordExecStart(MCDevKit storage mc, string memory funcName) internal returns(uint) {
        return mc.recordExecStart(funcName, "");
    }


    /**---------------------
        🔼 Record Finish
    -----------------------*/
    function recordExecFinish(MCDevKit storage mc, uint pid) internal returns(MCDevKit storage) {
        Debug.recordExecFinish(pid);
        return mc;
    }

}

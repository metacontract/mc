// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKit} from "devkit/MCDevKit.sol";
// Debug
import {Debug} from "devkit/debug/Debug.sol";
import {Logger} from "devkit/debug/Logger.sol";

using DebugLib for MCDevKit;
library DebugLib {
    string constant LIB_NAME = "MCDebug";

    /**----------------
        🐞 Debug
    ------------------*/
    function startDebug(MCDevKit storage mc) internal returns(MCDevKit storage) {
        Debug.startDebug();
        return mc;
    }
    function stopLog(MCDevKit storage mc) internal returns(MCDevKit storage) {
        Debug.stopLog();
        return mc;
    }
    function insert(MCDevKit storage mc, string memory message) internal returns(MCDevKit storage) {
        Logger.insert(message);
        return mc;
    }

    /**
        Record Start
     */
    function recordExecStart(MCDevKit storage, string memory funcName, string memory params) internal returns(uint) {
        return Debug.recordExecStart(LIB_NAME, funcName, params);
    }
    function recordExecStart(MCDevKit storage mc, string memory funcName) internal returns(uint) {
        return mc.recordExecStart(funcName, "");
    }

    /**
        Record Finish
     */
    function recordExecFinish(MCDevKit storage mc, uint pid) internal returns(MCDevKit storage) {
        Debug.recordExecFinish(pid);
        return mc;
    }

}

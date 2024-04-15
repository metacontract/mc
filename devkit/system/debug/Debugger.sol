// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Utils
import {console2, StdStyle} from "devkit/utils/ForgeHelper.sol";
    using StdStyle for string;
import {Logger} from "./Logger.sol";
import {System} from "devkit/system/System.sol";
import {Inspector} from "devkit/types/Inspector.sol";
    using Inspector for bool;


using DebuggerLib for DebuggerState global;
/// @custom:storage-location erc7201:mc.devkit.debugger
struct DebuggerState {
    Logger.LogLevel logLevel;
    string[] errorLocationStack;
    Process[] processes;
    uint nextPid;
}
    struct Process {
        string libName;
        string funcName;
        string params;
    }


/**=================\
|   🐞 Debugger     |
\==================*/
library DebuggerLib {

    /**-------------------------
        🕹️ Logging Control
    ---------------------------*/
    function startDebug(DebuggerState storage debugger) internal {
        setLogLevel(debugger, Logger.LogLevel.Debug);
    }
    function startInfo(DebuggerState storage debugger) internal {
        setLogLevel(debugger, Logger.LogLevel.Info);
    }
    function startWarn(DebuggerState storage debugger) internal {
        setLogLevel(debugger, Logger.LogLevel.Warn);
    }
    function startError(DebuggerState storage debugger) internal {
        setLogLevel(debugger, Logger.LogLevel.Error);
    }
    function startCritical(DebuggerState storage debugger) internal {
        setLogLevel(debugger, Logger.LogLevel.Critical);
    }
    function stopLog(DebuggerState storage debugger) internal {
        setLogLevel(debugger, Logger.LogLevel.Disable);
    }
    function setLogLevel(DebuggerState storage debugger, Logger.LogLevel level) internal {
        debugger.logLevel = level;
    }

    function isDisabled(DebuggerState storage debugger) internal returns(bool) {
        return debugger.logLevel == Logger.LogLevel.Disable;
    }
    function isDebug(DebuggerState storage debugger) internal returns(bool) {
        return debugger.logLevel == Logger.LogLevel.Debug;
    }
    function isInfo(DebuggerState storage debugger) internal returns(bool) {
        return debugger.logLevel == Logger.LogLevel.Info;
    }
    function isWarm(DebuggerState storage debugger) internal returns(bool) {
        return debugger.logLevel == Logger.LogLevel.Warn;
    }
    function isError(DebuggerState storage debugger) internal returns(bool) {
        return debugger.logLevel == Logger.LogLevel.Error;
    }
    function isCritical(DebuggerState storage debugger) internal returns(bool) {
        return debugger.logLevel == Logger.LogLevel.Critical;
    }


    /**----------------------------
        📈 Execution Tracking
    ------------------------------*/
    function recordExecStart(string memory libName, string memory funcName, string memory params) internal returns(uint pid) {
        if (System.Config().RECORD_EXECUTION_PROCESS.isFalse()) return 0;
        pid = System.Debug().nextPid;
        System.Debug().processes.push(Process(libName, funcName, params));
        Logger.logExecStart(pid, libName, funcName);
        System.Debug().nextPid++;
    }

    function recordExecFinish(uint pid) internal {
        if (System.Config().RECORD_EXECUTION_PROCESS.isFalse()) return;
        Process memory current = System.Debug().processes[pid];
        Logger.logExecFinish(pid, current.libName, current.funcName);
    }
}

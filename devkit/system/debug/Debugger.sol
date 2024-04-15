// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Utils
import {console2, StdStyle} from "devkit/utils/ForgeHelper.sol";
    using StdStyle for string;
import {Logger} from "./Logger.sol";
import {System} from "devkit/system/System.sol";
import {Process} from "devkit/system/debug/Process.sol";
import {Inspector} from "devkit/types/Inspector.sol";
    using Inspector for bool;


/**=================\
|   🐞 Debugger     |
\==================*/
using DebuggerLib for Debugger global;
/// @custom:storage-location erc7201:mc.devkit.debugger
struct Debugger {
    Logger.LogLevel logLevel;
    string[] errorLocationStack;
    Process[] processes;
    uint nextPid;
}
library DebuggerLib {

    /**-------------------------
        🕹️ Logging Control
    ---------------------------*/
    function startDebug(Debugger storage debugger) internal {
        setLogLevel(debugger, Logger.LogLevel.Debug);
    }
    function startInfo(Debugger storage debugger) internal {
        setLogLevel(debugger, Logger.LogLevel.Info);
    }
    function startWarn(Debugger storage debugger) internal {
        setLogLevel(debugger, Logger.LogLevel.Warn);
    }
    function startError(Debugger storage debugger) internal {
        setLogLevel(debugger, Logger.LogLevel.Error);
    }
    function startCritical(Debugger storage debugger) internal {
        setLogLevel(debugger, Logger.LogLevel.Critical);
    }
    function stopLog(Debugger storage debugger) internal {
        setLogLevel(debugger, Logger.LogLevel.Disable);
    }
    function setLogLevel(Debugger storage debugger, Logger.LogLevel level) internal {
        debugger.logLevel = level;
    }

    function isDisabled(Debugger storage debugger) internal returns(bool) {
        return debugger.logLevel == Logger.LogLevel.Disable;
    }
    function isDebug(Debugger storage debugger) internal returns(bool) {
        return debugger.logLevel == Logger.LogLevel.Debug;
    }
    function isInfo(Debugger storage debugger) internal returns(bool) {
        return debugger.logLevel == Logger.LogLevel.Info;
    }
    function isWarm(Debugger storage debugger) internal returns(bool) {
        return debugger.logLevel == Logger.LogLevel.Warn;
    }
    function isError(Debugger storage debugger) internal returns(bool) {
        return debugger.logLevel == Logger.LogLevel.Error;
    }
    function isCritical(Debugger storage debugger) internal returns(bool) {
        return debugger.logLevel == Logger.LogLevel.Critical;
    }


}

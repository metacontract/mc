// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Utils
import {console2, StdStyle} from "devkit/utils/ForgeHelper.sol";
    using StdStyle for string;
// import {StringUtils} from "devkit/utils/primitive/StringUtils.sol";
//     using StringUtils for string;
// import {BoolUtils} from "devkit/utils/primitive/BoolUtils.sol";
//     using BoolUtils for bool;
import {Logger} from "./Logger.sol";

bytes32 constant DEBUGGER = 0x03d3692c02b7cdcaf0187e8ede4101c401cc53a33aa7e03ef4682fcca8a55300;
/// @custom:storage-location erc7201:mc.devkit.debugger
struct DebugState {
    LogLevel logLevel;
    string[] errorLocationStack;
    Process[] processes;
    uint nextPid;
}
    enum LogLevel {
        Disable,    // Display no message
        Debug,      // Display all messages including debug details
        Info,       // Display info, warning, and error messages
        Warn,       // Display warning and error messages
        Error,      // Display error messages only
        Critical    // Display critical error messages only
    }
    struct Process {
        string libName;
        string funcName;
        string params;
    }

//=================
//  🐞 Debug
library Debug {
    /**+++++++++++++++++++++
        🔵 Debug State
    +++++++++++++++++++++++*/
    function State() internal pure returns(DebugState storage ref) {
        assembly { ref.slot := DEBUGGER }
    }

    /**-------------------------
        🕹️ Logging Control
    ---------------------------*/
    function startDebug() internal {
        setLogLevel(LogLevel.Debug);
    }
    function startInfo() internal {
        setLogLevel(LogLevel.Info);
    }
    function startWarn() internal {
        setLogLevel(LogLevel.Warn);
    }
    function startError() internal {
        setLogLevel(LogLevel.Error);
    }
    // function startCritical() internal {
    //     setLogLevel(LogLevel.Critical);
    // }
    function stopLog() internal {
        setLogLevel(LogLevel.Disable);
    }
    function setLogLevel(LogLevel level) internal {
        State().logLevel = level;
    }

    function isDisabled() internal returns(bool) {
        return State().logLevel == LogLevel.Disable;
    }
    function isDebug() internal returns(bool) {
        return State().logLevel == LogLevel.Debug;
    }
    function isInfo() internal returns(bool) {
        return State().logLevel == LogLevel.Info;
    }
    function isWarm() internal returns(bool) {
        return State().logLevel == LogLevel.Warn;
    }
    function isError() internal returns(bool) {
        return State().logLevel == LogLevel.Error;
    }
    // function isCritical() internal returns(bool) {
    //     return State().logLevel == LogLevel.Critical;
    // }


    /**----------------------------
        📈 Execution Tracking
    ------------------------------*/
    function recordExecStart(string memory libName, string memory funcName, string memory params) internal returns(uint pid) {
        if (isDisabled()) return 0;
        pid = State().nextPid;
        State().processes.push(Process(libName, funcName, params));
        Logger.logExecStart(pid, libName, funcName);
        State().nextPid++;
    }

    function recordExecFinish(uint pid) internal {
        if (isDisabled()) return;
        Process memory current = State().processes[pid];
        Logger.logExecFinish(pid, current.libName, current.funcName);
    }
}

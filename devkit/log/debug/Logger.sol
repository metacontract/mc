// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {DEBUG} from "devkit/log/message/DEBUG.sol";
import {INFO} from "devkit/log/message/INFO.sol";
import {WARN} from "devkit/log/message/WARN.sol";
import {ERR} from "devkit/log/message/ERR.sol";
import {CRITICAL} from "devkit/log/message/CRITICAL.sol";
// Utils
import {console2, StdStyle, vm} from "devkit/utils/ForgeHelper.sol";
import {StringUtils} from "devkit/types/StringUtils.sol";
// Debug
import {Debugger, Process} from "./Debugger.sol";
import {Inspector} from "devkit/types/Inspector.sol";
    using Inspector for string;

//================
//  📊 Logger
library Logger {
    using Logger for *;
    using StringUtils for string;
    using StdStyle for string;


    /**------------------
        💬 Logging
    --------------------*/
    function log(string memory message) internal {
        if (Debugger.isDebug()) logDebug(message);
        if (Debugger.isInfo()) logInfo(message);
        if (Debugger.isWarm()) logWarn(message);
        if (Debugger.isError()) logError(message);
        if (Debugger.isCritical()) logCritical(message);
    }

    function logDebug(string memory message) internal  {
        console2.log(message);
    }
    function logInfo(string memory message) internal  {
        console2.log(message);
    }
    function logWarn(string memory message) internal  {
        console2.log(message);
    }
    function logError(string memory message) internal {
        console2.log(message);
    }
    function logCritical(string memory message) internal  {
        console2.log(CRITICAL.header(message));
    }

    function logException(string memory message) internal {
        console2.log(
            ERR.HEADER.red().br()
                .indent().append(message)
                .append(parseLocations())
        );
    }


    /**-----------------------
        🎨 Log Formatting
    -------------------------*/
    function logProcess(string memory message) internal {
        log(message.underline());
    }
    function logProcStart(string memory message) internal {
        log((message.isNotEmpty() ? message : "Start Process").underline());
    }
    function logProcFin(string memory message) internal {
        log((message.isNotEmpty() ? message : "(Process Finished)").dim());
    }

    function insert(string memory message) internal {
        log(message.inverse());
    }

    function logBody(string memory message) internal {
        log(message.bold());
    }

    string constant START = "Starting... ";
    function logExecStart(uint pid, string memory libName, string memory funcName) internal {
        log(formatProc(pid, START, libName, funcName));
    }
    string constant FINISH = "Finished ";
    function logExecFinish(uint pid, string memory libName, string memory funcName) internal {
        log(formatProc(pid, FINISH, libName, funcName));
    }

    /**---------------
        📑 Parser
    -----------------*/
    function parseLocations() internal returns(string memory locations) {
        Process[] memory processes = Debugger.State().processes;
        for (uint i = processes.length; i > 0; --i) {
            locations = locations.append(formatLocation(processes[i-1]));
        }
    }

    string constant AT = "\n\t    at ";
    function formatLocation(Process memory proc) internal returns(string memory) {
        return AT.append(proc.libName.dot().append(proc.funcName).parens().append(proc.params.italic())).dim();
    }

    string constant PID = "pid:";
    function formatPid(uint pid) internal returns(string memory message) {
        return message.brackL().append(PID).append(pid).brackR().sp().dim();
    }
    function formatProc(uint pid, string memory status, string memory libName, string memory funcName) internal returns(string memory) {
        return formatPid(pid).append(status).append(libName.dot().append(funcName)).parens();
    }


    /**-------------------
        💾 Export Log
    ---------------------*/
    function exportTo(string memory fileName) internal {}

}



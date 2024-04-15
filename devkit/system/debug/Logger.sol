// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {DEBUG} from "devkit/system/message/DEBUG.sol";
import {INFO} from "devkit/system/message/INFO.sol";
import {WARN} from "devkit/system/message/WARN.sol";
import {ERR} from "devkit/system/message/ERR.sol";
import {CRITICAL} from "devkit/system/message/CRITICAL.sol";
// Utils
import {console2, StdStyle, vm} from "devkit/utils/ForgeHelper.sol";
import {StringUtils} from "devkit/types/StringUtils.sol";
// Debug
import {Process} from "devkit/system/debug/Process.sol";
import {Formatter} from "devkit/types/Formatter.sol";
import {System} from "devkit/system/System.sol";
import {Inspector} from "devkit/types/Inspector.sol";
    using Inspector for string;


/**===============
    📊 Logger
=================*/
library Logger {
    using StringUtils for string;
    using StdStyle for string;
    using Formatter for string;

    enum LogLevel {
        Disable,    // Display no message
        Debug,      // Display all messages including debug details
        Info,       // Display info, warning, and error messages
        Warn,       // Display warning and error messages
        Error,      // Display error messages only
        Critical    // Display critical error messages only
    }

    /**------------------
        💬 Logging
    --------------------*/
    function log(string memory message) internal {
        if (System.Debug().isDebug()) logDebug(message);
        if (System.Debug().isInfo()) logInfo(message);
        if (System.Debug().isWarm()) logWarn(message);
        if (System.Debug().isError()) logError(message);
        if (System.Debug().isCritical()) logCritical(message);
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
                .append(logLocations())
        );
    }


    /**-----------------------
        🎨 Log Formatting
    -------------------------*/
    function logLocations() internal returns(string memory locations) {
        Process[] memory processes = System.Debug().processes;
        for (uint i = processes.length; i > 0; --i) {
            locations = locations.append(Formatter.toString(processes[i-1]));
        }
    }

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
        log(Formatter.formatProc(pid, START, libName, funcName));
    }
    string constant FINISH = "Finished ";
    function logExecFinish(uint pid, string memory libName, string memory funcName) internal {
        log(Formatter.formatProc(pid, FINISH, libName, funcName));
    }


    /**-------------------
        💾 Export Log
    ---------------------*/
    function exportTo(string memory fileName) internal {}

}



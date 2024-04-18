// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {DEBUG} from "devkit/system/message/DEBUG.sol";
import {INFO} from "devkit/system/message/INFO.sol";
import {WARN} from "devkit/system/message/WARN.sol";
import {ERR} from "devkit/system/message/ERR.sol";
import {CRITICAL} from "devkit/system/message/CRITICAL.sol";
// Utils
import {console2, StdStyle, vm} from "devkit/utils/ForgeHelper.sol";
// Debug
import {Process} from "devkit/system/debug/Process.sol";
import {Formatter} from "devkit/types/Formatter.sol";
import {System} from "devkit/system/System.sol";
import {Inspector} from "devkit/types/Inspector.sol";


/**===============
    📊 Logger
=================*/
library Logger {
    using StdStyle for string;
    using Formatter for string;
    using Inspector for string;

    enum Level {
        Critical,   // Display critical error messages only
        Error,      // Display error messages only
        Warn,       // Display warning and error messages
        Info,       // Display info, warning, and error messages
        Debug       // Display all messages including debug details
    }

    /**------------------
        💬 Logging
    --------------------*/
    function log(string memory message) internal {
        console2.log(message);
    }
    function log(string memory header, string memory message) internal {
        log(header.append(message));
    }

    function logException(string memory message) internal {
        if (mode() == Level.Critical) log(CRITICAL.HEADER, message);
        if (mode() >= Level.Error) {
            log(ERR.HEADER, message);
            log(logLocations());
        }
    }
    function logWarn(string memory message) internal {
        if (shouldLog(Level.Warn)) log(WARN.HEADER, message);
    }
    function logInfo(string memory message) internal {
        if (shouldLog(Level.Info)) log(INFO.HEADER, message);
    }
    function logDebug(string memory message) internal {
        if (shouldLog(Level.Debug)) log(DEBUG.HEADER, message);
    }


    /**-----------------------
        🎨 Log Formatting
    -------------------------*/
    function logLocations() internal returns(string memory locations) {
        Process[] memory processes = System.Debug().processes;
        for (uint i = processes.length; i > 0; --i) {
            locations = locations.append(processes[i-1].toLocation());
        }
    }


    /**-------------------
        💾 Export Log
    ---------------------*/
    function exportTo(string memory fileName) internal {}


    // Check log mode
    function mode() internal view returns(Level) {
        return System.Config().DEBUG.DEFAULT_LOG_LEVEL;
    }

    function shouldLog(Level level) internal view returns (bool) {
        Level mode = mode();
        return level <= mode;
    }

}



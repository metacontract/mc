// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERR} from "devkit/system/message/ERR.sol";
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

    // Message Header
    string constant CRITICAL = "\u001b[91m[\xF0\x9F\x9A\xA8CRITICAL]\u001b[0m ";
    string constant ERROR = "\u001b[91m[\u2716 ERROR]\u001b[0m\n\t";
    string constant WARN = "\u001b[93m[WARNING]\u001b[0m ";
    string constant INFO = "\u001b[2m[INFO]\u001b[0m ";
    string constant DEBUG = "\u001b[2m[DEBUG]\u001b[0m ";


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
        if (currentLevel() == Level.Critical) log(CRITICAL, message);
        if (currentLevel() >= Level.Error) {
            log(ERROR, message);
            log(logLocations());
        }
    }
    function logWarn(string memory message) internal {
        if (shouldLog(Level.Warn)) log(WARN, message);
    }
    function logInfo(string memory message) internal {
        if (shouldLog(Level.Info)) log(INFO, message);
    }
    function logDebug(string memory message) internal {
        if (shouldLog(Level.Debug)) log(DEBUG, message);
    }


    /**-----------------------
        🎨 Log Formatting
    -------------------------*/
    function logLocations() internal returns(string memory locations) {
        Process[] memory processStack = System.Debug().processStack;
        for (uint i = processStack.length; i > 0; --i) {
            locations = locations.append(processStack[i-1].toLocation());
        }
    }


    /**-------------------
        💾 Export Log
    ---------------------*/
    function exportTo(string memory fileName) internal {}


    // Check Current Log Level
    function currentLevel() internal view returns(Level) {
        return System.Config().DEBUG.DEFAULT_LOG_LEVEL;
    }

    function shouldLog(Level level) internal view returns (bool) {
        Level currentLevel = currentLevel();
        return level <= currentLevel;
    }

}



// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

// Forge-std
import {console2} from "forge-std/console2.sol";
// System
import {System} from "devkit/system/System.sol";
import {Tracer} from "devkit/system/Tracer.sol";
import {Formatter} from "devkit/types/Formatter.sol";


/**===============
    📊 Logger
=================*/
library Logger {

    enum Level {
        Critical,   // Display critical error messages only
        Error,      // Display error messages only
        Warn,       // Display warning and error messages
        Info,       // Display info, warning, and error messages
        Debug       // Display all messages including debug details
    }

    // Message Header
    string constant CRITICAL = "\u001b[91m[\xF0\x9F\x9A\xA8CRITICAL]\u001b[0m";
    string constant ERROR = "\u001b[91m[\u2716 ERROR]\u001b[0m\n\t";
    string constant WARN = "\u001b[93m[WARNING]\u001b[0m";
    string constant INFO = "\u001b[92m[INFO]\u001b[0m";
    string constant DEBUG = "\u001b[94m[DEBUG]\u001b[0m";


    /**------------------
        💬 Logging
    --------------------*/
    function log(string memory message) internal pure {
        console2.log(message);
    }
    function log(string memory header, string memory message) internal pure {
        console2.log(header, message);
    }

    function logException(string memory messageHead, string memory messageBody) internal view {
        if (currentLevel() == Level.Critical) logCritical(messageHead);
        if (currentLevel() >= Level.Error) logError(Formatter.toMessage(messageHead, messageBody));
    }
    function logCritical(string memory messageHead) internal pure {
        log(CRITICAL, messageHead);
    }
    function logError(string memory message) internal view {
        log(ERROR, message);
        log(Tracer.traceErrorLocations());
    }
    function logWarn(string memory message) internal view {
        if (shouldLog(Level.Warn)) log(WARN, message);
    }
    function logInfo(string memory message) internal view {
        if (shouldLog(Level.Info)) log(INFO, message);
    }
    function logDebug(string memory message) internal view {
        if (shouldLog(Level.Debug)) log(DEBUG, message);
    }


    /**-------------------
        💾 Export Log
    ---------------------*/
    function exportTo(string memory fileName) internal {}


    // Check Current Log Level
    function currentLevel() internal view returns(Level) {
        return System.Config().SYSTEM.LOG_LEVEL;
    }

    function shouldLog(Level level) internal view returns(bool) {
        Level _currentLevel = currentLevel();
        return level <= _currentLevel;
    }

    function isDisable() internal view returns(bool) {
        return currentLevel() == Level.Critical;
    }

}



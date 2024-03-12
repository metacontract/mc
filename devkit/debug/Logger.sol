// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Utils
import {console2, StdStyle} from "@devkit/utils/ForgeHelper.sol";
import {StringUtils} from "@devkit/utils/StringUtils.sol";
// Debug
import {Debug} from "@devkit/debug/Debug.sol";

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
        if (Debug.isDebug()) logDebug(message);
        if (Debug.isInfo()) logInfo(message);
        if (Debug.isWarm()) logWarn(message);
        if (Debug.isError()) logError(message);
        if (Debug.isCritical()) logCritical(message);
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

    string constant ERR_HEADER = "\u2716 DevKit Error: ";
    function logError(string memory body) internal {
        console2.log(
            ERR_HEADER.red().br()
                .indent().append(body)
                .append(parseLocations())
        );
    }
    function logCritical(string memory message) internal  {
        console2.log(message);
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


    /**---------------
        📑 Parser
    -----------------*/
    function parseLocations() internal returns(string memory locations) {
        uint size = Debug.State().errorLocationStack.length;
        for (uint i = size; i > 0; --i) {
            locations = locations.append(formatLocation(Debug.State().errorLocationStack[i-1]));
        }
    }

    function formatLocation(string memory location) internal returns(string memory) {
        return StringUtils.append("\n\t    at ", location).dim();
    }

string constant ERR_STR_EMPTY = "Empty String";
string constant ERR_STR_EXISTS = "String Already Exist";


    /**-------------------
        💾 Export Log
    ---------------------*/
    function exportTo(string memory fileName) internal {}

}



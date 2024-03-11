// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Utils
import {console2, StdStyle} from "@devkit/utils/ForgeHelper.sol";
import {StringUtils} from "@devkit/utils/StringUtils.sol";
// Debug
import {Debug} from "@devkit/debug/Debug.sol";
// Errors
import "@devkit/errors/Errors.sol";
// Core
import {FuncInfo} from "@devkit/core/functions/FuncInfo.sol";
import {BundleInfo} from "@devkit/core/functions/BundleInfo.sol";

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
    function logWithMetadata(string memory message, string memory metadata) internal  {
        console2.log(message, metadata);
    }
    function logIf(bool condition, string memory message) internal  {
        if (condition) console2.log(message);
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
        console2.log(StringUtils.concat(
            ERR_HEADER.underline(),
            StringUtils.concat("\n\t", message)
        ));
        logLocations();
        console2.log(message);
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
    function logLocations() internal {
        uint size = Debug.State().errorLocationStack.length;
        for (uint i = size; i > 0; --i) {
            formatLocation(Debug.State().errorLocationStack[i-1]);
        }
    }

    /**
        Specific Log
     */
    function parseAndLog(FuncInfo memory functionInfo) internal {
        console2.log(
            StringUtils.concat("\tImpl: ", functionInfo.implementation),
            StringUtils.concat(", Selector: ", functionInfo.selector),
            StringUtils.concat(", Name: ", functionInfo.name)
        );
    }
    function emitLog(BundleInfo storage bundleInfo) internal returns(BundleInfo storage) {
        // if (Debug.shouldLog()) {
            // console2.log(DevUtils.indent(bundleInfo.name));
            console2.log("\tFacade:", bundleInfo.facade);
            for (uint i; i < bundleInfo.functionInfos.length; ++i) {
                bundleInfo.functionInfos[i].parseAndLog();
            }
        // }
        return bundleInfo;
    }
    function emitLog(FuncInfo storage functionInfo) internal returns(FuncInfo storage) {
        // if (Debug.shouldLog()) {
            functionInfo.parseAndLog();
        // }
        return functionInfo;
    }

    function formatLocation(string memory location) internal returns(string memory) {
        return StringUtils.concat("\n    at ", location.dim());
    }

string constant ERR_HEADER = "\u2716 mc-devkit Error: ";
string constant ERR_STR_EMPTY = "Empty String";
string constant ERR_STR_EXISTS = "String Already Exist";


    /**-------------------
        💾 Export Log
    ---------------------*/
    function exportTo(string memory fileName) internal {}

}



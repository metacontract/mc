// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Logger} from "devkit/system/debug/Logger.sol";
import {Inspector} from "devkit/types/Inspector.sol";
    using Inspector for string;

/**===============
    🗒️ Parser
=================*/
library Parser {
    /**===============
        📊 Logger
    =================*/
    function toLogLevel(string memory str) internal returns(Logger.LogLevel) {
        if (str.isEqual("Debug")) return Logger.LogLevel.Debug;
        if (str.isEqual("Info")) return Logger.LogLevel.Info;
        if (str.isEqual("Warn")) return Logger.LogLevel.Warn;
        if (str.isEqual("Error")) return Logger.LogLevel.Error;
        if (str.isEqual("Critical")) return Logger.LogLevel.Critical;
        return Logger.LogLevel.Disable;
    }
}

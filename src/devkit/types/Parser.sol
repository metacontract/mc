// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Logger} from "devkit/system/Logger.sol";
import {Inspector} from "devkit/types/Inspector.sol";
    using Inspector for string;

/**===============
    🗒️ Parser
=================*/
library Parser {
    /**===============
        📊 Logger
    =================*/
    function toLogLevel(string memory str) internal pure returns(Logger.Level) {
        if (str.isEqual("Debug")) return Logger.Level.Debug;
        if (str.isEqual("Info")) return Logger.Level.Info;
        if (str.isEqual("Warn")) return Logger.Level.Warn;
        if (str.isEqual("Error")) return Logger.Level.Error;
        return Logger.Level.Critical;
    }
}

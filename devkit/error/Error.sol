// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Utils
import {StdStyle} from "devkit/utils/ForgeHelper.sol";
    using StdStyle for string;
import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;
// Debug
import {Logger} from "devkit/debug/Logger.sol";

function throwError(string memory errorBody) {
    Logger.logError(errorBody);
    revert(StringUtils.append(ERR.HEADER, errorBody).bold());
}

library ERR {
    string constant HEADER = "\u2716 DevKit Error: ";
    string constant FIND_NAME_OVER_RANGE = "Default names are automatically set up to 5. Please manually assign names beyond that.";
    // string constant STR_EMPTY = "Empty String";
    // string constant STR_EXISTS = "String Already Exist";
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {StdStyle, console2} from "./ForgeHelper.sol";
import {DevUtils} from "./DevUtils.sol";
import {Debug} from "./Debug.sol";

using DevUtils for bool;
using DevUtils for string;
using StdStyle for string;

/// @dev like `require`
function check(bool condition, string memory errorBody) {
    if (condition.isFalse()) throwError(errorBody);
}

function throwError(string memory errorBody) {
    console2.log(DevUtils.concat(
        ERR_HEADER.underline(),
        DevUtils.concat("\n\t", errorBody)
    ));
    Debug.logLocations();
    revert(DevUtils.concat(ERR_HEADER, errorBody).bold());
}

string constant ERR_HEADER = "\u274c Meta Contract DevKit Error: ";
string constant ERR_STR_EMPTY = "Empty String";
string constant ERR_STR_EXISTS = "String Already Exist";

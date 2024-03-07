// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {StdStyle, console2} from "./ForgeHelper.sol";
import {DevUtils} from "./DevUtils.sol";

using DevUtils for bool;
using DevUtils for string;
using StdStyle for string;

/// @dev like `require`
function check(bool condition, string memory errorBody, string memory errorLocation) {
    if (condition.isFalse()) throwError(errorBody, errorLocation);
}

function throwError(string memory errorBody, string memory errorLocation) {
    string memory errorString = string.concat(
        ERR_HEADER,
        errorBody,
        string.concat(" at ", errorLocation.isEmpty() ? "UnknownLocation" : errorLocation)
    );
    console2.log(errorString);
    revert(errorString.bold());
}
function throwError(string memory errorBody) {
    throwError(errorBody, "");
}
function throwError() {
    throwError("", "");
}

string constant ERR_HEADER = "UCS DevEnv Error: ";
string constant ERR_STR_EMPTY = "Empty String";
string constant ERR_STR_EXISTS = "String Already Exist";

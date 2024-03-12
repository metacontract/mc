// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Errors
import {Errors} from "../errors/Errors.sol";
// Debug
import {Debug} from "@devkit/debug/Debug.sol";

function check(bool condition, string memory errorBody) {
    Errors.check(condition, errorBody);
}
function check(bool condition, string memory errorBody, string memory errorDetail) {
    Errors.check(condition, errorBody, errorDetail);
}
function throwError(string memory errorBody) {
    Errors.throwError(errorBody);
}

string constant PARAMS = " with params: ";

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Errors
import {Errors} from "./Errors.sol";

function check(bool condition, string memory errorBody) {
    Errors.check(condition, errorBody);
}
function check(bool condition, string memory errorBody, string memory errorDetail) {
    Errors.check(condition, errorBody, errorDetail);
}

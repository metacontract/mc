// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {throwError, ERR} from "devkit/error/Error.sol";
// Utils
import {BoolUtils} from "devkit/utils/BoolUtils.sol";
    using BoolUtils for bool;
import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;

/// @dev like `require`
function validate(bool condition, string memory errorBody) {
    if (condition.isFalse()) throwError(errorBody);
}
function validate(bool condition, string memory errorBody, string memory errorDetail) {
    validate(condition, errorBody.append(errorDetail));
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Logger} from "devkit/log/debug/Logger.sol";
import {ERR} from "devkit/log/message/ERR.sol";

function throwError(string memory errorBody) {
    Logger.logError(errorBody);
    revert(ERR.message(errorBody));
}

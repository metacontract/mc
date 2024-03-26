// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Utils
import {StdStyle} from "../utils/ForgeHelper.sol";
import {StringUtils} from "../utils/StringUtils.sol";
import {BoolUtils} from "../utils/BoolUtils.sol";
// Debug
import {Debug} from "../debug/Debug.sol";
import {Logger} from "../debug/Logger.sol";

library Errors {
    using StdStyle for string;
    using StringUtils for string;
    using BoolUtils for bool;

    /// @dev like `require`
    function check(bool condition, string memory errorBody) internal {
        if (condition.isFalse()) throwError(errorBody);
    }

    function check(bool condition, string memory errorBody, string memory errorDetail) internal {
        if (condition.isFalse()) throwError(errorBody.append(errorDetail));
    }

    function throwError(string memory errorBody) internal {
        Logger.logError(errorBody);
        revert(StringUtils.append(Logger.ERR_HEADER, errorBody).bold());
    }

    string constant FIND_NAME_OVER_RANGE = "Default names are automatically set up to 5. Please manually assign names beyond that.";
}


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Utils
import {StdStyle} from "@devkit/utils/ForgeHelper.sol";
import {StringUtils} from "@devkit/utils/StringUtils.sol";
import {BoolUtils} from "@devkit/utils/BoolUtils.sol";
// Debug
import {Debug} from "@devkit/debug/Debug.sol";
import {Logger} from "@devkit/debug/Logger.sol";

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


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {throwError, ERR} from "devkit/error/Error.sol";
// Utils
import {BoolUtils} from "devkit/utils/BoolUtils.sol";
    using BoolUtils for bool;
import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;
import {Bytes4Utils} from "devkit/utils/Bytes4Utils.sol";
    using Bytes4Utils for bytes4;
import {AddressUtils} from "devkit/utils/AddressUtils.sol";
    using AddressUtils for address;

/// @dev like `require`
function check(bool condition, string memory errorBody) {
    if (condition.isFalse()) throwError(errorBody);
}
function check(bool condition, string memory errorBody, string memory errorDetail) {
    check(condition, errorBody.append(errorDetail));
}

library Check {
    function isUnassigned(string storage str) internal {
        check(str.isEmpty(), ERR.STR_ALREADY_ASSIGNED);
    }
    function isNotEmpty(string memory str) internal {
        check(str.isNotEmpty(), ERR.EMPTY_STR);
    }

    function isUnassigned(bytes4 b4) internal {
        check(b4.isEmpty(), ERR.B4_ALREADY_ASSIGNED);
    }
    function isNotEmpty(bytes4 b4) internal {
        check(b4.isNotEmpty(), ERR.EMPTY_B4);
    }

    function isContract(address addr) internal {
        check(addr.isContract(), ERR.NOT_CONTRACT);
    }
}

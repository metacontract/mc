// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {throwError, ERR} from "devkit/error/Error.sol";
import {validate} from "devkit/error/Validate.sol";
// Utils
import {BoolUtils} from "devkit/utils/BoolUtils.sol";
    using BoolUtils for bool;
import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;
import {Bytes4Utils} from "devkit/utils/Bytes4Utils.sol";
    using Bytes4Utils for bytes4;
import {AddressUtils} from "devkit/utils/AddressUtils.sol";
    using AddressUtils for address;
import {BuildStatus} from "devkit/utils/type/TypeSafetyUtils.sol";
import {Dictionary} from "devkit/core/Dictionary.sol";


library Require {
    function isUnassigned(string storage str) internal {
        validate(str.isEmpty(), ERR.STR_ALREADY_ASSIGNED);
    }
    function isNotEmpty(string memory str) internal {
        validate(str.isNotEmpty(), ERR.EMPTY_STR);
    }

    function isUnassigned(bytes4 b4) internal {
        validate(b4.isEmpty(), ERR.B4_ALREADY_ASSIGNED);
    }
    function isNotEmpty(bytes4 b4) internal {
        validate(b4.isNotEmpty(), ERR.EMPTY_B4);
    }

    function isContract(address addr) internal {
        validate(addr.isContract(), ERR.NOT_CONTRACT);
    }

    function notEmptyString(string memory str) internal {
        validate(str.isNotEmpty(), ERR.RQ_NOT_EMPTY_STRING);
    }

    function assigned(bytes4 b4) internal {
        validate(b4.isNotEmpty(), ERR.RQ_SELECTOR);
    }
    function contractAssigned(address addr) internal {
        validate(addr.isContract(), ERR.RQ_CONTRACT);
    }

    function notLocked(BuildStatus status) internal {
        validate(status != BuildStatus.Locked, ERR.LOCKED_OBJECT);
    }

    function isNotEmpty(Dictionary memory dictionary) internal {
        validate(dictionary.isNotEmpty(), ERR.EMPTY_DICTIONARY);
    }

    function isNotZero(address addr) internal {
        validate(addr.isNotZero(), ERR.ZERO_ADDRESS);
    }
}

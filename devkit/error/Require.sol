// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {throwError, ERR} from "./Error.sol";
// Utils
import {BoolUtils} from "devkit/utils/BoolUtils.sol";
    using BoolUtils for bool;
import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;
import {Bytes4Utils} from "devkit/utils/Bytes4Utils.sol";
    using Bytes4Utils for bytes4;
import {AddressUtils} from "devkit/utils/AddressUtils.sol";
    using AddressUtils for address;

import {check} from "devkit/error/Validation.sol";

library Require {
    function assigned(bytes4 str) internal {
        check(str.isNotEmpty(), ERR.RQ_SELECTOR);
    }
    function contractAssigned(address addr) internal {
        check(addr.isContract(), ERR.RQ_CONTRACT);
    }
}

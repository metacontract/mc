// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Validation
import {Validate} from "devkit/validate/Validate.sol";
// Utils
import {vm} from "devkit/utils/ForgeHelper.sol";
import {StringUtils} from "./StringUtils.sol";
    using StringUtils for string;
import {BoolUtils} from "./BoolUtils.sol";
    using BoolUtils for bool;


/**=====================\
|   💾 Bytes4 Utils     |
\======================*/
using Bytes4Utils for bytes4;
library Bytes4Utils {
    /**---------------------------
        🔢 Utils for Primitives
    -----------------------------*/


    /**-----------------------
        🔀 Type Convertor
    -------------------------*/
    function toString(bytes4 selector) internal pure returns (string memory) {
        return vm.toString(selector).substring(10);
    }

}

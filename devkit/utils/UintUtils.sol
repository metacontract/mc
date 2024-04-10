// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Validation
import {validate} from "devkit/error/Validate.sol";
// Utils
import {vm} from "./ForgeHelper.sol";
import {StringUtils} from "./StringUtils.sol";
    using StringUtils for string;
import {BoolUtils} from "./BoolUtils.sol";
    using BoolUtils for bool;


/**=====================\
|   💾 Bytes4 Utils     |
\======================*/
using UintUtils for bytes4;
library UintUtils {
    /**---------------------------
        🔢 Utils for Primitives
    -----------------------------*/


    /**-----------------------
        🔀 Type Convertor
    -------------------------*/


    /**-------------------------------
        🧐 Inspectors & Assertions
    ---------------------------------*/
    function isNotZero(uint256 num) internal pure returns(bool) {
        return num != 0;
    }
}

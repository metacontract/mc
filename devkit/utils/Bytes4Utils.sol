// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Validation
import {check} from "devkit/error/Validation.sol";
// Utils
import {vm} from "./ForgeHelper.sol";
import {StringUtils} from "./StringUtils.sol";
import {BoolUtils} from "./BoolUtils.sol";

/**=====================\
|   💾 Bytes4 Utils     |
\======================*/
library Bytes4Utils {
    using Bytes4Utils for bytes4;
    using StringUtils for string;
    using BoolUtils for bool;


    /**---------------------------
        🔢 Utils for Primitives
    -----------------------------*/


    /**-----------------------
        🔀 Type Convertor
    -------------------------*/
    function toString(bytes4 selector) internal pure returns (string memory) {
        return vm.toString(selector).substring(10);
    }


    /**-------------------------------
        🧐 Inspectors & Assertions
    ---------------------------------*/
    function isEmpty(bytes4 selector) internal  returns(bool) {
        return selector == bytes4(0);
    }
    function isNotEmpty(bytes4 selector) internal  returns(bool) {
        return selector.isEmpty().isFalse();
    }
    function assertEmpty(bytes4 selector) internal returns(bytes4) {
        check(selector.isEmpty(), "Selector Not Empty");
        return selector;
    }
    function assertNotEmpty(bytes4 selector) internal returns(bytes4) {
        check(selector.isNotEmpty(), "Empty Selector");
        return selector;
    }

    function isEqual(bytes4 a, bytes4 b) internal returns(bool) {
        return a == b;
    }
    function isNotEqual(bytes4 a, bytes4 b) internal returns(bool) {
        return a.isEqual(b).isFalse();
    }
}

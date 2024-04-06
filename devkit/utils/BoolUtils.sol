// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**===================\
|   ✅ Bool Utils     |
\====================*/
using BoolUtils for bool;
library BoolUtils {
    /**---------------------------
        🔢 Utils for Primitives
    -----------------------------*/
    function isNot(bool flag) internal pure returns(bool) {
        return !flag;
    }
    function isFalse(bool flag) internal pure returns(bool) {
        return flag == false;
    }


    /**-------------------------------
        🧐 Inspectors & Assertions
    ---------------------------------*/

}

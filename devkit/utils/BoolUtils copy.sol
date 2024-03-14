// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**===================\
|   ✅ Bool Utils     |
\====================*/
library BoolUtils {
    using BoolUtils for bool;


    /**---------------------------
        🔢 Utils for Primitives
    -----------------------------*/
    function isNot(bool flag) internal  returns(bool) {
        return !flag;
    }
    function isFalse(bool flag) internal  returns(bool) {
        return flag == false;
    }


    /**-------------------------------
        🧐 Inspectors & Assertions
    ---------------------------------*/

}

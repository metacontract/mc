// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Logger} from "devkit/system/debug/Logger.sol";
import {Formatter} from "devkit/types/Formatter.sol";
// Core Types
import {Function} from "devkit/core/Function.sol";
import {Bundle} from "devkit/core/Bundle.sol";


/**=================
    🚰 Dumper
===================*/
library Dumper {

    /**==================
        🧩 Function
    ====================*/
    function dump(Function storage func) internal returns(Function storage) {
        Logger.log(Formatter.toString(func));
        return func;
    }

    /**===============
        🗂️ Bundle
    =================*/
    function dump(Bundle storage bundle) internal returns(Bundle storage) {
        Logger.log(Formatter.toString(bundle));
        return bundle;
    }

}



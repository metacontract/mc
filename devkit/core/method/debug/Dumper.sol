// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Logger} from "devkit/debug/Logger.sol";
// Core Types
import {Function} from "devkit/core/types/Function.sol";
import {Bundle} from "devkit/core/types/Bundle.sol";


//================
//  🚰 Dumper
library Dumper {
    /**==================
        🧩 Function
    ====================*/
    function dump(Function storage func) internal returns(Function storage) {
        Logger.log(func.parse());
        return func;
    }


    /**===============
        🗂️ Bundle
    =================*/
    function dump(Bundle storage bundle) internal returns(Bundle storage) {
        Logger.logDebug(bundle.parse());
        return bundle;
    }

}



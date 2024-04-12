// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Logger} from "devkit/log/debug/Logger.sol";
import {Parser} from "devkit/log/debug/Parser.sol";
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
        Logger.log(Parser.parse(func));
        return func;
    }

    /**===============
        🗂️ Bundle
    =================*/
    function dump(Bundle storage bundle) internal returns(Bundle storage) {
        Logger.log(Parser.parse(bundle));
        return bundle;
    }

}



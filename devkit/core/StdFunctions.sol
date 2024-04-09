// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core Types
import {Function} from "devkit/core/Function.sol";
import {Bundle} from "devkit/core/Bundle.sol";
// Methods
import {StdFunctionsLib} from "devkit/method/core/StdFunctionsLib.sol";
import {ProcessLib} from "devkit/method/debug/ProcessLib.sol";


/**==========================
    🏛 Standard Functions
============================*/
struct StdFunctions {
    Function initSetAdmin;
    Function getDeps;
    Function clone;
    Bundle all;
}
using StdFunctionsLib for StdFunctions global;
//  Support Methods
using ProcessLib for StdFunctions global;

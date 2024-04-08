// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {FunctionLib} from "devkit/method/core/FunctionLib.sol";
import {ProcessLib} from "devkit/method/debug/ProcessLib.sol";
import {LogLib} from "devkit/method/debug/LogLib.sol";


/**==================
    🧩 Function
====================*/
struct Function { /// @dev Function may be different depending on the op version.
    string name;
    bytes4 selector;
    address implementation;
}
using FunctionLib for Function global;
using ProcessLib for Function global;
using LogLib for Function global;

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Methods
import {FunctionLib} from "devkit/method/core/FunctionLib.sol";
import {ProcessLib} from "devkit/method/debug/ProcessLib.sol";
import {ParseLib} from "devkit/method/debug/ParseLib.sol";
import {LogLib} from "devkit/method/debug/LogLib.sol";
import {TypeSafetyUtils, BuildStatus} from "devkit/utils/type/TypeSafetyUtils.sol";


/**==================
    🧩 Function
====================*/
struct Function { /// @dev Function may be different depending on the op version.
    string name;
    bytes4 selector;
    address implementation;
    BuildStatus buildStatus;
}
using FunctionLib for Function global;
using ProcessLib for Function global;
using ParseLib for Function global;
using LogLib for Function global;
using TypeSafetyUtils for Function global;

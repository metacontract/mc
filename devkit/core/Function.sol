// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core Method
import {FunctionLib} from "devkit/method/core/FunctionLib.sol";
// Support Methods
import {ProcessLib} from "devkit/method/debug/ProcessLib.sol";
import {Parser} from "devkit/method/debug/Parser.sol";
import {Dumper} from "devkit/method/debug/Dumper.sol";
import {Inspector} from "devkit/method/inspector/Inspector.sol";
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
//  Support Methods
using ProcessLib for Function global;
using Parser for Function global;
using Dumper for Function global;
using Inspector for Function global;
using TypeSafetyUtils for Function global;

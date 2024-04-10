// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {ProcessLib} from "devkit/core/method/debug/ProcessLib.sol";
    using ProcessLib for Function global;
import {Parser} from "devkit/core/method/debug/Parser.sol";
    using Parser for Function global;
import {Dumper} from "devkit/core/method/debug/Dumper.sol";
    using Dumper for Function global;
import {Inspector} from "devkit/core/method/inspector/Inspector.sol";
    using Inspector for Function global;
import {TypeGuard, TypeStatus} from "devkit/core/types/TypeGuard.sol";
    using TypeGuard for Function global;
// Validation
import {Require} from "devkit/error/Require.sol";
// Loader
import {loadAddressFrom} from "devkit/utils/ForgeHelper.sol";


/**==================
    🧩 Function
====================*/
using FunctionLib for Function global;
struct Function { /// @dev Function may be different depending on the op version.
    string name;
    bytes4 selector;
    address implementation;
    TypeStatus status;
}
library FunctionLib {
    /**---------------
        🌈 Assign
    -----------------*/
    function assign(Function storage func, string memory name, bytes4 selector, address implementation) internal returns(Function storage) {
        uint pid = func.startProcess("assign");
        func.assignName(name);
        func.assignSelector(selector);
        func.assignImplementation(implementation);
        return func.finishProcess(pid);
    }

    /**--------------------
        📛 Assign Name
    ----------------------*/
    function assignName(Function storage func, string memory name) internal returns(Function storage) {
        uint pid = func.startProcess("assignName");
        Require.notLocked(func.status);
        func.name = name;
        return func.building().finishProcess(pid);
    }

    /**------------------------
        🎯 Assign Selector
    --------------------------*/
    function assignSelector(Function storage func, bytes4 selector) internal returns(Function storage) {
        uint pid = func.startProcess("assignSelector");
        Require.notLocked(func.status);
        func.selector = selector;
        return func.building().finishProcess(pid);
    }

    /**------------------------------
        🎨 Assign Implementation
    --------------------------------*/
    function assignImplementation(Function storage func, address implementation) internal returns(Function storage) {
        uint pid = func.startProcess("assignImplementation");
        Require.notLocked(func.status);
        func.implementation = implementation;
        return func.building().finishProcess(pid);
    }

    /**-----------------------
        📨 Fetch Function
    -------------------------*/
    function fetch(Function storage func, string memory envKey) internal returns(Function storage) {
        uint pid = func.startProcess("fetch");
        Require.notLocked(func.status);
        Require.notEmpty(envKey);
        func.assignName(envKey);
        func.assignImplementation(loadAddressFrom(envKey));
        return func.building().finishProcess(pid);
    }

}

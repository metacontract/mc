// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**--------------------------
    Apply Support Methods
----------------------------*/
import {ProcessLib} from "devkit/method/debug/ProcessLib.sol";
    using ProcessLib for Function global;
import {Parser} from "devkit/method/debug/Parser.sol";
    using Parser for Function global;
import {Dumper} from "devkit/method/debug/Dumper.sol";
    using Dumper for Function global;
import {Inspector} from "devkit/method/inspector/Inspector.sol";
    using Inspector for Function global;
import {TypeSafetyUtils, BuildStatus} from "devkit/utils/type/TypeSafetyUtils.sol";
    using TypeSafetyUtils for Function global;

// Validation
import {Valid} from "devkit/error/Valid.sol";
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
    BuildStatus buildStatus;
}
library FunctionLib {
    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        🌈 Assign
        📛 Assign Name
        🎯 Assign Selector
        🔌 Assign Implementation
        👷‍♂️ Build
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

    /**---------------
        🌈 Assign
    -----------------*/
    function assign(Function storage func, string memory name, bytes4 selector, address implementation) internal returns(Function storage) {
        func.assignName(name);
        func.assignSelector(selector);
        func.assignImplementation(implementation);
        return func;
    }

    /**--------------------
        📛 Assign Name
    ----------------------*/
    function assignName(Function storage func, string memory name) internal returns(Function storage) {
        Valid.notLocked(func.buildStatus);
        func.name = name;
        func.asBuilding();
        return func;
    }

    /**------------------------
        🎯 Assign Selector
    --------------------------*/
    function assignSelector(Function storage func, bytes4 selector) internal returns(Function storage) {
        Valid.notLocked(func.buildStatus);
        func.selector = selector;
        func.asBuilding();
        return func;
    }

    /**------------------------------
        🔌 Assign Implementation
    --------------------------------*/
    function assignImplementation(Function storage func, address implementation) internal returns(Function storage) {
        Valid.notLocked(func.buildStatus);
        func.implementation = implementation;
        func.asBuilding();
        return func;
    }

    /**--------------
        👷‍♂️ Build
    ----------------*/
    function asBuilding(Function storage func) internal returns(Function storage) {
        func.buildStatus = BuildStatus.Building;
        return func;
    }
    function build(Function storage func) internal returns(Function storage) {
        // TODO
        Valid.assigned(func.selector);
        Valid.contractAssigned(func.implementation);
        func.buildStatus = BuildStatus.Built;
        return func;
    }
    function lock(Function storage func) internal returns(Function storage) {
        func.buildStatus = BuildStatus.Locked;
        return func;
    }


    // function fetch(Function storage func, string memory envKey) internal returns(Function storage) {
    //     uint pid = func.startProcess("fetch");
    //     Valid.isUnassigned(func.name);
    //     Valid.isNotEmpty(envKey);
    //     return func;
    // }
    // function fetchAndAssign(Function storage func, string memory envKey, bytes4 selector) internal returns(Function storage) {
    //     uint pid = func.startProcess("fetchAndAssign");
    //     func.assign(envKey, selector, loadAddressFrom(envKey));
    //     return func.finishProcess(pid);
    // }

    // function loadAndAssignFromEnv(Function storage func, string memory envKey, string memory name, bytes4 selector) internal returns(Function storage) {
    //     uint pid = func.startProcess("loadAndAssignFromEnv");
    //     return func .assign(name)
    //                 .assign(selector)
    //                 .assign(loadAddressFrom(envKey))
    //                 .finishProcess(pid);
    // }
    // function loadAndAssignFromEnv(Function storage func) internal returns(Function storage) {
    //     Valid.isNotEmpty(func.name);
    //     Valid.isNotEmpty(func.selector);
    //     return func.loadAndAssignFromEnv(func.name, func.name, func.selector);
    // }
    // function safeLoadAndAssignFromEnv(Function storage func, string memory envKey, string memory name, bytes4 selector) internal returns(Function storage) {
    //     uint pid = func.startProcess("safeLoadAndAssignFromEnv");
    //     Valid.isNotEmpty(envKey);
    //     Valid.isNotEmpty(name);
    //     Valid.isNotEmpty(selector);
    //     return func.loadAndAssignFromEnv(envKey, name, selector).finishProcess(pid);
    // }

}

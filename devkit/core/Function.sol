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
        📛 Assign Name
        🧩 Assign Selector
        🪟 Assign Implementation
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

    /**--------------------
        📛 Assign Name
    ----------------------*/
    function assign(Function storage func, string memory name, bytes4 selector, address implementation) internal returns(Function storage) {
        uint pid = func.startProcess("safeAssign");
        Valid.isUnassigned(func.name);
        Valid.isNotEmpty(name);
        Valid.isNotEmpty(selector);
        Valid.isContract(implementation);
        func.name = name;
        func.selector = selector;
        func.implementation = implementation;
        return func.finishProcess(pid);
    }

    function asBuilding(Function storage func) internal returns(Function storage) {
        func.buildStatus = BuildStatus.Building;
        return func;
    }
    function build(Function storage func) internal returns(Function storage) {
        Valid.assigned(func.selector);
        Valid.contractAssigned(func.implementation);
        func.buildStatus = BuildStatus.Built;
        return func;
    }

    function assign(Function storage func, bytes4 selector, address implementation) internal returns(Function storage) {
        func.assignSelector(selector);
        func.assignImplementation(implementation);
        return func;
    }

    function assignSelector(Function storage func, bytes4 selector) internal returns(Function storage) {
        func.selector = selector;
        func.asBuilding();
        return func;
    }
    function assignImplementation(Function storage func, address implementation) internal returns(Function storage) {
        func.implementation = implementation;
        func.asBuilding();
        return func;
    }


    /**----- Name --------*/
    function assign(Function storage func, string memory name) internal returns(Function storage) {
        func.name = name;

        return func;
    }
    function safeAssign(Function storage func, string memory name) internal returns(Function storage) {
        uint pid = func.startProcess("safeAssign");
        Valid.isNotEmpty(name);
        return func .assertEmptyName()
                    .assign(name)
                    .finishProcess(pid);
    }

    /**----- Selector --------*/
    function safeAssign(Function storage func, bytes4 selector) internal returns(Function storage) {
        uint pid = func.startProcess("safeAssign");
        Valid.isNotEmpty(selector);
        return func .assertEmptySelector()
                    .assign(selector)
                    .finishProcess(pid);
    }
    function assign(Function storage func, bytes4 selector) internal returns(Function storage) {
        func.selector = selector;
        return func;
    }

    /**----- Implementation --------*/
    function safeAssign(Function storage func, address implementation) internal returns(Function storage) {
        uint pid = func.startProcess("safeAssign");
        Valid.isContract(implementation);
        return func .assertEmptyImpl()
                    .assign(implementation)
                    .finishProcess(pid);
    }
    function assign(Function storage func, address implementation) internal returns(Function storage) {
        func.implementation = implementation;
        return func;
    }
    function fetch(Function storage func, string memory envKey) internal returns(Function storage) {
        uint pid = func.startProcess("fetch");
        Valid.isUnassigned(func.name);
        Valid.isNotEmpty(envKey);
        return func;
    }
    function fetchAndAssign(Function storage func, string memory envKey, bytes4 selector) internal returns(Function storage) {
        uint pid = func.startProcess("fetchAndAssign");
        func.assign(envKey, selector, loadAddressFrom(envKey));
        return func.finishProcess(pid);
    }

    function loadAndAssignFromEnv(Function storage func, string memory envKey, string memory name, bytes4 selector) internal returns(Function storage) {
        uint pid = func.startProcess("loadAndAssignFromEnv");
        return func .assign(name)
                    .assign(selector)
                    .assign(loadAddressFrom(envKey))
                    .finishProcess(pid);
    }
    function loadAndAssignFromEnv(Function storage func) internal returns(Function storage) {
        Valid.isNotEmpty(func.name);
        Valid.isNotEmpty(func.selector);
        return func.loadAndAssignFromEnv(func.name, func.name, func.selector);
    }
    function safeLoadAndAssignFromEnv(Function storage func, string memory envKey, string memory name, bytes4 selector) internal returns(Function storage) {
        uint pid = func.startProcess("safeLoadAndAssignFromEnv");
        Valid.isNotEmpty(envKey);
        Valid.isNotEmpty(name);
        Valid.isNotEmpty(selector);
        return func.loadAndAssignFromEnv(envKey, name, selector).finishProcess(pid);
    }

}

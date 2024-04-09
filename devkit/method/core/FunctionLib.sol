// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Validation
import {check, Check} from "devkit/error/validation/Validation.sol";
import {Require} from "devkit/error/validation/Require.sol";
// Utils
import {ForgeHelper, loadAddressFrom} from "../../utils/ForgeHelper.sol";
import {StringUtils} from "../../utils/StringUtils.sol";
    using StringUtils for string;
import {Bytes4Utils} from "../../utils/Bytes4Utils.sol";
    using Bytes4Utils for bytes4;
import {AddressUtils} from "../../utils/AddressUtils.sol";
    using AddressUtils for address;
// Core
import {Function} from "devkit/core/Function.sol";
import {Bundle} from "devkit/core/Bundle.sol";

import {BuildStatus} from "devkit/utils/type/TypeSafetyUtils.sol";


/**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    🧩 Function
        📥 Assign Function
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
library FunctionLib {
    /**------------------------
        📥 Assign Function
    --------------------------*/
    function assign(Function storage func, string memory name, bytes4 selector, address implementation) internal returns(Function storage) {
        uint pid = func.startProcess("safeAssign");
        Check.isUnassigned(func.name);
        Check.isNotEmpty(name);
        Check.isNotEmpty(selector);
        Check.isContract(implementation);
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
        Require.assigned(func.selector);
        Require.contractAssigned(func.implementation);
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
        Check.isNotEmpty(name);
        return func .assertEmptyName()
                    .assign(name)
                    .finishProcess(pid);
    }

    /**----- Selector --------*/
    function safeAssign(Function storage func, bytes4 selector) internal returns(Function storage) {
        uint pid = func.startProcess("safeAssign");
        Check.isNotEmpty(selector);
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
        Check.isContract(implementation);
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
        Check.isUnassigned(func.name);
        Check.isNotEmpty(envKey);
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
                    .assign(envKey.loadAddress())
                    .finishProcess(pid);
    }
    function loadAndAssignFromEnv(Function storage func) internal returns(Function storage) {
        Check.isNotEmpty(func.name);
        Check.isNotEmpty(func.selector);
        return func.loadAndAssignFromEnv(func.name, func.name, func.selector);
    }
    function safeLoadAndAssignFromEnv(Function storage func, string memory envKey, string memory name, bytes4 selector) internal returns(Function storage) {
        uint pid = func.startProcess("safeLoadAndAssignFromEnv");
        Check.isNotEmpty(envKey);
        Check.isNotEmpty(name);
        Check.isNotEmpty(selector);
        return func.loadAndAssignFromEnv(envKey, name, selector).finishProcess(pid);
    }

}
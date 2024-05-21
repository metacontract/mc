// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {MCDevKit} from "devkit/MCDevKit.sol";
// Validation
import {Validator} from "devkit/system/Validator.sol";
// Utils
import {ForgeHelper} from "devkit/utils/ForgeHelper.sol";
import {param} from "devkit/system/Tracer.sol";
// Core
import {Function} from "devkit/core/Function.sol";
import {Bundle} from "devkit/core/Bundle.sol";

import {NameGenerator} from "devkit/utils/mapping/NameGenerator.sol";
    using NameGenerator for mapping(string => Bundle);


/**************************************
 *  🎁 MC Initial Configuration
 *      🌱 Init Bundle
 *      🔗 Use Function
 *      🪟 Use Facade
 *      🏰 Setup Standard Functions
***************************************/
library MCInitLib {

    /**--------------------
        🌱 Init Bundle
    ----------------------*/
    function init(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        uint pid = mc.startProcess("init", param(name));
        mc.bundle.init(name);
        return mc.finishProcess(pid);
    }
    function init(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return init(mc, mc.bundle.genUniqueName());
    }

    /**---------------------
        🔗 Use Function
    -----------------------*/
    function use(MCDevKit storage mc, string memory name, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
        uint pid = mc.startProcess("use", param(name, selector, implementation));
        // Register new function
        Validator.MUST_NotEmptyName(name);
        Validator.SHOULD_NotEmptySelector(selector);
        Validator.MUST_AddressIsContract(implementation);
        mc.functions.register(name, selector, implementation);
        // Push to current bundle
        mc.bundle.ensureInit();
        mc.bundle.findCurrent().pushFunction(mc.functions.find(name));
        return mc.finishProcess(pid);
    }
    function use(MCDevKit storage mc, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
        return use(mc, ForgeHelper.getLabel(implementation), selector, implementation);
    }
    function use(MCDevKit storage mc, Function storage func) internal returns(MCDevKit storage) {
        return use(mc, func.name, func.selector, func.implementation);
    }
    function use(MCDevKit storage mc, string memory functionName) internal returns(MCDevKit storage) {
        return use(mc, mc.functions.find(functionName));
    }

    /**------------------
        🪟 Use Facade
    --------------------*/
    /// @notice Assign facade address to current bundle
    function useFacade(MCDevKit storage mc, address facade) internal returns(MCDevKit storage) {
        uint pid = mc.startProcess("useFacade", param(facade));
        mc.bundle.ensureInit();
        mc.bundle.findCurrent().assignFacade(facade);
        return mc.finishProcess(pid);
    }

    /**--------------------------------
        🏰 Setup Standard Functions
    ----------------------------------*/
    function setupStdFunctions(MCDevKit storage mc) internal returns(MCDevKit storage) {
        uint pid = mc.startProcess("setupStdFunctions");
        mc.std.complete();
        return mc.finishProcess(pid);
    }

}

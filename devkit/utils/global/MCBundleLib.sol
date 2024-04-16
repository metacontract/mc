// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKit} from "devkit/MCDevKit.sol";
// Validation
import {Validate} from "devkit/system/Validate.sol";
// Utils
import {ForgeHelper} from "devkit/utils/ForgeHelper.sol";
import {Params} from "devkit/system/debug/Params.sol";
// Core
import {Function} from "devkit/core/Function.sol";
import {Bundle} from "devkit/core/Bundle.sol";

import {NameGenerator} from "devkit/utils/mapping/NameGenerator.sol";
    using NameGenerator for mapping(string => Bundle);

/*********************************
    🗂️ Bundle Configuration
        🌱 Init Bundle
        🔗 Use Function
        🪟 Use Facade
        🛠️ Build Bundle
**********************************/
library MCBundleLib {

    /**--------------------
        🌱 Init Bundle
    ----------------------*/
    function init(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        uint pid = mc.startProcess("init", Params.append(name));
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
        uint pid = mc.startProcess("use", Params.append(name, selector, implementation));
        // Register new function
        Validate.MUST_NotEmptyName(name);
        Validate.MUST_NotEmptySelector(selector);
        Validate.MUST_AddressIsContract(implementation);
        mc.functions.register(name, selector, implementation);
        // Push to current bundle
        mc.bundle.ensureInit();
        mc.bundle.findCurrent().pushFunction(mc.functions.find(name));
        return mc.finishProcess(pid);
    }
    function use(MCDevKit storage mc, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
        return use(mc, ForgeHelper.getLabel(implementation), selector, implementation);
    }
    function use(MCDevKit storage mc, Function storage functionInfo) internal returns(MCDevKit storage) {
        return use(mc, functionInfo.name, functionInfo.selector, functionInfo.implementation);
    }
    function use(MCDevKit storage mc, string memory functionName) internal returns(MCDevKit storage) {
        return use(mc, mc.findFunction(functionName));
    }


    /**------------------
        🪟 Use Facade
    --------------------*/
    /// @notice Assign facade address to current bundle
    function useFacade(MCDevKit storage mc, address facade) internal returns(MCDevKit storage) {
        uint pid = mc.startProcess("set");
        mc.bundle.ensureInit();
        mc.bundle.findCurrent().assignFacade(facade);
        return mc.finishProcess(pid);
    }


    /**--------------------
        🛠️ Build Bundle
    ----------------------*/
    function buildBundle(MCDevKit storage mc) internal returns(MCDevKit storage) {
        uint pid = mc.startProcess("buildBundle");
        mc.bundle.findCurrent().build();
        return mc.finishProcess(pid);
    }

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Global Methods
import "devkit/utils/GlobalMethods.sol";
// Utils
import {AddressUtils} from "devkit/utils/AddressUtils.sol";
    using AddressUtils for address;
import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;
// Core
//  functions
import {FuncInfo} from "devkit/core/functions/FuncInfo.sol";

import {MCDevKit} from "devkit/MCDevKit.sol";


/***********************************************
    🗂️ Bundle Configuration
        🌱 Init Custom Bundle
        🔗 Use Function
            ✨ Add Custom Function
            🧺 Add Custom Function to Bundle
        🪟 Set Facade
************************************************/
using BundleUtils for MCDevKit;
library BundleUtils {
    string constant LIB_NAME = "MCBundle";

    /**---------------------------
        🌱 Init Custom Bundle
    -----------------------------*/
    function init(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("init", PARAMS.append(name));
        mc.functions.safeInit(name);
        return mc.recordExecFinish(pid);
    }
    function init(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return mc.init(mc.functions.genUniqueBundleName());
    }

    //
    function ensureInit(MCDevKit storage mc) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("ensureInit");
        if (mc.functions.findCurrentBundle().hasNotName()) mc.init();
        return mc.recordExecFinish(pid);
    }


    /**---------------------
        🔗 Use Function
    -----------------------*/
    function use(MCDevKit storage mc, string memory name, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("use", PARAMS.append(name).comma().append(selector).comma().append(implementation));
        return mc   .ensureInit()
                    .addFunction(name, selector, implementation)
                    .addCurrentToBundle()
                    .recordExecFinish(pid);
    }
    function use(MCDevKit storage mc, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
        return mc.use(implementation.getLabel(), selector, implementation);
    }
    function use(MCDevKit storage mc, FuncInfo storage functionInfo) internal returns(MCDevKit storage) {
        return mc.use(functionInfo.name, functionInfo.selector, functionInfo.implementation);
    }
    // function use(MCDevKit storage mc, BundleInfo storage bundleInfo) internal returns(MCDevKit storage) {
    //     return mc;
    // } TODO
    function use(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        check(mc.functions.findFunction(name).isComplete(), "Invalid Function Name");
        return mc.use(mc.findFunction(name));
    }
        /**---------------------------
            ✨ Add Custom Function
        -----------------------------*/
        function addFunction(MCDevKit storage mc, string memory name, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
            uint pid = mc.recordExecStart("addFunction");
            mc.functions.safeAddFunction(name, selector, implementation);
            return mc.recordExecFinish(pid);
        }
        /**-------------------------------------
            🧺 Add Custom Function to Bundle
        ---------------------------------------*/
        function addToBundle(MCDevKit storage mc, FuncInfo storage functionInfo) internal returns(MCDevKit storage) {
            uint pid = mc.recordExecStart("addToBundle");
            mc.functions.addToBundle(functionInfo);
            return mc.recordExecFinish(pid);
        }
        function addCurrentToBundle(MCDevKit storage mc) internal returns(MCDevKit storage) {
            mc.functions.addToBundle(mc.findCurrentFunction());
            return mc;
        }


    /**------------------
        🪟 Use Facade
    --------------------*/
    function useFacade(MCDevKit storage mc, string memory name, address facade) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("set");
        mc.functions.set(name, facade);
        return mc.recordExecFinish(pid);
    }
    function useFacade(MCDevKit storage mc, address facade) internal returns(MCDevKit storage) {
        return mc.useFacade(mc.functions.findCurrentBundleName(), facade);
    }

}

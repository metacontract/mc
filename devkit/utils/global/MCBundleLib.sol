// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKit} from "devkit/MCDevKit.sol";
// Validation
import {Validate} from "devkit/system/Validate.sol";
import {ERR} from "devkit/system/message/ERR.sol";
// Utils
import {ForgeHelper} from "devkit/utils/ForgeHelper.sol";
import {Params} from "devkit/system/debug/Params.sol";
// Core
import {Function} from "devkit/core/Function.sol";
import {Bundle} from "devkit/core/Bundle.sol";

import {NameGenerator} from "devkit/utils/mapping/NameGenerator.sol";
    using NameGenerator for mapping(string => Bundle);

/***********************************************
    🗂️ Bundle Configuration
        🌱 Init Custom Bundle
        🔗 Use Function
            ✨ Add Custom Function
            🧺 Add Custom Function to Bundle
        🪟 Use Facade
************************************************/
library MCBundleLib {

    /**---------------------------
        🌱 Init Custom Bundle
    -----------------------------*/
    function init(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        uint pid = mc.startProcess("init", Params.append(name));
        mc.bundle.init(name);
        return mc.finishProcess(pid);
    }
    function init(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return init(mc, mc.bundle.genUniqueName());
    }

    //
    function ensureInit(MCDevKit storage mc) internal returns(MCDevKit storage) {
        uint pid = mc.startProcess("ensureInit");
        if (mc.bundle.notExistsCurrentBundle()) {
            mc.init();
        }
        return mc.finishProcess(pid);
    }


    /**---------------------
        🔗 Use Function
    -----------------------*/
    function use(MCDevKit storage mc, string memory name, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
        uint pid = mc.startProcess("use", Params.append(name, selector, implementation));
        return mc   .ensureInit()
                    .addFunction(name, selector, implementation)
                    .addCurrentToBundle()
                    .finishProcess(pid);
    }
    function use(MCDevKit storage mc, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
        return mc.use(ForgeHelper.getLabel(implementation), selector, implementation);
    }
    function use(MCDevKit storage mc, Function storage functionInfo) internal returns(MCDevKit storage) {
        return mc.use(functionInfo.name, functionInfo.selector, functionInfo.implementation);
    }
    // function use(MCDevKit storage mc, Bundle storage bundleInfo) internal returns(MCDevKit storage) {
    //     return mc;
    // } TODO
    function use(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        Validate.MUST_registered(mc.functions, name);
        return mc.use(mc.findFunction(name));
    }
        /**---------------------------
            ✨ Add Custom Function
        -----------------------------*/
        function addFunction(MCDevKit storage mc, string memory name, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
            uint pid = mc.startProcess("addFunction");
            mc.functions.register(name, selector, implementation);
            return mc.finishProcess(pid);
        }
        /**-------------------------------------
            🧺 Add Custom Function to Bundle
        ---------------------------------------*/
        function addToBundle(MCDevKit storage mc, Function storage functionInfo) internal returns(MCDevKit storage) {
            uint pid = mc.startProcess("addToBundle");
            mc.bundle.findCurrent().pushFunction(functionInfo);
            return mc.finishProcess(pid);
        }
        function addCurrentToBundle(MCDevKit storage mc) internal returns(MCDevKit storage) {
            mc.bundle.findCurrent().pushFunction(mc.functions.findCurrent());
            return mc;
        }


    /**------------------
        🪟 Use Facade
    --------------------*/
    function useFacade(MCDevKit storage mc, address facade) internal returns(MCDevKit storage) {
        uint pid = mc.startProcess("set");
        Validate.MUST_haveCurrent(mc.bundle);
        mc.bundle.findCurrent().assignFacade(facade);
        return mc.finishProcess(pid);
    }

}

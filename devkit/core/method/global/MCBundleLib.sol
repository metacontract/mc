// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKit} from "devkit/MCDevKit.sol";
// Validation
import {Require} from "devkit/error/Require.sol";
import {validate} from "devkit/error/Validate.sol";
import {ERR} from "devkit/error/Error.sol";
// Utils
import {ForgeHelper} from "devkit/utils/ForgeHelper.sol";
import {Params} from "devkit/debug/Params.sol";
// Core
import {Function} from "devkit/core/types/Function.sol";
import {Bundle} from "devkit/core/types/Bundle.sol";

import {MappingAnalyzer} from "devkit/core/method/inspector/MappingAnalyzer.sol";
    using MappingAnalyzer for mapping(string => Bundle);

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
        uint pid = mc.recordExecStart("init", Params.append(name));
        mc.bundle.init(name);
        return mc.recordExecFinish(pid);
    }
    function init(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return init(mc, mc.bundle.genUniqueName());
    }

    //
    function ensureInit(MCDevKit storage mc) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("ensureInit");
        if (mc.bundle.notExistsCurrentBundle()) {
            mc.init();
        }
        return mc.recordExecFinish(pid);
    }


    /**---------------------
        🔗 Use Function
    -----------------------*/
    function use(MCDevKit storage mc, string memory name, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("use", Params.append(name, selector, implementation));
        return mc   .ensureInit()
                    .addFunction(name, selector, implementation)
                    .addCurrentToBundle()
                    .recordExecFinish(pid);
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
        validate(mc.functions.find(name).isComplete(), "Invalid Function Name");
        return mc.use(mc.findFunction(name));
    }
        /**---------------------------
            ✨ Add Custom Function
        -----------------------------*/
        function addFunction(MCDevKit storage mc, string memory name, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
            uint pid = mc.recordExecStart("addFunction");
            mc.functions.insert(name, selector, implementation);
            return mc.recordExecFinish(pid);
        }
        /**-------------------------------------
            🧺 Add Custom Function to Bundle
        ---------------------------------------*/
        function addToBundle(MCDevKit storage mc, Function storage functionInfo) internal returns(MCDevKit storage) {
            uint pid = mc.recordExecStart("addToBundle");
            mc.bundle.findCurrent().pushFunction(functionInfo);
            return mc.recordExecFinish(pid);
        }
        function addCurrentToBundle(MCDevKit storage mc) internal returns(MCDevKit storage) {
            mc.bundle.findCurrent().pushFunction(mc.functions.findCurrent());
            return mc;
        }


    /**------------------
        🪟 Use Facade
    --------------------*/
    function useFacade(MCDevKit storage mc, address facade) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("set");
        validate(mc.bundle.existsCurrentBundle(), ERR.NOT_INIT);
        mc.bundle.findCurrent().assignFacade(facade);
        return mc.recordExecFinish(pid);
    }

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Error & Debug
import {check} from "devkit/error/Validation.sol";
import {ERR, throwError} from "devkit/error/Error.sol";
import {Debug} from "devkit/debug/Debug.sol";
// Config
import {ScanRange, Config} from "devkit/config/Config.sol";
// Utils
import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;
import {BoolUtils} from "devkit/utils/BoolUtils.sol";
    using BoolUtils for bool;
// Core
import {Function} from "devkit/core/Function.sol";
import {Bundle} from "devkit/core/Bundle.sol";
import {StdFunctions} from "devkit/core/StdFunctions.sol";

import {BundleRegistry} from "devkit/core/BundleRegistry.sol";


/**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    📙 Bundle Registry
        🌱 Init Bundle
        ✨ Add Custom Function
        🔏 Load and Assign Custom Function from Env
        🧺 Add Custom Function to Bundle
        🪟 Set Facade
        🔼 Update Current Context Function & Bundle
        🔍 Find Function & Bundle
        🏷 Generate Unique Name
        🔍 Find Custom Function
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
library BundleRegistryLib {
    /**---------------------
        🌱 Init Bundle
    -----------------------*/
    function init(BundleRegistry storage bundle, string memory name) internal returns(BundleRegistry storage) {
        uint pid = bundle.startProcess("init");
        bundle.bundles[name.safeCalcHash()].safeAssign(name);
        bundle.safeUpdateCurrentBundle(name);
        return bundle.finishProcess(pid);
    }
    function safeInit(BundleRegistry storage bundle, string memory name) internal returns(BundleRegistry storage) {
        uint pid = bundle.startProcess("safeInit");
        check(name.isNotEmpty(), "Empty Name");
        return bundle.assertBundleNotExists(name)
                        .init(name)
                        .finishProcess(pid);
    }


    /**-------------------------------------
        🧺 Add Custom Function to Bundle
    ---------------------------------------*/
    function addToBundle(BundleRegistry storage bundle, Function storage functionInfo) internal returns(BundleRegistry storage) {
        uint pid = bundle.startProcess("addToBundle", "function");
        bundle.findCurrentBundle().safeAdd(functionInfo);
        return bundle.finishProcess(pid);
    }
    function addToBundle(BundleRegistry storage bundle, Function[] storage functionInfos) internal returns(BundleRegistry storage) {
        uint pid = bundle.startProcess("addToBundle", "bundle"); // TODO params
        bundle.findCurrentBundle().safeAdd(functionInfos);
        return bundle.finishProcess(pid);
    }


    /**------------------
        🪟 Set Facade
    --------------------*/
    function set(BundleRegistry storage bundle, string memory name, address facade) internal returns(BundleRegistry storage) {
        uint pid = bundle.startProcess("set");
        bundle.bundles[name.safeCalcHash()]
                    .assertExists()
                    .safeAssign(facade);
        return bundle.finishProcess(pid);
    }
    function set(BundleRegistry storage bundle, address facade) internal returns(BundleRegistry storage) {
        uint pid = bundle.startProcess("set");
        return bundle.set(bundle.findCurrentBundleName(), facade).finishProcess(pid);
    }


    /**------------------------------------------------
        🔼 Update Current Context
    --------------------------------------------------*/
    function safeUpdateCurrentBundle(BundleRegistry storage bundle, string memory name) internal returns(BundleRegistry storage) {
        uint pid = bundle.startProcess("safeUpdateCurrentBundle");
        bundle.currentBundleName = name.assertNotEmpty();
        return bundle.finishProcess(pid);
    }


    /**-----------------------------------------------
        ♻️ Reset Current Context Function & Bundle
    -------------------------------------------------*/
    function reset(BundleRegistry storage bundle) internal returns(BundleRegistry storage) {
        uint pid = bundle.startProcess("reset");
        delete bundle.currentBundleName;
        return bundle.finishProcess(pid);
    }


    /**-------------------------------
        🔍 Find Function & Bundle
    ---------------------------------*/
    function findBundle(BundleRegistry storage bundle, string memory name) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("findBundle");
        return bundle.bundles[name.safeCalcHash()].finishProcess(pid);
    }
    function findCurrentBundle(BundleRegistry storage bundle) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("findCurrentBundle");
        return bundle.findBundle(bundle.findCurrentBundleName()).finishProcess(pid);
    }
        function findCurrentBundleName(BundleRegistry storage bundle) internal returns(string memory) {
            uint pid = bundle.startProcess("findCurrentBundleName");
            return bundle.currentBundleName.assertNotEmpty().recordExecFinish(pid);
        }


    /**-----------------------------
        🏷 Generate Unique Name
    -------------------------------*/
    function genUniqueBundleName(BundleRegistry storage bundle) internal returns(string memory name) {
        uint pid = bundle.startProcess("genUniqueBundleName");
        ScanRange storage range = Config().SCAN_RANGE;
        for (uint i = range.START; i <= range.END; ++i) {
            name = Config().DEFAULT_BUNDLE_NAME.toSequential(i);
            if (bundle.existsBundle(name).isFalse()) return name.recordExecFinish(pid);
        }
        throwError(ERR.FIND_NAME_OVER_RANGE);
    }

}

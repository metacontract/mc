// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**--------------------------
    Apply Support Methods
----------------------------*/
import {ProcessLib} from "devkit/core/method/debug/ProcessLib.sol";
    using ProcessLib for BundleRegistry global;
import {Inspector} from "devkit/core/method/inspector/Inspector.sol";
    using Inspector for BundleRegistry global;
import {MappingAnalyzer} from "devkit/core/method/inspector/MappingAnalyzer.sol";
    using MappingAnalyzer for mapping(string => Bundle);

// Validation
import {validate} from "devkit/error/Validate.sol";
import {Require} from "devkit/error/Require.sol";
// Core Type
import {Bundle} from "devkit/core/types/Bundle.sol";
import {Function} from "devkit/core/types/Function.sol";


/**========================
    📙 Bundle Registry
==========================*/
using BundleRegistryLib for BundleRegistry global;
struct BundleRegistry {
    mapping(string name => Bundle) bundles;
    string currentBundleName;
}
library BundleRegistryLib {
    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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

    /**---------------------
        🌱 Init Bundle
    -----------------------*/
    function init(BundleRegistry storage bundle, string memory name) internal returns(BundleRegistry storage) {
        uint pid = bundle.startProcess("init");
        bundle.bundles[name].assignName(name);
        bundle.safeUpdateCurrentBundle(name);
        return bundle.finishProcess(pid);
    }
    function safeInit(BundleRegistry storage bundle, string memory name) internal returns(BundleRegistry storage) {
        uint pid = bundle.startProcess("safeInit");
        Require.notEmpty(name);
        Require.bundleNotExists(bundle, name);
        return bundle   .init(name)
                        .finishProcess(pid);
    }


    /**-------------------------------------
        🧺 Add Custom Function to Bundle
    ---------------------------------------*/
    function addToBundle(BundleRegistry storage bundle, Function storage functionInfo) internal returns(BundleRegistry storage) {
        uint pid = bundle.startProcess("addToBundle", "function");
        bundle.findCurrentBundle().pushFunction(functionInfo);
        return bundle.finishProcess(pid);
    }
    function addToBundle(BundleRegistry storage bundle, Function[] storage functions) internal returns(BundleRegistry storage) {
        uint pid = bundle.startProcess("addToBundle", "bundle"); // TODO params
        bundle.findCurrentBundle().pushFunctions(functions);
        return bundle.finishProcess(pid);
    }


    /**------------------
        🪟 Set Facade
    --------------------*/
    function set(BundleRegistry storage bundle, string memory name, address facade) internal returns(BundleRegistry storage) {
        uint pid = bundle.startProcess("set");
        Require.exists(bundle.bundles[name]);
        bundle.bundles[name].assignFacade(facade);
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
        Require.notEmpty(name);
        bundle.currentBundleName = name;
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
        return bundle.bundles[name].finishProcess(pid);
    }
    function findCurrentBundle(BundleRegistry storage bundle) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("findCurrentBundle");
        return bundle.findBundle(bundle.findCurrentBundleName()).finishProcess(pid);
    }
        function findCurrentBundleName(BundleRegistry storage bundle) internal returns(string memory) {
            uint pid = bundle.startProcess("findCurrentBundleName");
            Require.notEmpty(bundle.currentBundleName);
            return bundle.currentBundleName;
            // return bundle.currentBundleName.recordExecFinish(pid);
        }


    /**-----------------------------
        🏷 Generate Unique Name
    -------------------------------*/
    function genUniqueName(BundleRegistry storage bundle) internal returns(string memory name) {
        return bundle.bundles.genUniqueName();
    }

}

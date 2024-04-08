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
import {Function} from "./Function.sol";
import {Bundle} from "./Bundle.sol";
import {StdFunctions} from "./StdFunctions.sol";


/**-------------------------------
    🧩 UCS Functions Registry
---------------------------------*/
using BundleRegistryLib for BundleRegistry global;
struct BundleRegistry {
    StdFunctions std;
    mapping(bytes32 nameHash => Function) customs;
    mapping(bytes32 nameHash => Bundle) bundles;
    string currentFunctionName;
    string currentBundleName;
}

/**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    << Primary >>
        🌱 Init Bundle
        ✨ Add Custom Function
        🔏 Load and Assign Custom Function from Env
        🧺 Add Custom Function to Bundle
        🪟 Set Facade
        🔼 Update Current Context Function & Bundle
        🔍 Find Function & Bundle
        🏷 Generate Unique Name
    << Helper >>
        🔍 Find Custom Function
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
library BundleRegistryLib {
    string constant LIB_NAME = "BundleRegistry";


    /**---------------------
        🌱 Init Bundle
    -----------------------*/
    function init(BundleRegistry storage bundle, string memory name) internal returns(BundleRegistry storage) {
        uint pid = bundle.recordExecStart("init");
        bundle.bundles[name.safeCalcHash()].safeAssign(name);
        bundle.safeUpdateCurrentBundle(name);
        return bundle.recordExecFinish(pid);
    }
    function safeInit(BundleRegistry storage bundle, string memory name) internal returns(BundleRegistry storage) {
        uint pid = bundle.recordExecStart("safeInit");
        check(name.isNotEmpty(), "Empty Name");
        return bundle.assertBundleNotExists(name)
                        .init(name)
                        .recordExecFinish(pid);
    }


    /**-------------------------------------
        🧺 Add Custom Function to Bundle
    ---------------------------------------*/
    function addToBundle(BundleRegistry storage bundle, Function storage functionInfo) internal returns(BundleRegistry storage) {
        uint pid = bundle.recordExecStart("addToBundle", "function");
        bundle.findCurrentBundle().safeAdd(functionInfo);
        return bundle.recordExecFinish(pid);
    }
    function addToBundle(BundleRegistry storage bundle, Function[] storage functionInfos) internal returns(BundleRegistry storage) {
        uint pid = bundle.recordExecStart("addToBundle", "bundle"); // TODO params
        bundle.findCurrentBundle().safeAdd(functionInfos);
        return bundle.recordExecFinish(pid);
    }


    /**------------------
        🪟 Set Facade
    --------------------*/
    function set(BundleRegistry storage bundle, string memory name, address facade) internal returns(BundleRegistry storage) {
        uint pid = bundle.recordExecStart("set");
        bundle.bundles[name.safeCalcHash()]
                    .assertExists()
                    .safeAssign(facade);
        return bundle.recordExecFinish(pid);
    }
    function set(BundleRegistry storage bundle, address facade) internal returns(BundleRegistry storage) {
        uint pid = bundle.recordExecStart("set");
        return bundle.set(bundle.findCurrentBundleName(), facade).recordExecFinish(pid);
    }


    /**------------------------------------------------
        🔼 Update Current Context
    --------------------------------------------------*/
    function safeUpdateCurrentBundle(BundleRegistry storage bundle, string memory name) internal returns(BundleRegistry storage) {
        uint pid = bundle.recordExecStart("safeUpdateCurrentBundle");
        bundle.currentBundleName = name.assertNotEmpty();
        return bundle.recordExecFinish(pid);
    }


    /**-----------------------------------------------
        ♻️ Reset Current Context Function & Bundle
    -------------------------------------------------*/
    function reset(BundleRegistry storage bundle) internal returns(BundleRegistry storage) {
        uint pid = bundle.recordExecStart("reset");
        delete bundle.currentBundleName;
        return bundle.recordExecFinish(pid);
    }


    /**-------------------------------
        🔍 Find Function & Bundle
    ---------------------------------*/
    function findBundle(BundleRegistry storage bundle, string memory name) internal returns(Bundle storage) {
        uint pid = bundle.recordExecStart("findBundle");
        return bundle.bundles[name.safeCalcHash()].finishProcess(pid);
    }
    function findCurrentBundle(BundleRegistry storage bundle) internal returns(Bundle storage) {
        uint pid = bundle.recordExecStart("findCurrentBundle");
        return bundle.findBundle(bundle.findCurrentBundleName()).finishProcess(pid);
    }
        function findCurrentBundleName(BundleRegistry storage bundle) internal returns(string memory) {
            uint pid = bundle.recordExecStart("findCurrentBundleName");
            return bundle.currentBundleName.assertNotEmpty().recordExecFinish(pid);
        }


    /**-----------------------------
        🏷 Generate Unique Name
    -------------------------------*/
    function genUniqueBundleName(BundleRegistry storage bundle) internal returns(string memory name) {
        uint pid = bundle.recordExecStart("genUniqueBundleName");
        ScanRange storage range = Config().SCAN_RANGE;
        for (uint i = range.START; i <= range.END; ++i) {
            name = Config().DEFAULT_BUNDLE_NAME.toSequential(i);
            if (bundle.existsBundle(name).isFalse()) return name.recordExecFinish(pid);
        }
        throwError(ERR.FIND_NAME_OVER_RANGE);
    }



    /**-------------------------------
        🧐 Inspectors & Assertions
    ---------------------------------*/
    function existsBundle(BundleRegistry storage bundle, string memory name) internal returns(bool) {
        return bundle.bundles[name.safeCalcHash()].hasName();
    }
    function notExistsBundle(BundleRegistry storage bundle, string memory name) internal returns(bool) {
        return bundle.existsBundle(name).isNot();
    }
    function assertBundleNotExists(BundleRegistry storage bundle, string memory name) internal returns(BundleRegistry storage) {
        check(bundle.notExistsBundle(name), "Bundle Already Exists");
        return bundle;
    }

    function existsCurrentBundle(BundleRegistry storage bundle) internal returns(bool) {
        return bundle.currentBundleName.isNotEmpty();
    }
    function notExistsCurrentBundle(BundleRegistry storage bundle) internal returns(bool) {
        return bundle.existsCurrentBundle().isNot();
    }


    /**----------------
        🐞 Debug
    ------------------*/
    /**
        Record Start
     */
    function recordExecStart(BundleRegistry storage, string memory funcName, string memory params) internal returns(uint) {
        return Debug.recordExecStart(LIB_NAME, funcName, params);
    }
    function recordExecStart(BundleRegistry storage bundle, string memory funcName) internal returns(uint) {
        return bundle.recordExecStart(funcName, "");
    }

    /**
        Record Finish
     */
    function recordExecFinish(BundleRegistry storage bundle, uint pid) internal returns(BundleRegistry storage) {
        Debug.recordExecFinish(pid);
        return bundle;
    }

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Global Methods
import "@devkit/utils/GlobalMethods.sol";
// Config
import {Config} from "@devkit/Config.sol";
// Utils
import {StringUtils} from "@devkit/utils/StringUtils.sol";
    using StringUtils for string;
import {BoolUtils} from "@devkit/utils/BoolUtils.sol";
    using BoolUtils for bool;
// Errors
import {Errors} from "@devkit/errors/Errors.sol";
// Debug
import {Debug} from "@devkit/debug/Debug.sol";
// Core
import {FuncInfo} from "@devkit/core/functions/FuncInfo.sol";
import {BundleInfo} from "@devkit/core/functions/BundleInfo.sol";
import {MCStdFuncs} from "@devkit/core/functions/MCStdFuncs.sol";


/****************************************
    🧩 Meta Contract Functions Registry
*****************************************/
using FuncRegistryUtils for FuncRegistry global;
struct FuncRegistry {
    MCStdFuncs std;
    mapping(bytes32 nameHash => FuncInfo) customs;
    mapping(bytes32 nameHash => BundleInfo) bundles;
    string currentFunctionName;
    string currentBundleName;
}

library FuncRegistryUtils {
    string constant LIB_NAME = "FunctionRegistry";

    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    << Primary >>
        🌱 Init Bundle
        ✨ Add Custom Function
        🔏 Load and Assign Custom Function from Env
        🧺 Add Custom Function to Bundle
        🖼 Set Facade
        🔼 Update Current Context Function & Bundle
        🔍 Find Function & Bundle
        🏷 Generate Unique Name
    << Helper >>
        🔍 Find Custom Function
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/


    /**---------------------
        🌱 Init Bundle
    -----------------------*/
    function init(FuncRegistry storage functions, string memory name) internal returns(FuncRegistry storage) {
        uint pid = functions.recordExecStart("init");
        functions.bundles[name.safeCalcHash()].safeAssign(name);
        functions.safeUpdateCurrentBundle(name);
        return functions.recordExecFinish(pid);
    }
    function safeInit(FuncRegistry storage functions, string memory name) internal returns(FuncRegistry storage) {
        uint pid = functions.recordExecStart("safeInit");
        check(name.isNotEmpty(), "Empty Name");
        return functions.assertBundleNotExists(name)
                        .init(name)
                        .recordExecFinish(pid);
    }


    /**---------------------------
        ✨ Add Custom Function
    -----------------------------*/
    function safeAddFunction(FuncRegistry storage functions, string memory name, bytes4 selector, address implementation) internal returns(FuncRegistry storage) {
        uint pid = functions.recordExecStart("safeAddFunction");
        check(name.isNotEmpty(), "Empty Name");
        functions.customs[name.safeCalcHash()]
                .safeAssign(name)
                .safeAssign(selector)
                .safeAssign(implementation);
        functions.safeUpdateCurrentFunction(name);
        return functions.recordExecFinish(pid);
    }


    /**---------------------------------------------
        🔏 Load and Add Custom Function from Env
    -----------------------------------------------*/
    function safeLoadAndAdd(FuncRegistry storage functions, string memory envKey, string memory name, bytes4 selector, address implementation) internal returns(FuncRegistry storage) {
        uint pid = functions.recordExecStart("safeLoadAndAdd");
        functions.customs[name.safeCalcHash()]
                    .loadAndAssignFromEnv(envKey, name, selector);
        functions.safeUpdateCurrentFunction(name);
        return functions.recordExecFinish(pid);
    }


    /**-------------------------------------
        🧺 Add Custom Function to Bundle
    ---------------------------------------*/
    function addToBundle(FuncRegistry storage functions, FuncInfo storage functionInfo) internal returns(FuncRegistry storage) {
        uint pid = functions.recordExecStart("addToBundle", "function");
        functions.findCurrentBundle().safeAdd(functionInfo);
        return functions.recordExecFinish(pid);
    }
    function addToBundle(FuncRegistry storage functions, FuncInfo[] storage functionInfos) internal returns(FuncRegistry storage) {
        uint pid = functions.recordExecStart("addToBundle", "functions"); // TODO params
        functions.findCurrentBundle().safeAdd(functionInfos);
        return functions.recordExecFinish(pid);
    }


    /**------------------
        🖼 Set Facade
    --------------------*/
    function set(FuncRegistry storage functions, string memory name, address facade) internal returns(FuncRegistry storage) {
        uint pid = functions.recordExecStart("set");
        functions.bundles[name.safeCalcHash()]
                    .assertExists()
                    .safeAssign(facade);
        return functions.recordExecFinish(pid);
    }
    function set(FuncRegistry storage functions, address facade) internal returns(FuncRegistry storage) {
        uint pid = functions.recordExecStart("set");
        return functions.set(functions.findCurrentBundleName(), facade).recordExecFinish(pid);
    }


    /**------------------------------------------------
        🔼 Update Current Context Function & Bundle
    --------------------------------------------------*/
    /**----- 🧩 Function -------*/
    function safeUpdateCurrentFunction(FuncRegistry storage functions, string memory name) internal returns(FuncRegistry storage) {
        uint pid = functions.recordExecStart("safeUpdateCurrentFunction");
        functions.currentFunctionName = name.assertNotEmpty();
        return functions.recordExecFinish(pid);
    }
    /**----- 🧺 Bundle -------*/
    function safeUpdateCurrentBundle(FuncRegistry storage functions, string memory name) internal returns(FuncRegistry storage) {
        uint pid = functions.recordExecStart("safeUpdateCurrentBundle");
        functions.currentBundleName = name.assertNotEmpty();
        return functions.recordExecFinish(pid);
    }


    /**-------------------------------
        🔍 Find Function & Bundle
    ---------------------------------*/
    /**----- 🧩 Function -------*/
    function findFunction(FuncRegistry storage functions, string memory name) internal returns(FuncInfo storage) {
        uint pid = functions.recordExecStart("findFunction");
        return functions.customs[name.safeCalcHash()].assertExists().recordExecFinish(pid);
    }
    function findCurrentFunction(FuncRegistry storage functions) internal returns(FuncInfo storage) {
        uint pid = functions.recordExecStart("findCurrentFunction");
        return functions.findFunction(functions.findCurrentFunctionName()).recordExecFinish(pid);
    }
        function findCurrentFunctionName(FuncRegistry storage functions) internal returns(string memory) {
            uint pid = functions.recordExecStart("findCurrentFunctionName");
            return functions.currentFunctionName.assertNotEmpty().recordExecFinish(pid);
        }

    /**----- 🧺 Bundle -------*/
    function findBundle(FuncRegistry storage functions, string memory name) internal returns(BundleInfo storage) {
        uint pid = functions.recordExecStart("findBundle");
        return functions.bundles[name.safeCalcHash()].recordExecFinish(pid);
    }
    function findCurrentBundle(FuncRegistry storage functions) internal returns(BundleInfo storage) {
        uint pid = functions.recordExecStart("findCurrentBundle");
        return functions.findBundle(functions.findCurrentBundleName()).recordExecFinish(pid);
    }
        function findCurrentBundleName(FuncRegistry storage functions) internal returns(string memory) {
            uint pid = functions.recordExecStart("findCurrentBundleName");
            return functions.currentBundleName.assertNotEmpty().recordExecFinish(pid);
        }


    /**-----------------------------
        🏷 Generate Unique Name
    -------------------------------*/
    function genUniqueBundleName(FuncRegistry storage functions) internal returns(string memory name) {
        uint pid = functions.recordExecStart("genUniqueBundleName");
        Config.ScanRange memory range = Config.SCAN_RANGE();
        for (uint i = range.start; i <= range.end; ++i) {
            name = Config.DEFAULT_BUNDLE_NAME.toSequential(i);
            if (functions.existsBundle(name).isFalse()) return name.recordExecFinish(pid);
        }
        throwError(Errors.FIND_NAME_OVER_RANGE);
    }



    /**-------------------------------
        🧐 Inspectors & Assertions
    ---------------------------------*/
    function existsBundle(FuncRegistry storage functions, string memory name) internal returns(bool) {
        return functions.bundles[name.safeCalcHash()].hasName();
    }
    function notExistsBundle(FuncRegistry storage functions, string memory name) internal returns(bool) {
        return functions.existsBundle(name).isNot();
    }
    function assertBundleNotExists(FuncRegistry storage functions, string memory name) internal returns(FuncRegistry storage) {
        check(functions.notExistsBundle(name), "Bundle Already Exists");
        return functions;
    }


    /**----------------
        🐞 Debug
    ------------------*/
    /**
        Record Start
     */
    function recordExecStart(FuncRegistry storage, string memory funcName, string memory params) internal returns(uint) {
        return Debug.recordExecStart(LIB_NAME, funcName, params);
    }
    function recordExecStart(FuncRegistry storage functions, string memory funcName) internal returns(uint) {
        return functions.recordExecStart(funcName, "");
    }

    /**
        Record Finish
     */
    function recordExecFinish(FuncRegistry storage functions, uint pid) internal returns(FuncRegistry storage) {
        Debug.recordExecFinish(pid);
        return functions;
    }

}

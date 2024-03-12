// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Global Methods
import "@devkit/utils/GlobalMethods.sol";
// Config
import {Config} from "@devkit/Config.sol";
// Utils
import {ForgeHelper} from "@devkit/utils/ForgeHelper.sol";
import {StringUtils} from "@devkit/utils/StringUtils.sol";
    using StringUtils for string;
import {BoolUtils} from "@devkit/utils/BoolUtils.sol";
    using BoolUtils for bool;
// Errors
import {ERR_FIND_NAME_OVER_RANGE} from "@devkit/errors/Errors.sol";
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
    function __recordExecStart(string memory funcName, string memory params) internal {
        Debug.recordExecStart(LIB_NAME, funcName, params);
    }
    function __recordExecStart(string memory funcName) internal {
        __recordExecStart(funcName, "");
    }
    function __signalComletion() internal {}
    function signalCompletion(FuncRegistry storage target) internal returns(FuncRegistry storage) {
        __signalComletion();
        return target;
    }

    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        🌱 Init Bundle
        ✨ Add Custom Function
        🔏 Load and Assign from Env
        🧺 Add Custom Function to Bundle
        🖼 Set Facade
        🔍 Find Custom Function
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/


    /**---------------------------
        🌱 Init Custom Bundle
    -----------------------------*/
    function safeInit(FuncRegistry storage functions, string memory name) internal returns(FuncRegistry storage) {
        __recordExecStart("safeInit");
        check(name.isNotEmpty(), "Empty Name");
        return functions.assertBundleNotExists(name)
                        .init(name);
    }
    function init(FuncRegistry storage functions, string memory name) internal returns(FuncRegistry storage) {
        __recordExecStart("init");
        functions.bundles[name.safeCalcHash()].safeAssign(name);
        functions.safeUpdateCurrentBundle(name);
        return functions;
    }


    /**---------------------------
        ✨ Add Custom Function
    -----------------------------*/
    function safeAddFunction(FuncRegistry storage functions, string memory name, bytes4 selector, address implementation) internal returns(FuncRegistry storage) {
        __recordExecStart("safeAddFunction");
        check(name.isNotEmpty(), "Empty Name");
        functions.customs[name.safeCalcHash()]
                .safeAssign(name)
                .safeAssign(selector)
                .safeAssign(implementation);
        functions.safeUpdateCurrentFunction(name);
        return functions;
    }


    /**--------------------------------
        🔏 Load and Assign from Env
    ----------------------------------*/


    /**-------------------------------------
        🧺 Add Custom Function to Bundle
    ---------------------------------------*/
    function addToBundle(FuncRegistry storage functions, FuncInfo storage functionInfo) internal returns(FuncRegistry storage) {
        functions.findCurrentBundle().safeAdd(functionInfo);
        return functions;
    }
    function addToBundle(FuncRegistry storage functions, FuncInfo[] storage functionInfos) internal returns(FuncRegistry storage) {
        functions.findCurrentBundle().safeAdd(functionInfos);
        return functions;
    }


    /**------------------
        🖼 Set Facade
    --------------------*/
    function set(FuncRegistry storage functions, string memory name, address facade) internal returns(FuncRegistry storage) {
        __recordExecStart("set");
        functions.bundles[name.safeCalcHash()]
                    .assertExists()
                    .safeAssign(facade);
        return functions;
    }


    /**----------------------
        🔼 Update Context
    ------------------------*/
    /**----- 🧩 FunctionInfo -------*/
    function safeUpdateCurrentFunction(FuncRegistry storage functions, string memory name) internal returns(FuncRegistry storage) {
        __recordExecStart("safeUpdateCurrentFunction");
        functions.currentFunctionName = name.assertNotEmpty();
        return functions;
    }
    /**----- 🧺 Bundle -------*/
    function safeUpdateCurrentBundle(FuncRegistry storage functions, string memory name) internal returns(FuncRegistry storage) {
        functions.currentBundleName = name.assertNotEmpty();
        return functions;
    }


    /**----------------------------
        🔍 Find Function
    ------------------------------*/
    function findFunction(FuncRegistry storage functions, string memory name) internal returns(FuncInfo storage) {
        __recordExecStart("findFunction");
        return functions.customs[name.safeCalcHash()];
    }
    function findCurrentFunction(FuncRegistry storage functions) internal returns(FuncInfo storage) {
        return functions.findFunction(functions.findCurrentFunctionName());
    }
        function findCurrentFunctionName(FuncRegistry storage functions) internal returns(string memory) {
            __recordExecStart("findCurrentFunctionName");
            return functions.currentFunctionName.assertNotEmpty();
        }

    function findBundle(FuncRegistry storage functions, string memory name) internal returns(BundleInfo storage) {
        __recordExecStart("findBundle");
        return functions.bundles[name.safeCalcHash()];
    }
    function findCurrentBundle(FuncRegistry storage functions) internal returns(BundleInfo storage) {
        __recordExecStart("findCurrentBundle");
        return functions.findBundle(functions.findCurrentBundleName());
    }
        function findCurrentBundleName(FuncRegistry storage functions) internal returns(string memory) {
            __recordExecStart("findCurrentBundleName");
            return functions.currentBundleName.assertNotEmpty();
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


    /**
        Naming
     */
    function findUnusedCustomBundleName(FuncRegistry storage functions) internal returns(string memory name) {
        (uint start, uint end) = Config.SCAN_RANGE();
        string memory baseName = "CustomBundle";

        for (uint i = start; i <= end; ++i) {
            name = ForgeHelper.appendNumberToNameIfNotOne(baseName, i);
            if (!functions.existsBundle(name)) return name;
        }

        throwError(ERR_FIND_NAME_OVER_RANGE);
    }
}

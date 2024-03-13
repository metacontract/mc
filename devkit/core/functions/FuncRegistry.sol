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
    function recordExecStart(FuncRegistry storage, string memory funcName, string memory params) internal returns(uint) {
        return Debug.recordExecStart(LIB_NAME, funcName, params);
    }
    function recordExecStart(FuncRegistry storage functions, string memory funcName) internal returns(uint) {
        return functions.recordExecStart(funcName, "");
    }
    function recordExecFinish(FuncRegistry storage functions, uint pid) internal returns(FuncRegistry storage) {
        Debug.recordExecFinish(pid);
        return functions;
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
        uint pid = functions.recordExecStart("safeInit");
        check(name.isNotEmpty(), "Empty Name");
        return functions.assertBundleNotExists(name)
                        .init(name)
                        .recordExecFinish(pid);
    }
    function init(FuncRegistry storage functions, string memory name) internal returns(FuncRegistry storage) {
        uint pid = functions.recordExecStart("init");
        functions.bundles[name.safeCalcHash()].safeAssign(name);
        functions.safeUpdateCurrentBundle(name);
        return functions.recordExecFinish(pid);
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
        uint pid = functions.recordExecStart("set");
        functions.bundles[name.safeCalcHash()]
                    .assertExists()
                    .safeAssign(facade);
        return functions.recordExecFinish(pid);
    }


    /**----------------------
        🔼 Update Context
    ------------------------*/
    /**----- 🧩 FunctionInfo -------*/
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


    /**----------------------------
        🔍 Find Function
    ------------------------------*/
    function findFunction(FuncRegistry storage functions, string memory name) internal returns(FuncInfo storage) {
        uint pid = functions.recordExecStart("findFunction");
        return functions.customs[name.safeCalcHash()];
    }
    function findCurrentFunction(FuncRegistry storage functions) internal returns(FuncInfo storage) {
        return functions.findFunction(functions.findCurrentFunctionName());
    }
        function findCurrentFunctionName(FuncRegistry storage functions) internal returns(string memory) {
            uint pid = functions.recordExecStart("findCurrentFunctionName");
            return functions.currentFunctionName.assertNotEmpty();
        }

    function findBundle(FuncRegistry storage functions, string memory name) internal returns(BundleInfo storage) {
        uint pid = functions.recordExecStart("findBundle");
        return functions.bundles[name.safeCalcHash()];
    }
    function findCurrentBundle(FuncRegistry storage functions) internal returns(BundleInfo storage) {
        uint pid = functions.recordExecStart("findCurrentBundle");
        return functions.findBundle(functions.findCurrentBundleName());
    }
        function findCurrentBundleName(FuncRegistry storage functions) internal returns(string memory) {
            uint pid = functions.recordExecStart("findCurrentBundleName");
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

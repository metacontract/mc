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
    modifier debug(string memory location) {
        Debug.stack(location);
        _;
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
    function safeInit(FuncRegistry storage functions, string memory name) debug("Safe Init New Bundle") internal returns(FuncRegistry storage) {
        check(name.isNotEmpty(), "Empty Name");
        return functions.assertBundleNotExists(name)
                        .init(name);
    }
    string constant init_ = "Init New Bundle";
    function init(FuncRegistry storage functions, string memory name) internal returns(FuncRegistry storage) {
        functions.bundles[name.safeCalcHash()].safeAssign(name);
        functions.safeUpdateCurrentBundle(name);
        return functions;
    }


    /**---------------------------
        ✨ Add Custom Function
    -----------------------------*/
    string constant safeAdd_ = "Safe Add Custom Function";
    function safeAddFunction(FuncRegistry storage functions, string memory name, bytes4 selector, address implementation) internal returns(FuncRegistry storage) {
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
    string constant set_ = "Set Facade";
    function set(FuncRegistry storage functions, string memory name, address facade) internal returns(FuncRegistry storage) {
        functions.bundles[name.safeCalcHash()]
                    .assertExists()
                    .safeAssign(facade);
        return functions;
    }


    /**----------------------
        🔼 Update Context
    ------------------------*/
    string constant safeUpdate = "Safe Update DevKit Context";
    /**----- 🧩 FunctionInfo -------*/
    function safeUpdateCurrentFunction(FuncRegistry storage functions, string memory name) internal returns(FuncRegistry storage) {
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
    string constant findFunction_ = "Find Function";
    function findFunction(FuncRegistry storage functions, string memory name) internal returns(FuncInfo storage) {
        return functions.customs[name.safeCalcHash()].assertComplete();
    }
    function findCurrentFunction(FuncRegistry storage functions) internal returns(FuncInfo storage) {
        return functions.findFunction(functions.findCurrentFunctionName());
    }
        string constant findCurrentFunctionName_ = "Find Current Function Name";
        function findCurrentFunctionName(FuncRegistry storage functions) internal returns(string memory) {
            return functions.currentFunctionName.assertNotEmpty();
        }

    string constant findBundle_ = "Find Bundle";
    function findBundle(FuncRegistry storage functions, string memory name) internal returns(BundleInfo storage) {
        return functions.bundles[name.safeCalcHash()].assertComplete();
    }
    function findCurrentBundle(FuncRegistry storage functions) internal returns(BundleInfo storage) {
        return functions.findBundle(functions.findCurrentBundleName());
    }
        string constant findCurrentBundleName_ = "Find Current Bundle Name";
        function findCurrentBundleName(FuncRegistry storage functions) internal returns(string memory) {
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

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {DevUtils} from "DevKit/common/DevUtils.sol";
import {NameUtils} from "DevKit/common/NameUtils.sol";
import {ForgeHelper} from "DevKit/common/ForgeHelper.sol";
import "DevKit/common/Errors.sol";
import {FuncInfo} from "./FuncInfo.sol";
import {BundleInfo} from "./BundleInfo.sol";
import {MCStdFuncs} from "./MCStdFuncs.sol";

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
    using DevUtils for *;
    using NameUtils for string;
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
    string constant safeInit_ = "Safe Init New Bundle";
    function safeInit(FuncRegistry storage functions, string memory name) internal returns(FuncRegistry storage) {
        check(name.isNotEmpty(), "Empty Name", safeInit_);
        return functions.assertBundleNotExistsAt(name, safeInit_)
                        .init(name);
    }
    string constant init_ = "Init New Bundle";
    function init(FuncRegistry storage functions, string memory name) internal returns(FuncRegistry storage) {
        functions.bundles[name.safeCalcHashAt(init_)].safeAssign(name);
        functions.safeUpdateCurrentBundle(name);
        return functions;
    }


    /**---------------------------
        ✨ Add Custom Function
    -----------------------------*/
    string constant safeAdd = "Safe Add Custom Function";
    function safeAddFunction(FuncRegistry storage functions, string memory name, bytes4 selector, address implementation) internal returns(FuncRegistry storage) {
        check(name.isNotEmpty(), "Empty Name", safeAdd);
        functions.customs[name.safeCalcHashAt(safeAdd)]
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
        functions.bundles[name.safeCalcHashAt("")]
                    .assertExistsAt(set_)
                    .safeAssign(facade);
        return functions;
    }


    /**----------------------
        🔼 Update Context
    ------------------------*/
    string constant safeUpdate = "Safe Update DevKit Context";
    /**----- 🧩 FunctionInfo -------*/
    function safeUpdateCurrentFunction(FuncRegistry storage functions, string memory name) internal returns(FuncRegistry storage) {
        functions.currentFunctionName = name.assertNotEmptyAt(safeUpdate);
        return functions;
    }
    /**----- 🧺 Bundle -------*/
    function safeUpdateCurrentBundle(FuncRegistry storage functions, string memory name) internal returns(FuncRegistry storage) {
        functions.currentBundleName = name.assertNotEmptyAt(safeUpdate);
        return functions;
    }


    /**----------------------------
        🔍 Find Function
    ------------------------------*/
    string constant findFunction_ = "Find Function";
    function findFunction(FuncRegistry storage functions, string memory name) internal returns(FuncInfo storage) {
        return functions.customs[name.safeCalcHashAt(findFunction_)].assertCompleteAt(findFunction_);
    }
    function findCurrentFunction(FuncRegistry storage functions) internal returns(FuncInfo storage) {
        return functions.findFunction(functions.findCurrentFunctionName());
    }
        function findCurrentFunctionName(FuncRegistry storage functions) internal returns(string memory) {
            return functions.currentFunctionName.assertNotEmptyAt("Find Current Function Name");
        }

    string constant findBundle_ = "Find Bundle";
    function findBundle(FuncRegistry storage functions, string memory name) internal returns(BundleInfo storage) {
        return functions.bundles[name.safeCalcHashAt(findBundle_)].assertCompleteAt(findBundle_);
    }
    function findCurrentBundle(FuncRegistry storage functions) internal returns(BundleInfo storage) {
        return functions.findBundle(functions.findCurrentBundleName());
    }
        function findCurrentBundleName(FuncRegistry storage functions) internal returns(string memory) {
            return functions.currentBundleName.assertNotEmptyAt("Find Current Bundle Name");
        }


    /**-------------------------------
        🧐 Inspectors & Assertions
    ---------------------------------*/
    function existsBundle(FuncRegistry storage functions, string memory name) internal returns(bool) {
        return functions.bundles[name.toBundleHash()].hasName();
    }
    function notExistsBundle(FuncRegistry storage functions, string memory name) internal returns(bool) {
        return functions.existsBundle(name).isNot();
    }
    function assertBundleNotExistsAt(FuncRegistry storage functions, string memory name, string memory errorLocation) internal returns(FuncRegistry storage) {
        check(functions.notExistsBundle(name), "Bundle Already Exists", errorLocation);
        return functions;
    }


    /**
        Naming
     */
    function findUnusedCustomBundleName(FuncRegistry storage functions) internal returns(string memory name) {
        (uint start, uint end) = DevUtils.getScanRange();
        string memory baseName = "CustomBundle";

        for (uint i = start; i <= end; ++i) {
            name = ForgeHelper.appendNumberToNameIfNotOne(baseName, i);
            if (!functions.existsBundle(name)) return name;
        }

        DevUtils.revertUnusedNameNotFound();
    }
}

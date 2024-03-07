// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {DevUtils} from "DevKit/common/DevUtils.sol";
import {NameUtils} from "DevKit/common/NameUtils.sol";
import {ForgeHelper} from "DevKit/common/ForgeHelper.sol";
import "DevKit/common/Errors.sol";
import {FuncInfo} from "./FuncInfo.sol";
import {BundleInfo} from "./BundleInfo.sol";

/****************************************
    ✨ Meta Contract Custom Functions
*****************************************/
using MCCustomFuncsUtils for MCCustomFuncs global;
struct MCCustomFuncs {
    mapping(bytes32 nameHash => FuncInfo) functions;
    mapping(bytes32 nameHash => BundleInfo) bundles;
    string currentFunctionName;
    string currentBundleName;
}

library MCCustomFuncsUtils {
    using DevUtils for string;
    using DevUtils for address;
    using NameUtils for string;
    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        🌱 Init Custom Bundle
        ✨ Add Custom Function
        🔏 Load and Assign from Env
        🧺 Add Custom Function to Bundle
        🖼 Set Facade
        🔍 Find Custom Function
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/


    /**---------------------------
        🌱 Init Custom Bundle
    -----------------------------*/
    string constant init_ = "Init New Bundle";
    function init(MCCustomFuncs storage custom, string memory name) internal returns(MCCustomFuncs storage) {
        custom.bundles[name.safeCalcHashAt(init_)]
                    .assertNotExistsAt(init_)
                    .safeAssign(name);
        return custom;
    }
    string constant safeInit_ = "Safe Init New Bundle";
    function safeInit(MCCustomFuncs storage custom, string memory name) internal returns(MCCustomFuncs storage) {
        return custom   .assertBundleNotExistsAt(name, safeInit_)
                        .init(name);
    }


    /**---------------------------
        ✨ Add Custom Function
    -----------------------------*/
    string constant safeAdd = "Safe Add Custom Function";
    function safeAddFunction(MCCustomFuncs storage custom, string memory name, bytes4 selector, address implementation) internal returns(MCCustomFuncs storage) {
        custom.functions[name.safeCalcHashAt(safeAdd)]
                .safeAssign(name)
                .safeAssign(selector)
                .safeAssign(implementation);
        return custom;
    }


    /**--------------------------------
        🔏 Load and Assign from Env
    ----------------------------------*/


    /**-------------------------------------
        🧺 Add Custom Function to Bundle
    ---------------------------------------*/
    string constant addToBundle_ = "Add Function to Bundle";
    function addToBundle(MCCustomFuncs storage custom, string memory name, FuncInfo storage functionInfo) internal returns(MCCustomFuncs storage) {
        custom.bundles[name.safeCalcHashAt(addToBundle_)]
                    .assertExistsAt(addToBundle_)
                    .safeAdd(functionInfo);
        return custom;
    }
    function addToBundle(MCCustomFuncs storage custom, string memory name, FuncInfo[] storage functionInfos) internal returns(MCCustomFuncs storage) {
        custom.bundles[name.safeCalcHashAt(addToBundle_)]
                    .assertExistsAt(addToBundle_)
                    .safeAdd(functionInfos);
        return custom;
    }


    /********************
        🖼 Set Facade
    *********************/
    string constant set_ = "Set Facade";
    function set(MCCustomFuncs storage custom, string memory name, address facade) internal returns(MCCustomFuncs storage) {
        custom.bundles[name.safeCalcHashAt("")]
                    .assertExistsAt(set_)
                    .safeAssign(facade);
        return custom;
    }

    /**
        Getter
     */
    /**----------------------------
        🔍 Find Function
    ------------------------------*/
    string constant find = "Find Custom Function in DevKitEnv";
    function findFunction(MCCustomFuncs storage custom, string memory name) internal returns(FuncInfo storage) {
        return custom.functions[name.safeCalcHashAt(find)].assertCompleteAt(find);
    }
    function findBundle(MCCustomFuncs storage custom, string memory name) internal returns(BundleInfo storage) {
        return custom.bundles[name.safeCalcHashAt(find)].assertCompleteAt(find);
    }

    function existsBundle(MCCustomFuncs storage custom, string memory name) internal returns(bool) {
        return custom.bundles[name.toBundleHash()].exists();
    }

    function assertBundleNotExistsAt(MCCustomFuncs storage custom, string memory name, string memory errorLocation) internal returns(MCCustomFuncs storage) {
        check(custom.existsBundle(name), "Bundle Already Exists", errorLocation);
        return custom;
    }

    function findUnusedCustomBundleName(MCCustomFuncs storage custom) internal returns(string memory name) {
        (uint start, uint end) = DevUtils.getScanRange();
        string memory baseName = "CustomBundle";

        for (uint i = start; i <= end; ++i) {
            name = ForgeHelper.appendNumberToNameIfNotOne(baseName, i);
            if (!custom.existsBundle(name)) return name;
        }

        DevUtils.revertUnusedNameNotFound();
    }

    /**----------------------
        🔼 Update Context
    ------------------------*/
    string constant safeUpdate = "Safe Update DevKit Context";
    /**----- 🧺 Bundle -------*/
    function safeUpdateBundleName(MCCustomFuncs storage custom, string memory name) internal returns(MCCustomFuncs storage) {
        custom.currentBundleName = name.assertNotEmptyAt(safeUpdate);
        return custom;
    }

    /**----- 🧩 FunctionInfo -------*/
    function safeUpdateFunctionName(MCCustomFuncs storage custom, string memory name) internal returns(MCCustomFuncs storage) {
        custom.currentFunctionName = name.assertNotEmptyAt(safeUpdate);
        return custom;
    }

    /**-----------------------
        🔍 Find in Context
    -------------------------*/
    string constant find_ = "Find in DevKit Context";
    function findCurrentBundleName(MCCustomFuncs storage custom) internal returns(string memory) {
        return custom.currentBundleName.assertNotEmptyAt(find_);
    }
    function findCurrentFunctionName(MCCustomFuncs storage custom) internal returns(string memory) {
        return custom.currentFunctionName.assertNotEmptyAt(find_);
    }

    function findCurrentBundle(MCCustomFuncs storage custom) internal returns(BundleInfo storage) {
        return custom.findBundle(custom.findCurrentBundleName());
    }
    function findCurrentFunction(MCCustomFuncs storage custom) internal returns(FuncInfo storage) {
        return custom.findFunction(custom.findCurrentFunctionName());
    }
}

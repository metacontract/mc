// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ForgeHelper, console2} from "DevKit/common/ForgeHelper.sol";

import {DevUtils} from "DevKit/common/DevUtils.sol";
import {BundleInfo} from "./BundleInfo.sol";
import "DevKit/common/Errors.sol";
import {Debug} from "DevKit/common/Debug.sol";

/**======================
    🧩 Function Info
========================*/
using FuncInfoUtils for FuncInfo global;
struct FuncInfo { /// @dev FuncInfo may be different depending on the op version.
    string name;
    bytes4 selector;
    address implementation;
}

library FuncInfoUtils {
    using DevUtils for string;
    using DevUtils for bytes4;
    using DevUtils for address;
    using ForgeHelper for string;
    using {ForgeHelper.assignLabel} for address;

    /**---------------------------
        📥 Assign FunctionInfo
    -----------------------------*/
    string constant safeAssign_ = "Safe Assign to FunctionInfo";
    function safeAssign(FuncInfo storage functionInfo, string memory name) internal returns(FuncInfo storage) {
        return functionInfo .assertEmptyName()
                            .assign(name.assertNotEmpty());
    }
    function safeAssign(FuncInfo storage functionInfo, bytes4 selector) internal returns(FuncInfo storage) {
        return functionInfo .assertEmptySelector()
                            .assign(selector.assertNotEmpty());
    }
    function safeAssign(FuncInfo storage functionInfo, address implementation) internal returns(FuncInfo storage) {
        return functionInfo .assertEmptyImpl()
                            .assign(implementation.assertIsContract());
    }
    function assign(FuncInfo storage functionInfo, string memory name) internal returns(FuncInfo storage) {
        functionInfo.name = name;
        return functionInfo;
    }
    function assign(FuncInfo storage functionInfo, bytes4 selector) internal returns(FuncInfo storage) {
        functionInfo.selector = selector;
        return functionInfo;
    }
    function assign(FuncInfo storage functionInfo, address implementation) internal returns(FuncInfo storage) {
        functionInfo.implementation = implementation;
        return functionInfo;
    }

    string constant loadAndAssignImplFromEnv_ = "Load and Assign impl address from env by envKey to FunctionInfo";
    function loadAndAssignImplFromEnv(FuncInfo storage functionInfo) internal returns(FuncInfo storage) {
        return functionInfo.assign(
            ForgeHelper.loadAddressFromEnv(functionInfo.name)
        );
    }


    /**
        Helper Methods
     */
    function exists(FuncInfo memory functionInfo) internal returns(bool) {
        return functionInfo.implementation.isContract();
    }

    function assignLabel(FuncInfo storage functionInfo) internal returns(FuncInfo storage) {
        if (functionInfo.exists()) {
            ForgeHelper.assignLabel(functionInfo.implementation, functionInfo.name);
        }
        return functionInfo;
    }

    // function copyTo(FuncInfo memory functionInfo, Op memory op) internal {
    //     op.selector = functionInfo.selector;
    //     op.implementation = functionInfo.implementation;
    // }


    /**---------------
        🐞 Debug
    -----------------*/
    function emitLog(FuncInfo storage functionInfo) internal returns(FuncInfo storage) {
        if (Debug.shouldLog()) {
            functionInfo.parseAndLog();
        }
        return functionInfo;
    }
    function parseAndLog(FuncInfo memory functionInfo) internal {
        console2.log(
            DevUtils.concat("\tImpl: ", functionInfo.implementation),
            DevUtils.concat(", Selector: ", functionInfo.selector),
            DevUtils.concat(", Name: ", functionInfo.name)
        );
    }

    function assertExists(FuncInfo storage functionInfo) internal returns(FuncInfo storage) {
        if (!functionInfo.exists()) {
            throwError("FunctionInfo does not exists");
        }
        return functionInfo;
    }

    function assertEmptyName(FuncInfo storage functionInfo) internal returns(FuncInfo storage) {
        check(functionInfo.name.isEmpty(), "Name Already Exist");
        return functionInfo;
    }
    function assertEmptySelector(FuncInfo storage functionInfo) internal returns(FuncInfo storage) {
        check(functionInfo.selector.isEmpty(), "Selector Already Exist");
        return functionInfo;
    }
    function assertEmptyImpl(FuncInfo storage functionInfo) internal returns(FuncInfo storage) {
        check(functionInfo.implementation.isNotContract(), "Implementation Already Exist");
        return functionInfo;
    }

    function assertNotEmpty(FuncInfo storage functionInfo) internal returns(FuncInfo storage) {
        if (!functionInfo.exists()) {
            throwError("Empty Deployed Contract in FunctionInfo");
        }
        return functionInfo;
    }

    function assertNotIncludedIn(FuncInfo storage functionInfo, BundleInfo storage bundleInfo) internal returns(FuncInfo storage) {
        if (bundleInfo.has(functionInfo)) {
            throwError("Already exists in the BundelOp");
        }
        return functionInfo;
    }

    function assertImplIsContract(FuncInfo storage functionInfo) internal returns(FuncInfo storage) {
        if (!functionInfo.implementation.isContract()) throwError("Implementation Not Contract");
        return functionInfo;
    }

    function isComplete(FuncInfo storage functionInfo) internal returns(bool) {
        return  functionInfo.name.isNotEmpty() &&
                functionInfo.selector.isNotEmpty() &&
                functionInfo.implementation.isContract();
    }
    function assertComplete(FuncInfo storage functionInfo) internal returns(FuncInfo storage) {
        check(functionInfo.isComplete(), "Function Info Not Complete");
        return functionInfo;
    }

}

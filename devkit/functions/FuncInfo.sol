// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ForgeHelper, console2} from "DevKit/common/ForgeHelper.sol";

import {DevUtils} from "DevKit/common/DevUtils.sol";
import {BundleInfo} from "./BundleInfo.sol";
import "DevKit/common/Errors.sol";

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
        return functionInfo .assertEmptyNameAt(safeAssign_)
                            .assign(name.assertNotEmptyAt(safeAssign_));
    }
    function safeAssign(FuncInfo storage functionInfo, bytes4 selector) internal returns(FuncInfo storage) {
        return functionInfo .assertEmptySelectorAt(safeAssign_)
                            .assign(selector.assertNotEmptyAt(safeAssign_));
    }
    function safeAssign(FuncInfo storage functionInfo, address implementation) internal returns(FuncInfo storage) {
        return functionInfo .assertEmptyImplAt(safeAssign_)
                            .assign(implementation.assertIsContractAt(safeAssign_));
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
        if (DevUtils.shouldLog()) {
            console2.log(
                "Deployed Contract:", functionInfo.implementation,
                ", Keyword:", functionInfo.name
            );
        }
        return functionInfo;
    }

    function assertExists(FuncInfo storage functionInfo, string memory errorLocation) internal returns(FuncInfo storage) {
        if (!functionInfo.exists()) {
            throwError("FunctionInfo does not exists", errorLocation);
        }
        return functionInfo;
    }

    function assertEmptyNameAt(FuncInfo storage functionInfo, string memory errorLocation) internal returns(FuncInfo storage) {
        check(functionInfo.name.isEmpty(), "Name Already Exist", errorLocation);
        return functionInfo;
    }
    function assertEmptySelectorAt(FuncInfo storage functionInfo, string memory errorLocation) internal returns(FuncInfo storage) {
        check(functionInfo.selector.isEmpty(), "Selector Already Exist", errorLocation);
        return functionInfo;
    }
    function assertEmptyImplAt(FuncInfo storage functionInfo, string memory errorLocation) internal returns(FuncInfo storage) {
        check(functionInfo.implementation.isNotContract(), "Implementation Already Exist", errorLocation);
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

    function assertImplIsContractAt(FuncInfo storage functionInfo, string memory errorLocation) internal returns(FuncInfo storage) {
        if (!functionInfo.implementation.isContract()) throwError("Implementation Not Contract", errorLocation);
        return functionInfo;
    }

    function isComplete(FuncInfo storage functionInfo) internal returns(bool) {
        return  functionInfo.name.isNotEmpty() &&
                functionInfo.selector.isNotEmpty() &&
                functionInfo.implementation.isContract();
    }
    function assertCompleteAt(FuncInfo storage functionInfo, string memory errorLocation) internal returns(FuncInfo storage) {
        check(functionInfo.isComplete(), "Function Info Not Complete", errorLocation);
        return functionInfo;
    }

}

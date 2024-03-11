// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Global Methods
import "@devkit/utils/GlobalMethods.sol";
// Utils
import {ForgeHelper} from "@devkit/utils/ForgeHelper.sol";
import {StringUtils} from "@devkit/utils/StringUtils.sol";
import {Bytes4Utils} from "@devkit/utils/Bytes4Utils.sol";
import {AddressUtils} from "@devkit/utils/AddressUtils.sol";
// Debug
import {Debug} from "@devkit/debug/Debug.sol";
// Core
import {BundleInfo} from "./BundleInfo.sol";

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
    using StringUtils for string;
    using Bytes4Utils for bytes4;
    using AddressUtils for address;

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
        check(bundleInfo.hasNot(functionInfo), "Already exists in the Bundel");
        return functionInfo;
    }

    function assertImplIsContract(FuncInfo storage functionInfo) internal returns(FuncInfo storage) {
        check(functionInfo.implementation.isContract(), "Implementation Not Contract");
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

    function isEqual(FuncInfo storage a, FuncInfo storage b) internal returns(bool) {
        return keccak256(abi.encode(a)) == keccak256(abi.encode(b));
    }
}

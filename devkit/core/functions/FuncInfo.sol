// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Validation
import {check} from "devkit/errors/Validation.sol";
import {throwError} from "devkit/errors/Errors.sol";
// Utils
import {ForgeHelper} from "../../utils/ForgeHelper.sol";
import {StringUtils} from "../../utils/StringUtils.sol";
    using StringUtils for string;
import {Bytes4Utils} from "../../utils/Bytes4Utils.sol";
    using Bytes4Utils for bytes4;
import {AddressUtils} from "../../utils/AddressUtils.sol";
    using AddressUtils for address;
// Debug
import {Debug} from "../../debug/Debug.sol";
import {Logger} from "../../debug/Logger.sol";
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
    string constant LIB_NAME = "FuncInfo";

    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    << Primary >>
        📥 Assign Function
        🔼 Update Current Context Proxy
        🔍 Find Proxy
        🏷 Generate Unique Name
    << Helper >>
        🧐 Inspectors & Assertions
        🐞 Debug
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/


    /**------------------------
        📥 Assign Function
    --------------------------*/
    /**----- Name --------*/
    function assign(FuncInfo storage functionInfo, string memory name) internal returns(FuncInfo storage) {
        functionInfo.name = name;
        return functionInfo;
    }
    function safeAssign(FuncInfo storage functionInfo, string memory name) internal returns(FuncInfo storage) {
        uint pid = recordExecStart("safeAssign");
        return functionInfo .assertEmptyName()
                            .assign(name.assertNotEmpty())
                            .recordExecFinish(pid);
    }

    /**----- Selector --------*/
    function safeAssign(FuncInfo storage functionInfo, bytes4 selector) internal returns(FuncInfo storage) {
        uint pid = recordExecStart("safeAssign");
        return functionInfo .assertEmptySelector()
                            .assign(selector.assertNotEmpty())
                            .recordExecFinish(pid);
    }
    function assign(FuncInfo storage functionInfo, bytes4 selector) internal returns(FuncInfo storage) {
        functionInfo.selector = selector;
        return functionInfo;
    }

    /**----- Implementation --------*/
    function safeAssign(FuncInfo storage functionInfo, address implementation) internal returns(FuncInfo storage) {
        uint pid = recordExecStart("safeAssign");
        return functionInfo .assertEmptyImpl()
                            .assign(implementation.assertIsContract())
                            .recordExecFinish(pid);
    }
    function assign(FuncInfo storage functionInfo, address implementation) internal returns(FuncInfo storage) {
        functionInfo.implementation = implementation;
        return functionInfo;
    }

    function loadAndAssignFromEnv(FuncInfo storage functionInfo, string memory envKey, string memory name, bytes4 selector) internal returns(FuncInfo storage) {
        uint pid = recordExecStart("loadAndAssignFromEnv");
        return functionInfo .assign(name)
                            .assign(selector)
                            .assign(envKey.loadAddress())
                            .recordExecFinish(pid);
    }
    function loadAndAssignFromEnv(FuncInfo storage functionInfo) internal returns(FuncInfo storage) {
        string memory name = functionInfo.name.assertNotEmpty();
        bytes4 selector = functionInfo.selector.assertNotEmpty();
        return functionInfo.loadAndAssignFromEnv(name, name, selector);
    }
    function safeLoadAndAssignFromEnv(FuncInfo storage functionInfo, string memory envKey, string memory name, bytes4 selector) internal returns(FuncInfo storage) {
        uint pid = recordExecStart("safeLoadAndAssignFromEnv");
        return functionInfo.loadAndAssignFromEnv(
            envKey.assertNotEmpty(),
            name.assertNotEmpty(),
            selector.assertNotEmpty()
        ).recordExecFinish(pid);
    }


    /**-------------------------------
        🧐 Inspectors & Assertions
    ---------------------------------*/
    function exists(FuncInfo memory functionInfo) internal returns(bool) {
        return functionInfo.implementation.isContract();
    }

    function assignLabel(FuncInfo storage functionInfo) internal returns(FuncInfo storage) {
        if (functionInfo.exists()) {
            ForgeHelper.assignLabel(functionInfo.implementation, functionInfo.name);
        }
        return functionInfo;
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

    function isEqual(FuncInfo storage a, FuncInfo storage b) internal pure returns(bool) {
        return keccak256(abi.encode(a)) == keccak256(abi.encode(b));
    }


    /**---------------
        🐞 Debug
    -----------------*/
    function parseAndLog(FuncInfo storage functionInfo) internal returns(FuncInfo storage) {
        Logger.log(
            functionInfo.parse()
        );
        return functionInfo;
    }
    function parse(FuncInfo memory functionInfo) internal returns(string memory message) {
        return message  .append("Impl: ").append(functionInfo.implementation).comma()
                        .append("Selector: ").append(functionInfo.selector).comma()
                        .append("Name: ").append(functionInfo.name);
    }


    function recordExecStart(string memory funcName, string memory params) internal returns(uint) {
        return Debug.recordExecStart(LIB_NAME, funcName, params);
    }
    function recordExecStart(string memory funcName) internal returns(uint) {
        return recordExecStart(funcName, "");
    }
    function recordExecFinish(FuncInfo storage funcInfo, uint pid) internal returns(FuncInfo storage) {
        Debug.recordExecFinish(pid);
        return funcInfo;
    }

}

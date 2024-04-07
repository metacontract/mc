// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Validation
import {check} from "devkit/error/Validation.sol";
import {throwError} from "devkit/error/Error.sol";
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
import {Bundle} from "./Bundle.sol";


/**======================
    🧩 Function Info
========================*/
using FunctionLib for Function global;
struct Function { /// @dev Function may be different depending on the op version.
    string name;
    bytes4 selector;
    address implementation;
}

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
library FunctionLib {
    string constant LIB_NAME = "Function";


    /**------------------------
        📥 Assign Function
    --------------------------*/
    /**----- Name --------*/
    function assign(Function storage func, string memory name) internal returns(Function storage) {
        func.name = name;
        return func;
    }
    function safeAssign(Function storage func, string memory name) internal returns(Function storage) {
        uint pid = recordExecStart("safeAssign");
        return func .assertEmptyName()
                            .assign(name.assertNotEmpty())
                            .recordExecFinish(pid);
    }

    /**----- Selector --------*/
    function safeAssign(Function storage func, bytes4 selector) internal returns(Function storage) {
        uint pid = recordExecStart("safeAssign");
        return func .assertEmptySelector()
                            .assign(selector.assertNotEmpty())
                            .recordExecFinish(pid);
    }
    function assign(Function storage func, bytes4 selector) internal returns(Function storage) {
        func.selector = selector;
        return func;
    }

    /**----- Implementation --------*/
    function safeAssign(Function storage func, address implementation) internal returns(Function storage) {
        uint pid = recordExecStart("safeAssign");
        return func .assertEmptyImpl()
                            .assign(implementation.assertIsContract())
                            .recordExecFinish(pid);
    }
    function assign(Function storage func, address implementation) internal returns(Function storage) {
        func.implementation = implementation;
        return func;
    }

    function loadAndAssignFromEnv(Function storage func, string memory envKey, string memory name, bytes4 selector) internal returns(Function storage) {
        uint pid = recordExecStart("loadAndAssignFromEnv");
        return func .assign(name)
                            .assign(selector)
                            .assign(envKey.loadAddress())
                            .recordExecFinish(pid);
    }
    function loadAndAssignFromEnv(Function storage func) internal returns(Function storage) {
        string memory name = func.name.assertNotEmpty();
        bytes4 selector = func.selector.assertNotEmpty();
        return func.loadAndAssignFromEnv(name, name, selector);
    }
    function safeLoadAndAssignFromEnv(Function storage func, string memory envKey, string memory name, bytes4 selector) internal returns(Function storage) {
        uint pid = recordExecStart("safeLoadAndAssignFromEnv");
        return func.loadAndAssignFromEnv(
            envKey.assertNotEmpty(),
            name.assertNotEmpty(),
            selector.assertNotEmpty()
        ).recordExecFinish(pid);
    }


    /**-------------------------------
        🧐 Inspectors & Assertions
    ---------------------------------*/
    function exists(Function memory func) internal returns(bool) {
        return func.implementation.isContract();
    }

    function assignLabel(Function storage func) internal returns(Function storage) {
        if (func.exists()) {
            ForgeHelper.assignLabel(func.implementation, func.name);
        }
        return func;
    }

    function assertExists(Function storage func) internal returns(Function storage) {
        if (!func.exists()) {
            throwError("func does not exists");
        }
        return func;
    }

    function assertEmptyName(Function storage func) internal returns(Function storage) {
        check(func.name.isEmpty(), "Name Already Exist");
        return func;
    }
    function assertEmptySelector(Function storage func) internal returns(Function storage) {
        check(func.selector.isEmpty(), "Selector Already Exist");
        return func;
    }
    function assertEmptyImpl(Function storage func) internal returns(Function storage) {
        check(func.implementation.isNotContract(), "Implementation Already Exist");
        return func;
    }

    function assertNotEmpty(Function storage functionInfo) internal returns(Function storage) {
        if (!functionInfo.exists()) {
            throwError("Empty Deployed Contract in FunctionInfo");
        }
        return functionInfo;
    }

    function assertNotIncludedIn(Function storage functionInfo, Bundle storage bundleInfo) internal returns(Function storage) {
        check(bundleInfo.hasNot(functionInfo), "Already exists in the Bundel");
        return functionInfo;
    }

    function assertImplIsContract(Function storage functionInfo) internal returns(Function storage) {
        check(functionInfo.implementation.isContract(), "Implementation Not Contract");
        return functionInfo;
    }

    function isComplete(Function storage functionInfo) internal returns(bool) {
        return  functionInfo.name.isNotEmpty() &&
                functionInfo.selector.isNotEmpty() &&
                functionInfo.implementation.isContract();
    }
    function assertComplete(Function storage functionInfo) internal returns(Function storage) {
        check(functionInfo.isComplete(), "Function Info Not Complete");
        return functionInfo;
    }

    function isEqual(Function memory a, Function memory b) internal pure returns(bool) {
        return keccak256(abi.encode(a)) == keccak256(abi.encode(b));
    }


    /**---------------
        🐞 Debug
    -----------------*/
    function parseAndLog(Function storage functionInfo) internal returns(Function storage) {
        Logger.log(
            functionInfo.parse()
        );
        return functionInfo;
    }
    function parse(Function memory functionInfo) internal returns(string memory message) {
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
    function recordExecFinish(Function storage funcInfo, uint pid) internal returns(Function storage) {
        Debug.recordExecFinish(pid);
        return funcInfo;
    }

}

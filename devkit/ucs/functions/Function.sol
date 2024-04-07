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
    function assign(Function storage functionInfo, string memory name) internal returns(Function storage) {
        functionInfo.name = name;
        return functionInfo;
    }
    function safeAssign(Function storage functionInfo, string memory name) internal returns(Function storage) {
        uint pid = recordExecStart("safeAssign");
        return functionInfo .assertEmptyName()
                            .assign(name.assertNotEmpty())
                            .recordExecFinish(pid);
    }

    /**----- Selector --------*/
    function safeAssign(Function storage functionInfo, bytes4 selector) internal returns(Function storage) {
        uint pid = recordExecStart("safeAssign");
        return functionInfo .assertEmptySelector()
                            .assign(selector.assertNotEmpty())
                            .recordExecFinish(pid);
    }
    function assign(Function storage functionInfo, bytes4 selector) internal returns(Function storage) {
        functionInfo.selector = selector;
        return functionInfo;
    }

    /**----- Implementation --------*/
    function safeAssign(Function storage functionInfo, address implementation) internal returns(Function storage) {
        uint pid = recordExecStart("safeAssign");
        return functionInfo .assertEmptyImpl()
                            .assign(implementation.assertIsContract())
                            .recordExecFinish(pid);
    }
    function assign(Function storage functionInfo, address implementation) internal returns(Function storage) {
        functionInfo.implementation = implementation;
        return functionInfo;
    }

    function loadAndAssignFromEnv(Function storage functionInfo, string memory envKey, string memory name, bytes4 selector) internal returns(Function storage) {
        uint pid = recordExecStart("loadAndAssignFromEnv");
        return functionInfo .assign(name)
                            .assign(selector)
                            .assign(envKey.loadAddress())
                            .recordExecFinish(pid);
    }
    function loadAndAssignFromEnv(Function storage functionInfo) internal returns(Function storage) {
        string memory name = functionInfo.name.assertNotEmpty();
        bytes4 selector = functionInfo.selector.assertNotEmpty();
        return functionInfo.loadAndAssignFromEnv(name, name, selector);
    }
    function safeLoadAndAssignFromEnv(Function storage functionInfo, string memory envKey, string memory name, bytes4 selector) internal returns(Function storage) {
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
    function exists(Function memory functionInfo) internal returns(bool) {
        return functionInfo.implementation.isContract();
    }

    function assignLabel(Function storage functionInfo) internal returns(Function storage) {
        if (functionInfo.exists()) {
            ForgeHelper.assignLabel(functionInfo.implementation, functionInfo.name);
        }
        return functionInfo;
    }

    function assertExists(Function storage functionInfo) internal returns(Function storage) {
        if (!functionInfo.exists()) {
            throwError("FunctionInfo does not exists");
        }
        return functionInfo;
    }

    function assertEmptyName(Function storage functionInfo) internal returns(Function storage) {
        check(functionInfo.name.isEmpty(), "Name Already Exist");
        return functionInfo;
    }
    function assertEmptySelector(Function storage functionInfo) internal returns(Function storage) {
        check(functionInfo.selector.isEmpty(), "Selector Already Exist");
        return functionInfo;
    }
    function assertEmptyImpl(Function storage functionInfo) internal returns(Function storage) {
        check(functionInfo.implementation.isNotContract(), "Implementation Already Exist");
        return functionInfo;
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

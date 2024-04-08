// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Error & Debug
import {check} from "devkit/error/Validation.sol";
import {ERR, throwError} from "devkit/error/Error.sol";
import {Debug} from "devkit/debug/Debug.sol";
// Config
import {ScanRange, Config} from "devkit/config/Config.sol";
// Utils
import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;
import {BoolUtils} from "devkit/utils/BoolUtils.sol";
    using BoolUtils for bool;
// Core
import {Function} from "./Function.sol";
import {Bundle} from "devkit/core/Bundle.sol";
import {StdFunctions} from "devkit/core/StdFunctions.sol";


/**-------------------------------
    🧩 UCS Functions Registry
---------------------------------*/
using FunctionRegistryLib for FunctionRegistry global;
struct FunctionRegistry {
    mapping(bytes32 nameHash => Function) customs;
    mapping(bytes32 nameHash => Bundle) bundles;
    string currentFunctionName;
}

/**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    << Primary >>
        🌱 Init Bundle
        ✨ Add Custom Function
        🔏 Load and Assign Custom Function from Env
        🧺 Add Custom Function to Bundle
        🪟 Set Facade
        🔼 Update Current Context Function & Bundle
        🔍 Find Function & Bundle
        🏷 Generate Unique Name
    << Helper >>
        🔍 Find Custom Function
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
library FunctionRegistryLib {
    string constant LIB_NAME = "FunctionRegistry";


    /**---------------------------
        ✨ Add Custom Function
    -----------------------------*/
    function safeAddFunction(FunctionRegistry storage functions, string memory name, bytes4 selector, address implementation) internal returns(FunctionRegistry storage) {
        uint pid = functions.recordExecStart("safeAddFunction");
        check(name.isNotEmpty(), "Empty Name");
        functions.customs[name.safeCalcHash()]
                .safeAssign(name)
                .safeAssign(selector)
                .safeAssign(implementation);
        functions.safeUpdateCurrentFunction(name);
        return functions.recordExecFinish(pid);
    }


    /**---------------------------------------------
        🔏 Load and Add Custom Function from Env
    -----------------------------------------------*/
    function safeLoadAndAdd(FunctionRegistry storage functions, string memory envKey, string memory name, bytes4 selector, address implementation) internal returns(FunctionRegistry storage) {
        uint pid = functions.recordExecStart("safeLoadAndAdd");
        functions.customs[name.safeCalcHash()]
                    .loadAndAssignFromEnv(envKey, name, selector);
        functions.safeUpdateCurrentFunction(name);
        return functions.recordExecFinish(pid);
    }


    /**------------------------------------------------
        🔼 Update Current Context
    --------------------------------------------------*/
    function safeUpdateCurrentFunction(FunctionRegistry storage functions, string memory name) internal returns(FunctionRegistry storage) {
        uint pid = functions.recordExecStart("safeUpdateCurrentFunction");
        functions.currentFunctionName = name.assertNotEmpty();
        return functions.recordExecFinish(pid);
    }


    /**-----------------------------------------------
        ♻️ Reset Current Context Function & Bundle
    -------------------------------------------------*/
    function reset(FunctionRegistry storage functions) internal returns(FunctionRegistry storage) {
        uint pid = functions.recordExecStart("reset");
        delete functions.currentFunctionName;
        return functions.recordExecFinish(pid);
    }


    /**-------------------------------
        🔍 Find Function & Bundle
    ---------------------------------*/
    /**----- 🧩 Function -------*/
    function findFunction(FunctionRegistry storage functions, string memory name) internal returns(Function storage) {
        uint pid = functions.recordExecStart("findFunction");
        return functions.customs[name.safeCalcHash()].assertExists().finishProcess(pid);
    }
    function findCurrentFunction(FunctionRegistry storage functions) internal returns(Function storage) {
        uint pid = functions.recordExecStart("findCurrentFunction");
        return functions.findFunction(functions.findCurrentFunctionName()).finishProcess(pid);
    }
        function findCurrentFunctionName(FunctionRegistry storage functions) internal returns(string memory) {
            uint pid = functions.recordExecStart("findCurrentFunctionName");
            return functions.currentFunctionName.assertNotEmpty().recordExecFinish(pid);
        }



    /**----------------
        🐞 Debug
    ------------------*/
    /**
        Record Start
     */
    function recordExecStart(FunctionRegistry storage, string memory funcName, string memory params) internal returns(uint) {
        return Debug.recordExecStart(LIB_NAME, funcName, params);
    }
    function recordExecStart(FunctionRegistry storage functions, string memory funcName) internal returns(uint) {
        return functions.recordExecStart(funcName, "");
    }

    /**
        Record Finish
     */
    function recordExecFinish(FunctionRegistry storage functions, uint pid) internal returns(FunctionRegistry storage) {
        Debug.recordExecFinish(pid);
        return functions;
    }

}

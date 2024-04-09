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
import {Function} from "devkit/core/Function.sol";
import {Bundle} from "devkit/core/Bundle.sol";
import {StdFunctions} from "devkit/core/StdFunctions.sol";

import {FunctionRegistry} from "devkit/core/FunctionRegistry.sol";


/**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    📗 Functions Registry
        ✨ Add Custom Function
        🔏 Load and Assign Custom Function from Env
        🔼 Update Current Context Function
        ♻️ Reset Current Context Function & Bundle
        🔍 Find Function
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
library FunctionRegistryLib {
    /**---------------------------
        ✨ Add Custom Function
    -----------------------------*/
    function safeAddFunction(FunctionRegistry storage functions, string memory name, bytes4 selector, address implementation) internal returns(FunctionRegistry storage) {
        uint pid = functions.startProcess("safeAddFunction");
        check(name.isNotEmpty(), "Empty Name");
        functions.customs[name.safeCalcHash()]
                .safeAssign(name)
                .safeAssign(selector)
                .safeAssign(implementation);
        functions.safeUpdateCurrentFunction(name);
        return functions.finishProcess(pid);
    }


    /**---------------------------------------------
        🔏 Load and Add Custom Function from Env
    -----------------------------------------------*/
    function safeLoadAndAdd(FunctionRegistry storage functions, string memory envKey, string memory name, bytes4 selector, address implementation) internal returns(FunctionRegistry storage) {
        uint pid = functions.startProcess("safeLoadAndAdd");
        functions.customs[name.safeCalcHash()]
                    .loadAndAssignFromEnv(envKey, name, selector);
        functions.safeUpdateCurrentFunction(name);
        return functions.finishProcess(pid);
    }


    /**------------------------------------------------
        🔼 Update Current Context Function
    --------------------------------------------------*/
    function safeUpdateCurrentFunction(FunctionRegistry storage functions, string memory name) internal returns(FunctionRegistry storage) {
        uint pid = functions.startProcess("safeUpdateCurrentFunction");
        functions.currentName = name.assertNotEmpty();
        return functions.finishProcess(pid);
    }


    /**-----------------------------------------------
        ♻️ Reset Current Context Function & Bundle
    -------------------------------------------------*/
    function reset(FunctionRegistry storage functions) internal returns(FunctionRegistry storage) {
        uint pid = functions.startProcess("reset");
        delete functions.currentName;
        return functions.finishProcess(pid);
    }


    /**-------------------------------
        🔍 Find Function
    ---------------------------------*/
    function find(FunctionRegistry storage functions, string memory name) internal returns(Function storage) {
        uint pid = functions.startProcess("findFunction");
        return functions.customs[name.safeCalcHash()].assertExists().finishProcess(pid);
    }
    function findCurrentFunction(FunctionRegistry storage functions) internal returns(Function storage) {
        uint pid = functions.startProcess("findCurrentFunction");
        return functions.find(functions.findCurrentName()).finishProcess(pid);
    }
        function findCurrentName(FunctionRegistry storage functions) internal returns(string memory) {
            uint pid = functions.startProcess("findCurrentName");
            return functions.currentName.assertNotEmpty().recordExecFinish(pid);
        }

}

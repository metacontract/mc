// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Error & Debug
import {validate} from "devkit/error/Validate.sol";
import {Require} from "devkit/error/Require.sol";
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
        🗳️ Insert Custom Function
        🔼 Update Current Context Function
        ♻️ Reset Current Context Function & Bundle
        🔍 Find Function
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
library FunctionRegistryLib {
    /**------------------------------
        🗳️ Insert Custom Function
    --------------------------------*/
    function insert(FunctionRegistry storage functions, string memory name, bytes4 selector, address implementation) internal returns(FunctionRegistry storage) {
        uint pid = functions.startProcess("insert");
        Require.isNotEmpty(name);
        functions.customs[name].assign(name, selector, implementation).lock();
        functions.safeUpdateCurrentFunction(name); // TODO
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
        return functions.customs[name].assertExists().finishProcess(pid);
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

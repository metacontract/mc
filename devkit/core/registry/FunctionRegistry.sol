// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core Type
import {Function} from "devkit/core/types/Function.sol";
// Support Method
import {ProcessLib} from "devkit/core/method/debug/ProcessLib.sol";
using ProcessLib for FunctionRegistry global;
import {Require} from "devkit/error/Require.sol";


/**===========================
    📗 Functions Registry
=============================*/
using FunctionRegistryLib for FunctionRegistry global;
struct FunctionRegistry {
    mapping(string name => Function) customs;
    string currentName;
}
library FunctionRegistryLib {
    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        🗳️ Insert Custom Function
        🔼 Update Current Context Function
        ♻️ Reset Current Context Function & Bundle
        🔍 Find Function
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

    /**------------------------------
        🗳️ Insert Custom Function
    --------------------------------*/
    function insert(FunctionRegistry storage functions, string memory name, bytes4 selector, address implementation) internal returns(FunctionRegistry storage) {
        uint pid = functions.startProcess("insert");
        Require.notEmpty(name);
        functions.customs[name].assign(name, selector, implementation).lock();
        functions.safeUpdateCurrentFunction(name); // TODO
        return functions.finishProcess(pid);
    }

    /**------------------------------------------------
        🔼 Update Current Context Function
    --------------------------------------------------*/
    function safeUpdateCurrentFunction(FunctionRegistry storage functions, string memory name) internal returns(FunctionRegistry storage) {
        uint pid = functions.startProcess("safeUpdateCurrentFunction");
        Require.notEmpty(name);
        functions.currentName = name;
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
        Require.exists(functions.customs[name]);
        return functions.customs[name].finishProcess(pid);
    }
    function findCurrentFunction(FunctionRegistry storage functions) internal returns(Function storage) {
        uint pid = functions.startProcess("findCurrentFunction");
        return functions.find(functions.findCurrentName()).finishProcess(pid);
    }
        function findCurrentName(FunctionRegistry storage functions) internal returns(string memory) {
            uint pid = functions.startProcess("findCurrentName");
            Require.notEmpty(functions.currentName);
            return functions.currentName;
            // return functions.currentName.recordExecFinish(pid);
        }

}

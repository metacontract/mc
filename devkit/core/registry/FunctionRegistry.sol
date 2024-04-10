// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {ProcessLib} from "devkit/core/method/debug/ProcessLib.sol";
using ProcessLib for FunctionRegistry global;
import {Require} from "devkit/error/Require.sol";

// Context
import {Current} from "devkit/core/method/context/Current.sol";
// Core Type
import {Function} from "devkit/core/types/Function.sol";


/**===========================
    📗 Functions Registry
=============================*/
using FunctionRegistryLib for FunctionRegistry global;
struct FunctionRegistry {
    mapping(string name => Function) functions;
    Current current;
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
    function insert(FunctionRegistry storage registry, string memory name, bytes4 selector, address implementation) internal returns(FunctionRegistry storage) {
        uint pid = registry.startProcess("insert");
        Require.notEmpty(name);
        registry.functions[name].assign(name, selector, implementation).lock();
        registry.current.update(name);
        return registry.finishProcess(pid);
    }


    /**-------------------------------
        🔍 Find Function
    ---------------------------------*/
    function find(FunctionRegistry storage registry, string memory name) internal returns(Function storage) {
        uint pid = registry.startProcess("find");
        Require.notEmpty(name);
        Function storage func = registry.functions[name];
        Require.exists(func);
        return func.finishProcess(pid);
    }
    function findCurrent(FunctionRegistry storage registry) internal returns(Function storage) {
        uint pid = registry.startProcess("findCurrent");
        string memory name = registry.current.name;
        Require.notEmpty(name);
        return registry.find(name).finishProcess(pid);
    }

}

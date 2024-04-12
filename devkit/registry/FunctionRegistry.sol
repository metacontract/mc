// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {ProcessLib} from "devkit/utils/debug/ProcessLib.sol";
using ProcessLib for FunctionRegistry global;
// Validation
import {Validate} from "devkit/validate/Validate.sol";

// Context
import {Current} from "devkit/registry/context/Current.sol";
// Core Type
import {Function} from "devkit/core/Function.sol";


/**===========================
    📗 Functions Registry
=============================*/
using FunctionRegistryLib for FunctionRegistry global;
struct FunctionRegistry {
    mapping(string name => Function) functions;
    Current current;
}
library FunctionRegistryLib {

    /**--------------------------
        🗳️ Register Function
    ----------------------------*/
    function register(FunctionRegistry storage registry, string memory name, bytes4 selector, address implementation) internal returns(FunctionRegistry storage) {
        uint pid = registry.startProcess("register");
        Validate.MUST_NotEmptyName(name);
        registry.functions[name].assign(name, selector, implementation).build().lock();
        registry.current.update(name);
        return registry.finishProcess(pid);
    }

    /**----------------------
        🔍 Find Function
    ------------------------*/
    function find(FunctionRegistry storage registry, string memory name) internal returns(Function storage) {
        uint pid = registry.startProcess("find");
        Validate.MUST_NotEmptyName(name);
        Validate.MUST_registered(registry, name);
        Function storage func = registry.functions[name];
        Validate.MUST_completed(func);
        return func.finishProcess(pid);
    }
    function findCurrent(FunctionRegistry storage registry) internal returns(Function storage) {
        uint pid = registry.startProcess("findCurrent");
        string memory name = registry.current.name;
        Validate.MUST_NotEmptyName(name);
        return registry.find(name).finishProcess(pid);
    }

}

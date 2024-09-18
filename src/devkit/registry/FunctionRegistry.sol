// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;
/**---------------------
    Support Methods
-----------------------*/
import {Tracer} from "devkit/system/Tracer.sol";
// Validation
import {Validator} from "devkit/system/Validator.sol";

// Context
import {Current} from "devkit/registry/context/Current.sol";
// Core Type
import {Function} from "devkit/core/Function.sol";


//////////////////////////////////////////////////////////////
//  📗 Functions Registry    /////////////////////////////////
    using FunctionRegistryLib for FunctionRegistry global;
    using Tracer for FunctionRegistry global;
//////////////////////////////////////////////////////////////
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
        Validator.MUST_NotEmptyName(name);
        registry.functions[name].assign(name, selector, implementation);
        registry.current.update(name);
        return registry.finishProcess(pid);
    }

    /**----------------------
        🔍 Find Function
    ------------------------*/
    function find(FunctionRegistry storage registry, string memory name) internal returns(Function storage func) {
        uint pid = registry.startProcess("find");
        Validator.MUST_NotEmptyName(name);
        Validator.MUST_Registered(registry, name);
        func = registry.functions[name];
        Validator.MUST_Completed(func);
        registry.finishProcess(pid);
    }
    function findCurrent(FunctionRegistry storage registry) internal returns(Function storage func) {
        uint pid = registry.startProcess("findCurrent");
        string memory name = registry.current.name;
        Validator.MUST_NotEmptyName(name);
        func = registry.find(name);
        registry.finishProcess(pid);
    }

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {ProcessManager} from "devkit/system/debug/Process.sol";
// Validation
import {Validate} from "devkit/system/Validate.sol";

// Context
import {Current} from "devkit/registry/context/Current.sol";
// Core Type
import {Function} from "devkit/core/Function.sol";


//////////////////////////////////////////////////////////////
//  📗 Functions Registry    /////////////////////////////////
    using FunctionRegistryLib for FunctionRegistry global;
    using ProcessManager for FunctionRegistry global;
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
        Validate.MUST_NotEmptyName(name);
        registry.functions[name].assign(name, selector, implementation);
        registry.current.update(name);
        return registry.finishProcess(pid);
    }

    /**----------------------
        🔍 Find Function
    ------------------------*/
    function find(FunctionRegistry storage registry, string memory name) internal returns(Function storage func) {
        uint pid = registry.startProcess("find");
        Validate.MUST_NotEmptyName(name);
        Validate.MUST_registered(registry, name);
        func = registry.functions[name];
        Validate.MUST_Completed(func);
        registry.finishProcess(pid);
    }
    function findCurrent(FunctionRegistry storage registry) internal returns(Function storage func) {
        uint pid = registry.startProcess("findCurrent");
        string memory name = registry.current.name;
        Validate.MUST_NotEmptyName(name);
        func = registry.find(name);
        registry.finishProcess(pid);
    }

}

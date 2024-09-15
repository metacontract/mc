// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;
/**---------------------
    Support Methods
-----------------------*/
import {Tracer, param} from "devkit/system/Tracer.sol";
import {Inspector} from "devkit/types/Inspector.sol";
import {TypeGuard, TypeStatus} from "devkit/types/TypeGuard.sol";
import {Formatter} from "devkit/types/Formatter.sol";
// Validation
import {Validator} from "devkit/system/Validator.sol";
// Loader
import {loadAddressFrom} from "devkit/utils/ForgeHelper.sol";


//////////////////////////////////////////////
//  🧩 Function   ////////////////////////////
    using FunctionLib for Function global;
    using Tracer for Function global;
    using Inspector for Function global;
    using TypeGuard for Function global;
    using Formatter for Function global;
//////////////////////////////////////////////
struct Function { /// @dev TODO Function may be different depending on the op version.
    string name;
    bytes4 selector;
    address implementation;
    TypeStatus status;
}
library FunctionLib {
    /**--------------------
        📛 Assign Name
    ----------------------*/
    function assignName(Function storage func, string memory name) internal returns(Function storage) {
        uint pid = func.startProcess("assignName", param(name));
        func.startBuilding();
        func.name = name;
        func.finishBuilding();
        return func.finishProcess(pid);
    }

    /**------------------------
        🎯 Assign Selector
    --------------------------*/
    function assignSelector(Function storage func, bytes4 selector) internal returns(Function storage) {
        uint pid = func.startProcess("assignSelector", param(selector));
        func.startBuilding();
        func.selector = selector;
        func.finishBuilding();
        return func.finishProcess(pid);
    }

    /**------------------------------
        🎨 Assign Implementation
    --------------------------------*/
    function assignImplementation(Function storage func, address implementation) internal returns(Function storage) {
        uint pid = func.startProcess("assignImplementation", param(implementation));
        func.startBuilding();
        func.implementation = implementation;
        func.finishBuilding();
        return func.finishProcess(pid);
    }

    /**---------------
        🌈 Assign
    -----------------*/
    function assign(Function storage func, string memory name, bytes4 selector, address implementation) internal returns(Function storage) {
        uint pid = func.startProcess("assign", param(name, selector, implementation));
        func.assignName(name);
        func.assignSelector(selector);
        func.assignImplementation(implementation);
        return func.finishProcess(pid);
    }

    /**-----------------------
        📨 Fetch Function
    -------------------------*/
    function fetch(Function storage func, string memory envKey) internal returns(Function storage) {
        uint pid = func.startProcess("fetch", param(envKey));
        Validator.MUST_NotEmptyEnvKey(envKey);
        func.assignName(envKey);
        func.assignImplementation(loadAddressFrom(envKey));
        return func.finishProcess(pid);
    }

}

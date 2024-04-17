// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {ProcessLib} from "devkit/system/debug/Process.sol";
import {Dumper} from "devkit/system/debug/Dumper.sol";
import {Inspector} from "devkit/types/Inspector.sol";
import {TypeGuard, TypeStatus} from "devkit/types/TypeGuard.sol";
// Validation
import {Validate} from "devkit/system/Validate.sol";
// Loader
import {loadAddressFrom} from "devkit/utils/ForgeHelper.sol";


//////////////////////////////////////////////
//  🧩 Function   ////////////////////////////
    using FunctionLib for Function global;
    using ProcessLib for Function global;
    using Dumper for Function global;
    using Inspector for Function global;
    using TypeGuard for Function global;
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
        uint pid = func.startProcess("assignName");
        func.startBuilding();
        func.name = name;
        func.finishBuilding();
        return func.finishProcess(pid);
    }

    /**------------------------
        🎯 Assign Selector
    --------------------------*/
    function assignSelector(Function storage func, bytes4 selector) internal returns(Function storage) {
        uint pid = func.startProcess("assignSelector");
        func.startBuilding();
        func.selector = selector;
        func.finishBuilding();
        return func.finishProcess(pid);
    }

    /**------------------------------
        🎨 Assign Implementation
    --------------------------------*/
    function assignImplementation(Function storage func, address implementation) internal returns(Function storage) {
        uint pid = func.startProcess("assignImplementation");
        func.startBuilding();
        func.implementation = implementation;
        func.finishBuilding();
        return func.finishProcess(pid);
    }

    /**---------------
        🌈 Assign
    -----------------*/
    function assign(Function storage func, string memory name, bytes4 selector, address implementation) internal returns(Function storage) {
        uint pid = func.startProcess("assign");
        func.assignName(name);
        func.assignSelector(selector);
        func.assignImplementation(implementation);
        return func.finishProcess(pid);
    }

    /**-----------------------
        📨 Fetch Function
    -------------------------*/
    function fetch(Function storage func, string memory envKey) internal returns(Function storage) {
        uint pid = func.startProcess("fetch");
        Validate.MUST_NotEmptyEnvKey(envKey);
        func.assignName(envKey);
        func.assignImplementation(loadAddressFrom(envKey));
        return func.finishProcess(pid);
    }

}

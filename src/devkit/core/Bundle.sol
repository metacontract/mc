// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;
/**---------------------
    Support Methods
-----------------------*/
import {Tracer, param} from "devkit/system/Tracer.sol";
import {Inspector} from "devkit/types/Inspector.sol";
import {TypeGuard, TypeStatus} from "devkit/types/TypeGuard.sol";
// Validation
import {Validator} from "devkit/system/Validator.sol";

// Core Type
import {Function} from "devkit/core/Function.sol";


///////////////////////////////////////////
//  🗂️ Bundle   ///////////////////////////
    using BundleLib for Bundle global;
    using Tracer for Bundle global;
    using Inspector for Bundle global;
    using TypeGuard for Bundle global;
///////////////////////////////////////////
struct Bundle {
    string name;
    Function[] functions;
    address facade;
    TypeStatus status;
}
library BundleLib {
    /**--------------------
        📛 Assign Name
    ----------------------*/
    function assignName(Bundle storage bundle, string memory name) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("assignName", param(name));
        Validator.MUST_NotEmptyName(name);
        bundle.startBuilding();
        bundle.name = name;
        bundle.finishBuilding();
        return bundle.finishProcess(pid);
    }

    /**-------------------------
        🧩 Push Function(s)
    ---------------------------*/
    function pushFunction(Bundle storage bundle, Function storage func) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("pushFunction", param(func));
        Validator.MUST_Completed(func);
        Validator.MUST_HaveUniqueSelector(bundle, func);
        bundle.startBuilding();
        bundle.functions.push(func);
        bundle.finishBuilding();
        return bundle.finishProcess(pid);
    }
    function pushFunctions(Bundle storage bundle, Function[] storage functions) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("pushFunctions", param(functions));
        for (uint i; i < functions.length; ++i) {
            bundle.pushFunction(functions[i]);
        }
        return bundle.finishProcess(pid);
    }

    /**----------------------
        🪟 Assign Facade
    ------------------------*/
    function assignFacade(Bundle storage bundle, address facade) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("assignFacade", param(facade));
        Validator.MUST_AddressIsContract(facade);
        bundle.startBuilding();
        bundle.facade = facade;
        bundle.finishBuilding();
        return bundle.finishProcess(pid);
    }

}

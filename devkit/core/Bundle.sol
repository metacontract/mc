// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {ProcessLib} from "devkit/utils/debug/ProcessLib.sol";
    using ProcessLib for Bundle global;
import {Parser} from "devkit/utils/debug/Parser.sol";
    using Parser for Bundle global;
import {Inspector} from "devkit/types/Inspector.sol";
    using Inspector for Bundle global;
import {TypeGuard, TypeStatus} from "devkit/types/TypeGuard.sol";
    using TypeGuard for Bundle global;
// Validation
import {Validate} from "devkit/validate/Validate.sol";

// Core Type
import {Function} from "devkit/core/Function.sol";


/**================
    🗂️ Bundle
==================*/
using BundleLib for Bundle global;
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
        uint pid = bundle.startProcess("assignName");
        Validate.MUST_BundleNotLocked(bundle);
        Validate.MUST_NotEmptyName(name);
        bundle.name = name;
        return bundle.building().finishProcess(pid);
    }

    /**-------------------------
        🧩 Push Function(s)
    ---------------------------*/
    function pushFunction(Bundle storage bundle, Function storage func) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("pushFunction");
        Validate.MUST_BundleNotLocked(bundle);
        Validate.MUST_completed(func);
        Validate.MUST_notHave(bundle, func);
        bundle.functions.push(func);
        return bundle.building().finishProcess(pid);
    }
    function pushFunctions(Bundle storage bundle, Function[] storage functions) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("pushFunctions");
        for (uint i; i < functions.length; ++i) {
            bundle.pushFunction(functions[i]);
        }
        return bundle.building().finishProcess(pid);
    }

    /**----------------------
        🪟 Assign Facade
    ------------------------*/
    function assignFacade(Bundle storage bundle, address facade) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("assignFacade");
        Validate.MUST_AddressIsContract(facade);
        bundle.facade = facade;
        return bundle.building().finishProcess(pid);
    }

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**--------------------------
    Apply Support Methods
----------------------------*/
import {ProcessLib} from "devkit/method/debug/ProcessLib.sol";
    using ProcessLib for Bundle global;
import {Parser} from "devkit/method/debug/Parser.sol";
    using Parser for Bundle global;
import {Inspector} from "devkit/method/inspector/Inspector.sol";
    using Inspector for Bundle global;

// Core Type
import {Function} from "devkit/core/Function.sol";
// Validation
import {valid, Valid} from "devkit/error/Valid.sol";


/**================
    🗂️ Bundle
==================*/
using BundleLib for Bundle global;
struct Bundle {
    string name;
    Function[] functions;
    address facade;
}

/**~~~~~~~~~~~~~~~~~~~~~~~~~~~
    🗂️ Core Methods
        📥 Assign Bundle
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
library BundleLib {
    /**---------------------------
        📥 Assign Bundle
    -----------------------------*/
    function assignName(Bundle storage bundle, string memory name) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("assignName");
        Valid.notEmptyString(name);
        bundle.name = name;
        return bundle.finishProcess(pid);
    }

    function pushFunction(Bundle storage bundle, Function storage func) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("pushFunction");
        valid(bundle.hasNot(func), "Already added");
        bundle.functions.push(
            func.assertImplIsContract()
        );
        return bundle.finishProcess(pid);
    }
    function pushFunctions(Bundle storage bundle, Function[] storage functions) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("pushFunctions");
        for (uint i; i < functions.length; ++i) {
            bundle.pushFunction(functions[i]);
        }
        return bundle.finishProcess(pid);
    }

    function assignFacade(Bundle storage bundle, address facade) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("assignFacade");
        Valid.isContract(facade);
        bundle.facade = facade;
        return bundle.finishProcess(pid);
    }

}

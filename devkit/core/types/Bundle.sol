// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {ProcessLib} from "devkit/core/method/debug/ProcessLib.sol";
    using ProcessLib for Bundle global;
import {Parser} from "devkit/core/method/debug/Parser.sol";
    using Parser for Bundle global;
import {Inspector} from "devkit/core/method/inspector/Inspector.sol";
    using Inspector for Bundle global;
import {TypeSafetyUtils, BuildStatus} from "devkit/utils/type/TypeSafetyUtils.sol";
// Validation
import {validate} from "devkit/error/Validate.sol";
import {Require} from "devkit/error/Require.sol";

// Core Type
import {Function} from "devkit/core/types/Function.sol";


/**================
    🗂️ Bundle
==================*/
using BundleLib for Bundle global;
struct Bundle {
    string name;
    Function[] functions;
    address facade;
    BuildStatus buildStatus;
}
library BundleLib {
    /**~~~~~~~~~~~~~~~~~~~~~~~
        📛 Assign Name
        🧩 Push Function(s)
        🪟 Assign Facade
    ~~~~~~~~~~~~~~~~~~~~~~~~~*/

    /**--------------------
        📛 Assign Name
    ----------------------*/
    function assignName(Bundle storage bundle, string memory name) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("assignName");
        Require.notEmptyString(name);
        bundle.name = name;
        return bundle.finishProcess(pid);
    }

    /**-------------------------
        🧩 Push Function(s)
    ---------------------------*/
    function pushFunction(Bundle storage bundle, Function storage func) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("pushFunction");
        validate(bundle.hasNot(func), "Already added");
        Require.implIsContract(func);
        bundle.functions.push(func);
        return bundle.finishProcess(pid);
    }
    function pushFunctions(Bundle storage bundle, Function[] storage functions) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("pushFunctions");
        for (uint i; i < functions.length; ++i) {
            bundle.pushFunction(functions[i]);
        }
        return bundle.finishProcess(pid);
    }

    /**----------------------
        🪟 Assign Facade
    ------------------------*/
    function assignFacade(Bundle storage bundle, address facade) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("assignFacade");
        Require.isContract(facade);
        bundle.facade = facade;
        return bundle.finishProcess(pid);
    }

}

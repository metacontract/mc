// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Validation
import {check} from "devkit/error/validation/Validation.sol";
import {Require} from "devkit/error/validation/Require.sol";
// Utils
import {console2} from "devkit/utils/ForgeHelper.sol";
import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;
import {AddressUtils} from "devkit/utils/AddressUtils.sol";
    using AddressUtils for address;
import {BoolUtils} from "devkit/utils/BoolUtils.sol";
    using BoolUtils for bool;
import {Bytes4Utils} from "devkit/utils/Bytes4Utils.sol";
    using Bytes4Utils for bytes4;
// Debug
import {Debug} from "devkit/debug/Debug.sol";
import {Logger} from "devkit/debug/Logger.sol";
// Core
import {Function} from "devkit/core/Function.sol";

import {Bundle} from "devkit/core/Bundle.sol";


/**~~~~~~~~~~~~~~~~~~~~~~~~~~~
    🗂️ Bundle
        📥 Assign Bundle
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
library BundleLib {
    /**---------------------------
        📥 Assign Bundle
    -----------------------------*/
    function assignName(Bundle storage bundle, string memory name) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("assignName");
        Require.notEmptyString(name);
        bundle.name = name;
        return bundle.finishProcess(pid);
    }

    function pushFunction(Bundle storage bundle, Function storage func) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("pushFunction");
        check(bundle.hasNot(func), "Already added");
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
        Require.isContract(facade);
        bundle.facade = facade;
        return bundle.finishProcess(pid);
    }

}

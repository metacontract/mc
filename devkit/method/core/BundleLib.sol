// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Validation
import {check} from "devkit/error/Validation.sol";
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
    function safeAssign(Bundle storage bundle, string memory name) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("safeAssign");
        bundle.name = name.assertNotEmpty();
        return bundle.finishProcess(pid);
    }

    function safeAssign(Bundle storage bundle, address facade) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("safeAssign");
        bundle.facade = facade.assertIsContract();
        return bundle.finishProcess(pid);
    }

    function safeAdd(Bundle storage bundle, Function storage functionInfo) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("safeAdd");
        check(bundle.hasNot(functionInfo), "Already added");
        bundle.functionInfos.push(
            functionInfo.assertImplIsContract()
        );
        return bundle.finishProcess(pid);
    }
    function safeAdd(Bundle storage bundle, Function[] storage functionInfos) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("safeAdd");
        for (uint i; i < functionInfos.length; ++i) {
            bundle.safeAdd(functionInfos[i]);
        }
        return bundle.finishProcess(pid);
    }
}

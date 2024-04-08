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

/**====================
    🧺 Bundle Info
======================*/
using BundleUtils for Bundle global;
struct Bundle {
    string name;
    Function[] functionInfos;
    address facade;
}

library BundleUtils {
    string constant LIB_NAME = "Bundle";
    function recordExecStart(string memory funcName, string memory params) internal returns(uint) {
        return Debug.recordExecStart(LIB_NAME, funcName, params);
    }
    function recordExecStart(string memory funcName) internal returns(uint) {
        return recordExecStart(funcName, "");
    }
    function recordExecFinish(Bundle storage bundle, uint pid) internal returns(Bundle storage) {
        Debug.recordExecFinish(pid);
        return bundle;
    }

    /**---------------------------
        📥 Assign Bundle
    -----------------------------*/
    function safeAssign(Bundle storage bundle, string memory name) internal returns(Bundle storage) {
        uint pid = recordExecStart("safeAssign");
        bundle.name = name.assertNotEmpty();
        return bundle.recordExecFinish(pid);
    }

    function safeAssign(Bundle storage bundle, address facade) internal returns(Bundle storage) {
        uint pid = recordExecStart("safeAssign");
        bundle.facade = facade.assertIsContract();
        return bundle.recordExecFinish(pid);
    }

    function safeAdd(Bundle storage bundle, Function storage functionInfo) internal returns(Bundle storage) {
        uint pid = recordExecStart("safeAdd");
        check(bundle.hasNot(functionInfo), "Already added");
        bundle.functionInfos.push(
            functionInfo.assertImplIsContract()
        );
        return bundle.recordExecFinish(pid);
    }
    function safeAdd(Bundle storage bundle, Function[] storage functionInfos) internal returns(Bundle storage) {
        uint pid = recordExecStart("safeAdd");
        for (uint i; i < functionInfos.length; ++i) {
            bundle.safeAdd(functionInfos[i]);
        }
        return bundle.recordExecFinish(pid);
    }


    /**-------------------------------
        🧐 Inspectors & Assertions
    ---------------------------------*/
    function has(Bundle storage bundle, Function storage functionInfo) internal view returns(bool flag) {
        for (uint i; i < bundle.functionInfos.length; ++i) {
            if (functionInfo.isEqual(bundle.functionInfos[i])) return true;
        }
    }
    function hasNot(Bundle storage bundle, Function storage functionInfo) internal returns(bool) {
        return bundle.has(functionInfo).isFalse();
    }

    function isComplete(Bundle storage bundle) internal returns(bool) {
        return  bundle.name.isNotEmpty() &&
                bundle.functionInfos.length != 0 &&
                bundle.facade.isContract();
    }
    function assertComplete(Bundle storage bundle) internal returns(Bundle storage) {
        check(bundle.isComplete(), "Bundle Info Not Complete", bundle.parse());
        return bundle;
    }

    function hasName(Bundle storage bundle) internal returns(bool) {
        return bundle.name.isNotEmpty();
    }
    function hasNotName(Bundle storage bundle) internal returns(bool) {
        return bundle.name.isEmpty();
    }

    function exists(Bundle storage bundle) internal returns(bool) {
        return  bundle.name.isNotEmpty() ||
                bundle.functionInfos.length != 0 ||
                bundle.facade.isNotContract();
    }
    function notExists(Bundle storage bundle) internal returns(bool) {
        return bundle.exists().isNot();
    }
    function assertExists(Bundle storage bundle) internal returns(Bundle storage) {
        check(bundle.exists(), "Bundle Info Not Exists");
        return bundle;
    }
    function assertNotExists(Bundle storage bundle) internal returns(Bundle storage) {
        check(bundle.notExists(), "Bundle Info Already Exists");
        return bundle;
    }


    /**---------------
        🐞 Debug
    -----------------*/
    function parseAndLog(Bundle storage bundle) internal returns(Bundle storage) {
        Logger.logDebug(
            bundle.parse()
        );
        return bundle;
    }
    function parse(Bundle storage bundle) internal returns(string memory message) {
        message = message.append("Facade: ").append(bundle.facade);

        Function[] memory _funcs = bundle.functionInfos;
        for (uint i; i < _funcs.length; ++i) {
            message = message.br().append(_funcs[i].parse());
        }
        console2.log(message);
    }

}

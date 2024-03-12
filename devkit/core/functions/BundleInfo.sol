// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Global Methods
import "@devkit/utils/GlobalMethods.sol";
// Utils
import {console2} from "@devkit/utils/ForgeHelper.sol";
import {StringUtils} from "@devkit/utils/StringUtils.sol";
    using StringUtils for string;
import {AddressUtils} from "@devkit/utils/AddressUtils.sol";
    using AddressUtils for address;
import {BoolUtils} from "@devkit/utils/BoolUtils.sol";
    using BoolUtils for bool;
import {Bytes4Utils} from "@devkit/utils/Bytes4Utils.sol";
    using Bytes4Utils for bytes4;
// Debug
import {Debug} from "@devkit/debug/Debug.sol";
import {Logger} from "@devkit/debug/Logger.sol";
// Core
import {FuncInfo} from "@devkit/core/functions/FuncInfo.sol";

/**====================
    🧺 Bundle Info
======================*/
using BundleInfoUtils for BundleInfo global;
struct BundleInfo {
    string name;
    FuncInfo[] functionInfos;
    address facade;
}

library BundleInfoUtils {
    string constant LIB_NAME = "BundleInfo";
    function __recordExecStart(string memory funcName, string memory params) internal {
        Debug.recordExecStart(LIB_NAME, funcName, params);
    }
    function __recordExecStart(string memory funcName) internal {
        __recordExecStart(funcName, "");
    }
    function __signalComletion() internal {}
    function signalCompletion(BundleInfo storage target) internal returns(BundleInfo storage) {
        __signalComletion();
        return target;
    }

    /**---------------------------
        📥 Assign BundleInfo
    -----------------------------*/
    function safeAssign(BundleInfo storage bundleInfo, string memory name) internal returns(BundleInfo storage) {
        __recordExecStart("safeAssign");
        bundleInfo.name = name.assertNotEmpty();
        return bundleInfo;
    }

    function safeAssign(BundleInfo storage bundleInfo, address facade) internal returns(BundleInfo storage) {
        __recordExecStart("safeAssign");
        bundleInfo.facade = facade.assertIsContract();
        return bundleInfo;
    }

    function safeAdd(BundleInfo storage bundleInfo, FuncInfo storage functionInfo) internal returns(BundleInfo storage) {
        __recordExecStart("safeAdd");
        check(bundleInfo.hasNot(functionInfo), "Already added");
        bundleInfo.functionInfos.push(
            functionInfo.assertImplIsContract()
        );
        return bundleInfo;
    }
    function safeAdd(BundleInfo storage bundleInfo, FuncInfo[] storage functionInfos) internal returns(BundleInfo storage) {
        __recordExecStart("safeAdd");
        for (uint i; i < functionInfos.length; ++i) {
            bundleInfo.safeAdd(functionInfos[i]);
        }
        return bundleInfo;
    }


    /**-------------------------------
        🧐 Inspectors & Assertions
    ---------------------------------*/
    function has(BundleInfo storage bundleInfo, FuncInfo storage functionInfo) internal view returns(bool flag) {
        for (uint i; i < bundleInfo.functionInfos.length; ++i) {
            if (functionInfo.isEqual(bundleInfo.functionInfos[i])) return true;
        }
    }
    function hasNot(BundleInfo storage bundleInfo, FuncInfo storage functionInfo) internal returns(bool) {
        return bundleInfo.has(functionInfo).isFalse();
    }

    function isComplete(BundleInfo storage bundleInfo) internal returns(bool) {
        return  bundleInfo.name.isNotEmpty() &&
                bundleInfo.functionInfos.length != 0 &&
                bundleInfo.facade.isContract();
    }
    function assertComplete(BundleInfo storage bundleInfo) internal returns(BundleInfo storage) {
        check(bundleInfo.isComplete(), "Bundle Info Not Complete", bundleInfo.parse());
        return bundleInfo;
    }

    function hasName(BundleInfo storage bundleInfo) internal returns(bool) {
        return bundleInfo.name.isNotEmpty();
    }
    function hasNotName(BundleInfo storage bundleInfo) internal returns(bool) {
        return bundleInfo.name.isEmpty();
    }

    function exists(BundleInfo storage bundleInfo) internal returns(bool) {
        return  bundleInfo.name.isNotEmpty() ||
                bundleInfo.functionInfos.length != 0 ||
                bundleInfo.facade.isNotContract();
    }
    function notExists(BundleInfo storage bundleInfo) internal returns(bool) {
        return bundleInfo.exists().isNot();
    }
    function assertExists(BundleInfo storage bundleInfo) internal returns(BundleInfo storage) {
        check(bundleInfo.exists(), "Bundle Info Not Exists");
        return bundleInfo;
    }
    function assertNotExists(BundleInfo storage bundleInfo) internal returns(BundleInfo storage) {
        check(bundleInfo.notExists(), "Bundle Info Already Exists");
        return bundleInfo;
    }


    /**---------------
        🐞 Debug
    -----------------*/
    function parseAndLog(BundleInfo storage bundleInfo) internal returns(BundleInfo storage) {
        Logger.logDebug(
            bundleInfo.parse()
        );
        return bundleInfo;
    }
    function parse(BundleInfo storage bundleInfo) internal returns(string memory message) {
        message = message.append("Facade: ").append(bundleInfo.facade);

        FuncInfo[] memory _funcs = bundleInfo.functionInfos;
        for (uint i; i < _funcs.length; ++i) {
            message = message.br().append(_funcs[i].parse());
        }
        console2.log(message);
    }

}

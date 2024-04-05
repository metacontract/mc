// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Validation
import {check} from "devkit/error/Validation.sol";
// Utils
import {console2} from "../../utils/ForgeHelper.sol";
import {StringUtils} from "../../utils/StringUtils.sol";
    using StringUtils for string;
import {AddressUtils} from "../../utils/AddressUtils.sol";
    using AddressUtils for address;
import {BoolUtils} from "../../utils/BoolUtils.sol";
    using BoolUtils for bool;
import {Bytes4Utils} from "../../utils/Bytes4Utils.sol";
    using Bytes4Utils for bytes4;
// Debug
import {Debug} from "../../debug/Debug.sol";
import {Logger} from "../../debug/Logger.sol";
// Core
import {FuncInfo} from "./FuncInfo.sol";

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
    function recordExecStart(string memory funcName, string memory params) internal returns(uint) {
        return Debug.recordExecStart(LIB_NAME, funcName, params);
    }
    function recordExecStart(string memory funcName) internal returns(uint) {
        return recordExecStart(funcName, "");
    }
    function recordExecFinish(BundleInfo storage bundleInfo, uint pid) internal returns(BundleInfo storage) {
        Debug.recordExecFinish(pid);
        return bundleInfo;
    }

    /**---------------------------
        📥 Assign BundleInfo
    -----------------------------*/
    function safeAssign(BundleInfo storage bundleInfo, string memory name) internal returns(BundleInfo storage) {
        uint pid = recordExecStart("safeAssign");
        bundleInfo.name = name.assertNotEmpty();
        return bundleInfo.recordExecFinish(pid);
    }

    function safeAssign(BundleInfo storage bundleInfo, address facade) internal returns(BundleInfo storage) {
        uint pid = recordExecStart("safeAssign");
        bundleInfo.facade = facade.assertIsContract();
        return bundleInfo.recordExecFinish(pid);
    }

    function safeAdd(BundleInfo storage bundleInfo, FuncInfo storage functionInfo) internal returns(BundleInfo storage) {
        uint pid = recordExecStart("safeAdd");
        check(bundleInfo.hasNot(functionInfo), "Already added");
        bundleInfo.functionInfos.push(
            functionInfo.assertImplIsContract()
        );
        return bundleInfo.recordExecFinish(pid);
    }
    function safeAdd(BundleInfo storage bundleInfo, FuncInfo[] storage functionInfos) internal returns(BundleInfo storage) {
        uint pid = recordExecStart("safeAdd");
        for (uint i; i < functionInfos.length; ++i) {
            bundleInfo.safeAdd(functionInfos[i]);
        }
        return bundleInfo.recordExecFinish(pid);
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

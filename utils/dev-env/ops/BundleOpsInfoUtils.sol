// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ForgeHelper, console2} from "dev-env/common/ForgeHelper.sol";

import {DevUtils} from "dev-env/common/DevUtils.sol";
import {OpInfo, Op, BundleOpsInfo} from "dev-env/UCSDevEnv.sol";

library BundleOpsInfoUtils {
    using DevUtils for string;
    using DevUtils for bytes4;
    using DevUtils for address;

    /**
        Setter Methods
     */
    function set(BundleOpsInfo storage bundleOpsInfo, string memory keyword) internal returns(BundleOpsInfo storage) {
        bundleOpsInfo.keyword = keyword.assertNotEmpty();
        return bundleOpsInfo;
    }

    function set(BundleOpsInfo storage bundleOpsInfo, address facade) internal returns(BundleOpsInfo storage) {
        bundleOpsInfo.facade = facade.assertContractExists();
        return bundleOpsInfo;
    }

    function add(BundleOpsInfo storage bundleOpsInfo, OpInfo storage opInfo) internal returns(BundleOpsInfo storage) {
        bundleOpsInfo.opInfos.push(opInfo.assertExists("add").assertNotIncludedIn(bundleOpsInfo).assignLabel());
        return bundleOpsInfo;
    }

    function add(BundleOpsInfo storage bundleOpsInfo, OpInfo[] storage opInfos) internal returns(BundleOpsInfo storage) {
        for (uint i; i < opInfos.length; ++i) {
            bundleOpsInfo.add(opInfos[i]);
        }
        return bundleOpsInfo;
    }


    /**
        Convert
     */
    function toOps(BundleOpsInfo memory bundleOpsInfo) internal returns(Op[] memory) {
        uint count = bundleOpsInfo.opInfos.length;
        Op[] memory ops = new Op[](count);
        for (uint i; i < count; ++i) {
            bundleOpsInfo.opInfos[i].copyTo(ops[i]);
        }
        return ops;
    }

    /**
        Inspections
     */
    function exists(BundleOpsInfo storage bundleOpsInfo) internal returns(bool) {
        return !bundleOpsInfo.keyword.isEmpty();
    }

    function has(BundleOpsInfo storage bundleOpsInfo, OpInfo storage opInfo) internal returns(bool flag) {
        OpInfo[] memory _opInfos = bundleOpsInfo.opInfos;
        bytes32 opInfoHash = keccak256(abi.encode(opInfo));
        for (uint i; i < _opInfos.length; ++i) {
            if (DevUtils.isEqual(opInfo.keyword, _opInfos[i].keyword)) DevUtils.revertWith("Same Keyword");
            if (opInfo.selector == _opInfos[i].selector) DevUtils.revertWith("Same Selector");
            bytes32 _opInfoHash = keccak256(abi.encode(_opInfos[i]));
            if (opInfoHash == _opInfoHash) flag = true;
        }
    }

    /**
        Assertions
     */
    function assertExists(BundleOpsInfo storage bundleOpsInfo) internal returns(BundleOpsInfo storage) {
        if (!bundleOpsInfo.exists()) {
            DevUtils.revertWith("Bundle Ops Info does not exist.");
        }
        return bundleOpsInfo;
    }

    function assertNotExists(BundleOpsInfo storage bundleOpsInfo, string memory errorString) internal returns(BundleOpsInfo storage) {
        if (bundleOpsInfo.exists()) DevUtils.revertWith(errorString, "BundleOpsInfo exists");
        return bundleOpsInfo;
    }

    /**
        Logging
     */
    function emitLog(BundleOpsInfo storage bundleOpsInfo) internal returns(BundleOpsInfo storage) {
        if (DevUtils.shouldLog()) {
            console2.log("Facade Contract:", bundleOpsInfo.facade);
            for (uint i; i < bundleOpsInfo.opInfos.length; ++i) {
                console2.log("Op Keyword:", bundleOpsInfo.opInfos[i].keyword);
            }
        }
        return bundleOpsInfo;
    }
}

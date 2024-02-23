// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ForgeHelper, console2} from "dev-env/common/ForgeHelper.sol";

import {DevUtils} from "dev-env/common/DevUtils.sol";
import {OpInfo, Op, BundleOpsInfo} from "dev-env/UCSDevEnv.sol";

library BundleOpsInfoUtils {
    /**
        Setter Methods
     */
    function set(BundleOpsInfo storage bundleOpsInfo, OpInfo storage opInfo) internal returns(BundleOpsInfo storage) {
        opInfo  .assertNotEmpty()
                .assertNotIncludedIn(bundleOpsInfo);
        bundleOpsInfo.opInfos.push(opInfo);
        return bundleOpsInfo;
    }
    function set(BundleOpsInfo storage bundleOpsInfo, address facade) internal returns(BundleOpsInfo storage) {
        DevUtils.assertContractExists(facade);
        bundleOpsInfo.facade = facade;
        return bundleOpsInfo;
    }


    /**
        Helper Methods
     */
    function exists(BundleOpsInfo storage bundleOpsInfo, OpInfo storage opInfo) internal returns(bool flag) {
        OpInfo[] memory _opInfos = bundleOpsInfo.opInfos;
        bytes32 opInfoHash = keccak256(abi.encode(opInfo));
        for (uint i; i < _opInfos.length; ++i) {
            if (DevUtils.isEqual(opInfo.keyword, _opInfos[i].keyword)) DevUtils.revertWithDevEnvError("Same Keyword");
            if (opInfo.selector == _opInfos[i].selector) DevUtils.revertWithDevEnvError("Same Selector");
            bytes32 _opInfoHash = keccak256(abi.encode(_opInfos[i]));
            if (opInfoHash == _opInfoHash) flag = true;
        }
    }

    // function toOp(OpInfo memory opInfo) internal returns(Op memory) {
    //     return Op({
    //         selector: opInfo.selector,
    //         implementation: opInfo.deployedContract
    //     });
    // }

    // function exists(OpInfo storage opInfo) internal returns(bool) {
    //     return opInfo.deployedContract.code.length != 0;
    // }

    // function assignLabel(OpInfo storage opInfo) internal returns(OpInfo storage) {
    //     if (opInfo.exists()) {
    //         ForgeHelper.assignLabel(opInfo.deployedContract, opInfo.keyword);
    //     }
    //     return opInfo;
    // }

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

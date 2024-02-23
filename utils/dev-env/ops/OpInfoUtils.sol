// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ForgeHelper, console2} from "dev-env/common/ForgeHelper.sol";

import {DevUtils} from "dev-env/common/DevUtils.sol";
import {OpInfo, Op, BundleOpsInfo} from "dev-env/UCSDevEnv.sol";

library OpInfoUtils {
    using DevUtils for string;
    using DevUtils for bytes4;
    using DevUtils for address;
    using {ForgeHelper.tryGetDeployedContract} for string;
    using {ForgeHelper.assignLabel} for address;

    /**
        Setter Methods
     */
    function set(OpInfo storage opInfo, string memory keyword, bytes4 selector) internal returns(OpInfo storage) {
        address deployedContract = ForgeHelper.getAddressOrZero(keyword);
        opInfo.set(keyword, selector, deployedContract);
        return opInfo;
    }
    function set(OpInfo storage opInfo, string memory keyword, bytes4 selector, address deployedContract) internal returns(OpInfo storage) {
        DevUtils.assertNotEmpty(selector);
        opInfo.keyword = keyword;
        opInfo.selector = selector;
        opInfo.deployedContract = deployedContract;
        return opInfo;
    }
    function set(OpInfo storage opInfo, string memory keyword) internal returns(OpInfo storage) {
        opInfo.keyword = keyword.assertNotEmpty();
        return opInfo;
    }
    function set(OpInfo storage opInfo, bytes4 selector) internal returns(OpInfo storage) {
        opInfo.selector = selector.assertNotEmpty();
        return opInfo;
    }
    function set(OpInfo storage opInfo, address deployedContract) internal returns(OpInfo storage) {
        opInfo.deployedContract = deployedContract.assertContractExists();
        return opInfo;
    }
    function trySetDeployedContract(OpInfo storage opInfo) internal returns(OpInfo storage) {
        string memory keyword = opInfo.keyword;
        (bool success, address deployedContract) = keyword.tryGetDeployedContract();
        if (success) {
            opInfo.deployedContract = deployedContract.assignLabel(keyword);
        } else {
            DevUtils.log("Deployed Contract: Not Found");
        }
        return opInfo;
    }


    /**
        Helper Methods
     */
    function toOp(OpInfo memory opInfo) internal returns(Op memory) {
        return Op({
            selector: opInfo.selector,
            implementation: opInfo.deployedContract
        });
    }

    function exists(OpInfo memory opInfo) internal returns(bool) {
        address deployedContract = opInfo.deployedContract;
        return DevUtils.exists(deployedContract);
    }

    function assignLabel(OpInfo storage opInfo) internal returns(OpInfo storage) {
        if (opInfo.exists()) {
            ForgeHelper.assignLabel(opInfo.deployedContract, opInfo.keyword);
        }
        return opInfo;
    }

    function emitLog(OpInfo storage opInfo) internal returns(OpInfo storage) {
        if (DevUtils.shouldLog()) {
            console2.log(
                "Deployed Contract:", opInfo.deployedContract,
                ", Keyword:", opInfo.keyword
            );
        }
        return opInfo;
    }

    function assertNotEmpty(OpInfo storage opInfo) internal returns(OpInfo storage) {
        if (!opInfo.exists()) {
            DevUtils.revertWithDevEnvError("Empty Deployed Contract in OpInfo");
        }
        return opInfo;
    }

    function assertNotIncludedIn(OpInfo storage opInfo, BundleOpsInfo storage bundleOpsInfo) internal returns(OpInfo storage) {
        if (bundleOpsInfo.exists(opInfo)) {
            DevUtils.revertWithDevEnvError("Already exists in the BundelOp");
        }
        return opInfo;
    }

}

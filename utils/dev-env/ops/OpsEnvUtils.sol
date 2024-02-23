// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {UCSOpsEnv, OpInfo} from "dev-env/UCSDevEnv.sol";
import {DevUtils} from "dev-env/common/DevUtils.sol";

/**********************************
    🧩 Ops Deployed Contract Utils
        - Deploy Dictionary
        - Clone Dictionary
        - SetOp
        - UpgradeFacade
**********************************/
library OpsEnvUtils {
    /**--------------------------
        📦 Setup Standard Ops
    ----------------------------*/
    function setStdOpsInfoAndTrySetDeployedOps(UCSOpsEnv storage ops) internal returns(UCSOpsEnv storage) {
        ops.stdOps.setStdOpsInfoAndTrySetDeployedOps();
        return ops;
    }

    function deployStdOpsIfNotExists(UCSOpsEnv storage ops) internal returns(UCSOpsEnv storage) {
        ops.stdOps.deployStdOpsIfNotExists();
        return ops;
    }

    function setStdBundleOps(UCSOpsEnv storage ops) internal returns(UCSOpsEnv storage) {
        ops.stdOps.setStdBundleOps();
        return ops;
    }

    /**
        Custom Ops
            - Setter
            - Getter
     */
    function setCustomOp(UCSOpsEnv storage ops, string memory name, OpInfo memory opInfo) internal returns(UCSOpsEnv storage) {
        bytes32 _nameHash = DevUtils.getHash(name);
        ops.customOps.ops[_nameHash] = opInfo;
        return ops;
    }

    function getCustomOpInfo(UCSOpsEnv storage ops, string memory name) internal returns(OpInfo memory) {
        bytes32 _nameHash = DevUtils.getHash(name);
        return ops.customOps.ops[_nameHash];
    }

}

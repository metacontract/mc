// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {UCSOpsEnv, OpInfo} from "dev-env/UCSDevEnv.sol";
import {DevUtils} from "dev-env/common/DevUtils.sol";

/**********************************
    🧩 Ops Environment Utils
        🌐 for Standard Ops
        ✨ for Custom Ops
**********************************/
library OpsEnvUtils {
    /**--------------------------
        🌐 for Standard Ops
    ----------------------------*/
    // function setStdOpsInfoAndTrySetDeployedOps(UCSOpsEnv storage ops) internal returns(UCSOpsEnv storage) {
    //     ops.stdOps.setStdOpsInfoAndTrySetDeployedOps();
    //     return ops;
    // }

    // function deployStdOpsIfNotExists(UCSOpsEnv storage ops) internal returns(UCSOpsEnv storage) {
    //     ops.stdOps.deployStdOpsIfNotExists();
    //     return ops;
    // }

    // function setStdBundleOps(UCSOpsEnv storage ops) internal returns(UCSOpsEnv storage) {
    //     ops.stdOps.setStdBundleOps();
    //     return ops;
    // }


    /**--------------------------
        ✨ for Custom Ops
    ----------------------------*/
    // function setCustomOpInfo(UCSOpsEnv storage ops, string memory name, OpInfo memory opInfo) internal returns(UCSOpsEnv storage) {
    // }

    // function getCustomOpInfo(UCSOpsEnv storage ops, string memory name) internal returns(OpInfo memory) {
    // }

}

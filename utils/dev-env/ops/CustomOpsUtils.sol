// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ForgeHelper, console2} from "dev-env/common/ForgeHelper.sol";
import {DevUtils} from "dev-env/common/DevUtils.sol";
import {CustomOps, StdOps, OpInfo, BundleOpsInfo} from "dev-env/UCSDevEnv.sol";

// Ops
import {InitSetAdminOp} from "src/ops/InitSetAdminOp.sol";
import {GetDepsOp} from "src/ops/GetDepsOp.sol";
import {CloneOp} from "src/ops/CloneOp.sol";
import {SetImplementationOp} from "src/ops/SetImplementationOp.sol";
import {StdOpsFacade} from "src/interfaces/facades/StdOpsFacade.sol";
import {DefaultOpsFacade} from "src/interfaces/facades/DefaultOpsFacade.sol";

/****************************************************
    🧩✨ CUstom Ops Primitive Utils
        📦 Set Deployed Standard Ops Info
        🐣 Deploy Standard Ops If Not Exists
        🔗 Set Standard Bundle Ops
        🔧 Helper Methods for each Standard Ops
*****************************************************/
library CustomOpsUtils {
    using DevUtils for string;
    using DevUtils for address;

    /**
        📦 Custom Ops
     */
    function setOpInfo(CustomOps storage customOps, string memory keyword, bytes4 selector, address deployedContract) internal returns(CustomOps storage) {
        customOps.getRef_OpInfoBy(keyword).set(keyword, selector, deployedContract); // TODO refactor
        return customOps;
    }

    function getRef_OpInfoBy(CustomOps storage customOps, string memory name) internal returns(OpInfo storage) {
        return customOps.ops[DevUtils.getHash(name.assertNotEmpty())];
    }

    function getRef_ExistingOpInfoBy(CustomOps storage customOps, string memory name) internal returns(OpInfo storage) {
        return customOps.getRef_OpInfoBy(name).assertExists("GetCustomOpInfo_NotFound");
    }


    /**
        🔗 Custom Bundle Ops
     */
    /**
        🐣 Create Custom Bundle Ops
     */
    function createBundleOpsInfo(CustomOps storage customOps, string memory name) internal returns(CustomOps storage) {
        customOps.getRef_BundleOpsInfoBy(name)
                    .assertNotExists("CreateCustomBundleOps_AlreadyExists")
                    .set(name);
        return customOps;
    }

    /**
        Add Op
     */
    function addToBundleOps(CustomOps storage customOps, string memory name, OpInfo storage opInfo) internal returns(CustomOps storage) {
        customOps.getRef_BundleOpsInfoBy(name)
                    .assertExists()
                    .add(opInfo);
        return customOps;
    }
    function addToBundleOps(CustomOps storage customOps, string memory name, OpInfo[] storage opInfos) internal returns(CustomOps storage) {
        customOps.getRef_BundleOpsInfoBy(name)
                    .assertExists()
                    .add(opInfos);
        return customOps;
    }

    /**
        Set Facade
     */
    function set(CustomOps storage customOps, string memory name, address facade) internal returns(CustomOps storage) {
        customOps.getRef_BundleOpsInfoBy(name)
                    .assertExists()
                    .set(facade);
        return customOps;
    }

    /**
        Getter
     */
    function getRef_BundleOpsInfoBy(CustomOps storage customOps, string memory name) internal returns(BundleOpsInfo storage) {
        return customOps.bundles[DevUtils.getHash(name.assertNotEmpty())];
    }

    function existsBundleOps(CustomOps storage customOps, string memory name) internal returns(bool) {
        return customOps.bundles[DevUtils.getHash(name)].exists();
    }

    function findUnusedCustomBundleOpsName(CustomOps storage customOps) internal returns(string memory name) {
        (uint start, uint end) = DevUtils.getScanRange();
        string memory baseName = "CustomBundleOps";

        for (uint i = start; i <= end; ++i) {
            name = ForgeHelper.appendNumberToNameIfNotOne(baseName, i);
            if (!customOps.existsBundleOps(name)) return name;
        }

        DevUtils.revertUnusedNameNotFound();
    }

}

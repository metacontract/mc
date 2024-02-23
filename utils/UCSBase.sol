// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {CommonBase} from "forge-std/Base.sol";

import {ForgeHelper} from "dev-env/common/ForgeHelper.sol";
import {UCSDevEnv} from "dev-env/UCSDevEnv.sol";


abstract contract UCSCommonBase is CommonBase {
    UCSDevEnv internal ucs;

    uint256 deployerKey;
    address deployer;

    constructor() {
        // ucs.toggleLog();
        ucs.ops.stdOps.setStdOpsInfoAndTrySetDeployedOps().deployStdOpsIfNotExists().setStdBundleOps();
    }

    /**************************************
        🛠 Environment Helper Functions
    **************************************/
    function getPrivateKey(string memory keyword) internal view returns(uint256) {
        return ForgeHelper.getPrivateKey(keyword);
    }

    function getAddressOr(string memory keyword, address addr) internal view returns(address) {
        return ForgeHelper.getAddressOr(keyword, addr);
    }
}

abstract contract UCSScriptBase is UCSCommonBase {
    constructor() {
        // ucs.setStdBundleOps();
    }
}

abstract contract UCSTestBase is UCSCommonBase {
    constructor() {
        // ucs.stdOps.deployStdOpsIfNotExists();
        // ucs.setStdBundleOps();
    }
}

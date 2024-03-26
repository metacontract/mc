// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {CommonBase} from "forge-std/Base.sol";

import {ForgeHelper, vm} from "./utils/ForgeHelper.sol";
import {Config} from "./Config.sol";
import {MCDevKit} from "./MCDevKit.sol";


abstract contract MCCommonBase is CommonBase {
    MCDevKit internal mc;

    uint256 deployerKey;
    address deployer;

    constructor() {
        if (Config.DEBUG_MODE) mc.startDebug();
        // mc.setupMCStdFuncs();
    }

    /************************************
        🛠 Environment Helper Methods TODO
    *************************************/
    function getPrivateKey(string memory keyword) internal view returns(uint256) {
        return ForgeHelper.getPrivateKey(keyword);
    }

    function getAddressOr(string memory keyword, address addr) internal view returns(address) {
        return vm.envOr(keyword, addr);
    }
}

abstract contract MCScriptBase is MCCommonBase {
    constructor() {
        // mc.setStdBundle();
    }
}

abstract contract MCTestBase is MCCommonBase {
    constructor() {
        mc.setupMCStdFuncs();
    }
}

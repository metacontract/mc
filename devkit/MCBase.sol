// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// 🛠 FORGE STD
import {CommonBase} from "forge-std/Base.sol";
import {Script as ForgeScript} from "forge-std/Script.sol";
import {Test as ForgeTest} from "forge-std/Test.sol";

import {MCDevKit} from "devkit/global/MCDevKit.sol";
import {ForgeHelper} from "devkit/utils/ForgeHelper.sol";


abstract contract MCBase is CommonBase {
    MCDevKit internal mc;
    uint256 internal deployerKey;
    address internal deployer;
}

abstract contract MCScriptBase is MCBase, ForgeScript {
    modifier startBroadcastWith(string memory envKey) {
        _startBroadcastWith(envKey);
        _;
    }

    modifier startBroadcastWithDeployerPrivKey() {
        _startBroadcastWith("DEPLOYER_PRIV_KEY");
        _;
    }

    function _startBroadcastWith(string memory envKey) internal {
        deployerKey = ForgeHelper.getPrivateKey("DEPLOYER_PRIV_KEY");
        deployer = vm.addr(deployerKey);
        vm.startBroadcast(deployerKey);
    }
}

abstract contract MCTestBase is MCBase, ForgeTest {
    modifier startPrankWith(string memory envKey) {
        _startPrankWith(envKey);
        _;
    }
    modifier startPrankWithDeployer() {
        _startPrankWith("DEPLOYER");
        _;
    }
    function _startPrankWith(string memory envKey) internal {
        deployer = vm.envOr(envKey, makeAddr(envKey));
        vm.startPrank(deployer);
    }

    modifier assumeAddressIsNotReserved(address addr) {
        ForgeHelper.assumeAddressIsNotReserved(addr);
        _;
    }
}

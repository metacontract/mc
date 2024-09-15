// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

// 🛠 FORGE STD
import {CommonBase} from "forge-std/Base.sol";
import {Script as ForgeScript} from "forge-std/Script.sol";
import {Test as ForgeTest} from "forge-std/Test.sol";

import {MCDevKit} from "devkit/MCDevKit.sol";
import {System} from "devkit/system/System.sol";


abstract contract MCBase is CommonBase {
    MCDevKit internal mc;
    uint256 internal deployerKey;
    address internal deployer;

    constructor() {
        System.Config().load();
    }
}

abstract contract MCScriptBase is MCBase, ForgeScript {
    modifier startBroadcastWith(string memory envKey) {
        deployerKey = mc.loadPrivateKey(envKey);
        deployer = vm.addr(deployerKey);
        vm.startBroadcast(deployerKey);
        _;
    }
}

abstract contract MCTestBase is MCBase, ForgeTest {
    modifier startPrankWith(string memory envKey) {
        deployer = vm.envOr(envKey, makeAddr(envKey));
        vm.startPrank(deployer);
        _;
    }
}

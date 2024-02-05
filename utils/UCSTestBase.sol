// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {UCSDeployBase} from "./UCSDeployBase.sol";

abstract contract UCSTestBase is UCSDeployBase, Test {
    modifier startPrankWithDeployer() {
        deployer = getAddressOr("DEPLOYER_ADDR", makeAddr("DEPLOYER"));
        vm.startPrank(deployer);
        _;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {UCSDeployBase} from "./UCSDeployBase.sol";
import {ERC7546Utils} from "@ucs-contracts/src/proxy/ERC7546Utils.sol";

abstract contract UCSTestBase is UCSDeployBase, Test {
    modifier startPrankWithDeployer() {
        deployer = getAddressOr("DEPLOYER_ADDR", makeAddr("DEPLOYER"));
        vm.startPrank(deployer);
        _;
    }

    function setDictionary(address target, address dictionary) internal {
        vm.store(target, ERC7546Utils.DICTIONARY_SLOT, bytes32(uint256(uint160(dictionary))));
    }

    function ignorePrecompiles(address target) internal {
        vm.assume(
            target != address(1) &&
            target != address(2) &&
            target != address(3) &&
            target != address(4) &&
            target != address(5) &&
            target != address(6) &&
            target != address(7) &&
            target != address(8) &&
            target != address(9) &&
            target != 0x4e59b44847b379578588920cA78FbF26c0B4956C &&
            target != 0x7109709ECfa91a80626fF3989D68f67F5b1DD12D &&
            target != 0x000000000000000000636F6e736F6c652e6c6f67
        );
    }
}

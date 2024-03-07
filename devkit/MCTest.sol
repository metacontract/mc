// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ForgeHelper} from "DevKit/common/ForgeHelper.sol";
import {DecodeErrorString} from "DevKit/common/DecodeErrorString.sol";

// 💬 ABOUT
// Meta Contract's default Test based on Forge Std Test

// 🛠 FORGE STD
import {Test as ForgeTest} from "forge-std/Test.sol";

// 📦 BOILERPLATE
import {MCTestBase} from "./MCBase.sol";

// ⭐️ MC TEST
abstract contract MCTest is MCTestBase, ForgeTest {
    modifier startPrankWithDeployer() {
        string memory keyword = "DEPLOYER";
        deployer = getAddressOr(keyword, makeAddr(keyword));
        vm.startPrank(deployer);
        _;
    }

    modifier assumeAddressIsNotReserved(address addr) {
        ForgeHelper.assumeAddressIsNotReserved(addr);
        _;
    }

    function startPrankWith(string memory keyword) internal {
        vm.startPrank(getAddressOr(keyword, makeAddr(keyword)));
    }
}

// 🌟 MC State Fuzzing Test
abstract contract MCStateFuzzingTest is MCTest {
    mapping(bytes4 => address) implementations; // selector => impl

    function setUp() public {
        // implementations TODO
    }

    fallback(bytes calldata) external payable returns (bytes memory){
        address opAddress = implementations[msg.sig];
        require(opAddress != address(0), "Called implementation is not registered.");
        (bool success, bytes memory data) = opAddress.delegatecall(msg.data);
        if (success) {
            return data;
        } else {
            // vm.expectRevert needs this.
            revert(DecodeErrorString.decodeRevertReasonAndPanicCode(data));
        }
    }
}

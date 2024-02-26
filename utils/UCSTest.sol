// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ForgeHelper} from "dev-env/common/ForgeHelper.sol";
import {DecodeErrorString} from "dev-env/common/DecodeErrorString.sol";

// 💬 ABOUT
// UCS's default Script based on Forge Std Script

// 🛠 FORGE STD
import {Test as ForgeTest} from "forge-std/Test.sol";

// 📦 BOILERPLATE
import {UCSTestBase} from "./UCSBase.sol";

// ⭐️ UCS TEST
abstract contract UCSTest is UCSTestBase, ForgeTest {
    modifier startPrankWithDeployer() {
        startPrankWith("DEPLOYER");
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

abstract contract UCSStateFuzzingTest is UCSTest {
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

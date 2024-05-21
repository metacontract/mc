// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Test} from "forge-std/Test.sol";

import {Initialization} from "mc-std/functions/protected/protection/Initialization.sol";
import {Storage} from "mc-std/storage/Storage.sol";

contract InitializationTest is Test {

    function test_ShouldNotBeCompleted_Success() public {
        Initialization.shouldNotBeCompleted();
    }

    function test_ShouldNotBeCompleted_RevertIf_VersionIsNotZero() public {
        Storage.Initialization().initialized = 1;

        vm.expectRevert(Initialization.InvalidInitialization.selector);
        Initialization.shouldNotBeCompleted();
    }

    function test_WillBeCompleted_Success() public {
        vm.expectEmit(address(this));
        emit Initialization.Initialized(1);
        Initialization.willBeCompleted();

        assertEq(Storage.Initialization().initialized, 1);
    }

}

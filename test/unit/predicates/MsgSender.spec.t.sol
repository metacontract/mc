// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";

import {MsgSender} from "~/_predicates/MsgSender.sol";

contract MsgSenderSpecTest is Test {
    function setUp() public {}

    function test_MsgSender_RevertIf_SenderIsNotAdmin() public {
        vm.expectRevert(MsgSender.NotAdmin.selector);
        MsgSender.shouldBeAdmin();
    }
}

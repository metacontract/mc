// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Test} from "forge-std/Test.sol";

import {MsgSender} from "mc-std/functions/protected/protection/MsgSender.sol";

contract MsgSenderTest is Test {
    function test_ShouldBeAdmin_RevertIf_SenderIsNotAdmin() public {
        vm.expectRevert(MsgSender.NotAdmin.selector);
        MsgSender.shouldBeAdmin();
    }
}

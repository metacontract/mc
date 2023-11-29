// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Test} from "forge-std/Test.sol";

import {MsgSender} from "../src/predicates/MsgSender.sol";

contract PredicatesTest is Test {
    function setUp() public {}

    function test_MsgSender() public {
        vm.expectRevert(MsgSender.NotOwner.selector);
        MsgSender.shouldBeOwner();
    }
}

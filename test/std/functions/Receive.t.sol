// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {MCTest} from "devkit/Flattened.sol";
import {Receive} from "mc-std/functions/Receive.sol";

contract ReceiveTest is MCTest {
    function setUp() public {
        _use(bytes4(0), address(new Receive()));
    }

    function test_Receive_Success() public {
        vm.deal(address(this), 100 ether);

        vm.expectEmit(target);
        emit Receive.Received(address(this), 100 ether);
        target.call{value: 100 ether}("");

        assertEq(target.balance, 100 ether);
    }

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

/** < MC Standard Function >
 *  @title Receive
 *  @custom:version v0.1.0
 *  @custom:schema none
 */
contract Receive {
    /// DO NOT USE STORAGE DIRECTLY !!!

    event Received(address from, uint256 amount);
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

}

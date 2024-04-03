// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {ERC7546ProxyEtherscan} from "@ucs.mc/proxy/ERC7546ProxyEtherscan.sol";
import {ERC7546Utils} from "@ucs.mc/proxy/ERC7546Utils.sol";

/**
    < MC Standard Function >
    @title Receive
    @custom:version 0.1.0
    @custom:schema v0.1.0
 */
contract Receive {
    /// DO NOT USE STORAGE DIRECTLY !!!
    event Received(address from, uint256 amount);

    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ERC7546ProxyEtherscan} from "@ucs.mc/proxy/ERC7546ProxyEtherscan.sol";

/**
    < MC Standard Function >
    @title Create
    @custom:version 0.1.0
    @custom:schema v0.1.0
 */
contract Create {
    /// DO NOT USE STORAGE DIRECTLY !!!
    event ProxyCreated(address dictionary, address proxy);

    function create(address dictionary, bytes calldata initData) external returns (address proxy) {
        proxy = address(new ERC7546ProxyEtherscan(dictionary, initData));
        emit ProxyCreated(dictionary, proxy);
    }

}

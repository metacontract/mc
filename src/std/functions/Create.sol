// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Proxy} from "@ucs.mc/proxy/Proxy.sol";

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
        proxy = address(new Proxy(dictionary, initData));
        emit ProxyCreated(dictionary, proxy);
    }

}

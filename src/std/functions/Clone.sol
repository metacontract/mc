// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Proxy} from "@ucs.mc/proxy/Proxy.sol";
import {ProxyUtils} from "@ucs.mc/proxy/ProxyUtils.sol";

/**
    < MC Standard Function >
    @title Clone
    @custom:version 0.1.0
    @custom:schema v0.1.0
 */
contract Clone {
    /// DO NOT USE STORAGE DIRECTLY !!!
    event ProxyCloned(address proxy);

    function clone(bytes calldata initData) external returns (address proxy) {
        proxy = address(new Proxy(ProxyUtils.getDictionary(), initData));
        emit ProxyCloned(proxy);
    }

}

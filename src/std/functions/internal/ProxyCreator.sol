// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Proxy} from "@ucs.mc/proxy/Proxy.sol";

/** < MC Standard Helper Library >
 *  @title Proxy Creator
 *  @custom:version v0.1.0
 *  @custom:schema none
 */
library ProxyCreator {
    event ProxyCreated(address dictionary, address proxy);
    function create(address dictionary, bytes memory initData) internal returns(address proxy) {
        proxy = address(new Proxy(dictionary, initData));
        emit ProxyCreated(dictionary, proxy);
    }
}

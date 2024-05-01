// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ProxyCreator} from "./internal/ProxyCreator.sol";

/** < MC Standard Function >
 *  @title Create
 *  @custom:version v0.1.0
 *  @custom:schema none
 */
contract Create {
    /// DO NOT USE STORAGE DIRECTLY !!!

    function create(address dictionary, bytes calldata initData) external returns(address proxy) {
        proxy = ProxyCreator.create(dictionary, initData);
    }

}

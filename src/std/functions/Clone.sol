// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ProxyCreator} from "./internal/ProxyCreator.sol";
import {ProxyUtils} from "@ucs.mc/proxy/ProxyUtils.sol";

/** < MC Standard Function >
 *  @title Clone
 *  @custom:version v0.1.0
 *  @custom:schema none
 */
contract Clone {
    /// DO NOT USE STORAGE DIRECTLY !!!

    function clone(bytes calldata initData) external returns(address proxy) {
        proxy = ProxyCreator.create(ProxyUtils.getDictionary(), initData);
    }

}

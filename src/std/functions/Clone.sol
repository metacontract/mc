// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {ERC7546ProxyEtherscan} from "@ucs-contracts/src/proxy/ERC7546ProxyEtherscan.sol";
import {ERC7546Utils} from "@ucs-contracts/src/proxy/ERC7546Utils.sol";

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
        proxy = address(new ERC7546ProxyEtherscan(ERC7546Utils.getDictionary(), initData));
        emit ProxyCloned(proxy);
    }

}

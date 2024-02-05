// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

// import {ERC7546Clones} from "@ucs-contracts/src/ERC7546Clones.sol";
import {ERC7546ProxyEtherscan} from "@ucs-contracts/src/proxy/ERC7546ProxyEtherscan.sol";
import {ERC7546Utils} from "@ucs-contracts/src/proxy/ERC7546Utils.sol";

import {ICloneOp} from "../interfaces/ops/ICloneOp.sol";

contract CloneOp is ICloneOp {
    /// DO NOT USE STORAGE DIRECTLY !!!

    function clone(bytes calldata initData) external returns (address proxy) {
        // proxy = ERC7546Clones.clone(ERC7546Utils.getDictionary(), initData);
        proxy = address(new ERC7546ProxyEtherscan(ERC7546Utils.getDictionary(), initData));
        emit ProxyCloned(proxy);
    }

}

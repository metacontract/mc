// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Proxy} from "@openzeppelin/contracts/proxy/Proxy.sol";
import {Op} from "dev-env/UCSDevEnv.sol";

/**
    @title Mock Proxy Contract
 */
contract SimpleMockProxy is Proxy {
    constructor (Op[] memory ops) {
        for (uint i; i < ops.length; ++i) {
            SimpleMockProxyUtils.set({
                selector: ops[i].selector,
                implementation: ops[i].implementation
            });
        }
    }

    function _implementation() internal view override returns(address) {
        return SimpleMockProxyUtils.getOp(msg.sig);
    }
}

library SimpleMockProxyUtils {
    bytes32 internal constant STORAGE_LOCATION = 0x64a9f0903a8f864d59bc40808555c0090d6ada027fd81884feeb2af9acdbc200;
    /// @custom:storage-location erc7021:ucs.mock.proxy
    struct OpsStorage {
        mapping(bytes4 selector => address) ops;
    }
    function $Storage() internal pure returns(OpsStorage storage $) { assembly { $.slot := STORAGE_LOCATION } }

    function set(bytes4 selector, address implementation) internal {
        $Storage().ops[selector] = implementation;
    }

    function getOp(bytes4 selector) internal view returns(address) {
        return $Storage().ops[selector];
    }

    // function getOpAddressLocation(bytes4 selector) internal pure returns(bytes32) {
    //     return keccak256(abi.encodePacked(bytes32(selector), bytes32(0x64a9f0903a8f864d59bc40808555c0090d6ada027fd81884feeb2af9acdbc200)));
    // }
}

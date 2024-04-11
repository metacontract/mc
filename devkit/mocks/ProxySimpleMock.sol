// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core
import {Function} from "devkit/core/types/Function.sol";
// External Lib
import {Proxy as OZProxy} from "@oz.mc/proxy/Proxy.sol";

/**
    @title Mock Proxy Contract
 */
contract ProxySimpleMock is OZProxy {
    constructor (Function[] memory functions) {
        for (uint i; i < functions.length; ++i) {
            ProxySimpleMockLib.set({
                selector: functions[i].selector,
                implementation: functions[i].implementation
            });
        }
    }

    function _implementation() internal view override returns(address) {
        return ProxySimpleMockLib.getImplementation(msg.sig);
    }
}

library ProxySimpleMockLib {
    bytes32 internal constant STORAGE_LOCATION = 0x64a9f0903a8f864d59bc40808555c0090d6ada027fd81884feeb2af9acdbc200;
    /// @custom:storage-location erc7021:mc.mock.proxy
    struct ProxySimpleMockStorage {
        mapping(bytes4 selector => address) implementations;
    }
    function Storage() internal pure returns(ProxySimpleMockStorage storage ref) { assembly { ref.slot := STORAGE_LOCATION } }

    function set(bytes4 selector, address implementation) internal {
        Storage().implementations[selector] = implementation;
    }

    function getImplementation(bytes4 selector) internal view returns(address) {
        return Storage().implementations[selector];
    }

    // function getOpAddressLocation(bytes4 selector) internal  returns(bytes32) {
    //     return keccak256(abi.encodePacked(bytes32(selector), bytes32(0x64a9f0903a8f864d59bc40808555c0090d6ada027fd81884feeb2af9acdbc200)));
    // }
}

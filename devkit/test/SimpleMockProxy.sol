// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core
import {FuncInfo} from "../core/functions/FuncInfo.sol";
// External Lib
import {Proxy as OZProxy} from "@openzeppelin/contracts/proxy/Proxy.sol";

/**
    @title Mock Proxy Contract
 */
contract SimpleMockProxy is OZProxy {
    constructor (FuncInfo[] memory functionInfos) {
        for (uint i; i < functionInfos.length; ++i) {
            SimpleMockProxyUtils.set({
                selector: functionInfos[i].selector,
                implementation: functionInfos[i].implementation
            });
        }
    }

    function _implementation() internal view override returns(address) {
        return SimpleMockProxyUtils.getImplementation(msg.sig);
    }
}

library SimpleMockProxyUtils {
    bytes32 internal constant STORAGE_LOCATION = 0x64a9f0903a8f864d59bc40808555c0090d6ada027fd81884feeb2af9acdbc200;
    /// @custom:storage-location erc7021:mc.mock.proxy
    struct SimpleMockProxyStorage {
        mapping(bytes4 selector => address) implementations;
    }
    function Storage() internal pure returns(SimpleMockProxyStorage storage ref) { assembly { ref.slot := STORAGE_LOCATION } }

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

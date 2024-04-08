// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core Types
import {Proxy} from "devkit/core/Proxy.sol";
// Methods
import {ProxyRegistryLib} from "devkit/method/core/ProxyRegistryLib.sol";


/************************
    🏠 Proxy Registry
*************************/
using ProxyRegistryLib for ProxyRegistry global;
struct ProxyRegistry {
    mapping(bytes32 nameHash => Proxy) deployed;
    mapping(bytes32 nameHash => Proxy) mocks;
    Proxy currentProxy;
}

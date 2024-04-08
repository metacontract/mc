// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core Types
import {Proxy} from "devkit/core/Proxy.sol";
// Methods
import {ProxyRegistryLib} from "devkit/method/core/ProxyRegistryLib.sol";
import {ProcessLib} from "devkit/method/debug/ProcessLib.sol";


/************************
    🏠 Proxy Registry
*************************/
struct ProxyRegistry {
    mapping(bytes32 nameHash => Proxy) deployed;
    mapping(bytes32 nameHash => Proxy) mocks;
    Proxy currentProxy;
}
using ProxyRegistryLib for ProxyRegistry global;
using ProcessLib for ProxyRegistry global;

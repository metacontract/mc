// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core Type
import {Proxy} from "devkit/core/Proxy.sol";
// Core Method
import {ProxyRegistryLib} from "devkit/method/core/ProxyRegistryLib.sol";
// Support Methods
import {ProcessLib} from "devkit/method/debug/ProcessLib.sol";
import {Inspector} from "devkit/method/inspector/Inspector.sol";


/**=======================
    📕 Proxy Registry
=========================*/
struct ProxyRegistry {
    mapping(bytes32 nameHash => Proxy) deployed;
    mapping(bytes32 nameHash => Proxy) mocks;
    Proxy currentProxy;
}
using ProxyRegistryLib for ProxyRegistry global;
//  Support Methods
using ProcessLib for ProxyRegistry global;
using Inspector for ProxyRegistry global;

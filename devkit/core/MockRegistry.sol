// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core Types
import {Proxy} from "devkit/core/Proxy.sol";
import {Dictionary} from "devkit/core/Dictionary.sol";
// Core Method
import {MockRegistryLib} from "devkit/method/core/MockRegistryLib.sol";
// Support Methods
import {ProcessLib} from "devkit/method/debug/ProcessLib.sol";
import {Inspector} from "devkit/method/inspector/Inspector.sol";


/**======================
    🏭 Mock Registry
========================*/
struct MockRegistry {
    mapping(bytes32 nameHash => Proxy) proxy;
    mapping(bytes32 nameHash => Dictionary) dictionary;
}
using MockRegistryLib for MockRegistry global;
//  Support Methods
using ProcessLib for MockRegistry global;
using Inspector for MockRegistry global;

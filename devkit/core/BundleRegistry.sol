// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core Type
import {Bundle} from "devkit/core/Bundle.sol";
//Methods
import {BundleRegistryLib} from "devkit/method/core/BundleRegistryLib.sol";
import {ProcessLib} from "devkit/method/debug/ProcessLib.sol";
import {Inspector} from "devkit/method/inspector/Inspector.sol";


/**========================
    📙 Bundle Registry
==========================*/
struct BundleRegistry {
    mapping(bytes32 nameHash => Bundle) bundles;
    string currentBundleName;
}
using BundleRegistryLib for BundleRegistry global;
//  Support Methods
using ProcessLib for BundleRegistry global;
using Inspector for BundleRegistry global;

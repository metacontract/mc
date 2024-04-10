// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core Registries
import {StdRegistry} from "devkit/core/registry/StdRegistry.sol";
import {FunctionRegistry} from "devkit/core/registry/FunctionRegistry.sol";
import {BundleRegistry} from "devkit/core/registry/BundleRegistry.sol";
import {DictionaryRegistry} from "devkit/core/registry/DictionaryRegistry.sol";
import {ProxyRegistry} from "devkit/core/registry/ProxyRegistry.sol";
import {MockRegistry} from "devkit/core/registry/MockRegistry.sol";

// Global Methods
import {MCSetupLib} from "devkit/core/method/global/MCSetupLib.sol";
import {MCBundleLib} from "devkit/core/method/global/MCBundleLib.sol";
import {MCDeployLib} from "devkit/core/method/global/MCDeployLib.sol";
import {MCFinderLib} from "devkit/core/method/global/MCFinderLib.sol";
import {MCContextLib} from "devkit/core/method/global/MCContextLib.sol";
import {MCTestLib} from "devkit/core/method/global/MCTestLib.sol";
import {MCDebugLib} from "devkit/core/method/global/MCDebugLib.sol";


/********************************
    🌟 Meta Contract DevKit
*********************************/
struct MCDevKit {
    StdRegistry std;
    FunctionRegistry functions;
    BundleRegistry bundle;
    DictionaryRegistry dictionary;
    ProxyRegistry proxy;
    MockRegistry mock;
}
using MCSetupLib for MCDevKit global;
using MCBundleLib for MCDevKit global;
using MCDeployLib for MCDevKit global;
using MCFinderLib for MCDevKit global;
using MCContextLib for MCDevKit global;
using MCTestLib for MCDevKit global;
using MCDebugLib for MCDevKit global;

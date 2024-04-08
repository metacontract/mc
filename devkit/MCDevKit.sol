// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core Registries
import {FunctionRegistry} from "devkit/core/FunctionRegistry.sol";
import {StdFunctions} from "devkit/core/StdFunctions.sol";
import {BundleRegistry} from "devkit/core/BundleRegistry.sol";
import {DictionaryRegistry} from "devkit/core/DictionaryRegistry.sol";
import {ProxyRegistry} from "devkit/core/proxy/ProxyRegistry.sol";

// Global Methods
import {MCSetupLib} from "devkit/method/MCSetupLib.sol";
import {MCBundleLib} from "devkit/method/MCBundleLib.sol";
import {MCDeployLib} from "devkit/method/MCDeployLib.sol";
import {MCFinderLib} from "devkit/method/MCFinderLib.sol";
import {MCContextLib} from "devkit/method/MCContextLib.sol";
import {MCTestLib} from "devkit/method/MCTestLib.sol";
import {MCDebugLib} from "devkit/method/MCDebugLib.sol";


/********************************
    🌟 Meta Contract DevKit
*********************************/
struct MCDevKit {
    StdFunctions std;
    FunctionRegistry functions;
    BundleRegistry bundle;
    DictionaryRegistry dictionary;
    ProxyRegistry proxy;
}
using MCSetupLib for MCDevKit global;
using MCBundleLib for MCDevKit global;
using MCDeployLib for MCDevKit global;
using MCFinderLib for MCDevKit global;
using MCContextLib for MCDevKit global;
using MCTestLib for MCDevKit global;
using MCDebugLib for MCDevKit global;

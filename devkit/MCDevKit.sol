// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Registries
import {StdRegistry} from "devkit/registry/StdRegistry.sol";
import {FunctionRegistry} from "devkit/registry/FunctionRegistry.sol";
import {BundleRegistry} from "devkit/registry/BundleRegistry.sol";
import {DictionaryRegistry} from "devkit/registry/DictionaryRegistry.sol";
import {ProxyRegistry} from "devkit/registry/ProxyRegistry.sol";

// Global Methods
import {MCSetupLib} from "devkit/utils/global/MCSetupLib.sol";
import {MCBundleLib} from "devkit/utils/global/MCBundleLib.sol";
import {MCDeployLib} from "devkit/utils/global/MCDeployLib.sol";
import {MCFinderLib} from "devkit/utils/global/MCFinderLib.sol";
import {MCContextLib} from "devkit/utils/global/MCContextLib.sol";
import {MCTestLib} from "devkit/utils/global/MCTestLib.sol";

// System
import {ProcessManager} from "devkit/system/debug/Process.sol";


/********************************
    🌟 Meta Contract DevKit
*********************************/
struct MCDevKit {
    StdRegistry std;
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
using ProcessManager for MCDevKit global;

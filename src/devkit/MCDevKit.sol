// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

// Registries
import {StdRegistry} from "@mc-devkit/registry/StdRegistry.sol";
import {FunctionRegistry} from "@mc-devkit/registry/FunctionRegistry.sol";
import {BundleRegistry} from "@mc-devkit/registry/BundleRegistry.sol";
import {DictionaryRegistry} from "@mc-devkit/registry/DictionaryRegistry.sol";
import {ProxyRegistry} from "@mc-devkit/registry/ProxyRegistry.sol";

// Global Methods
import {MCInitLib} from "@mc-devkit/utils/global/MCInitLib.sol";
import {MCDeployLib} from "@mc-devkit/utils/global/MCDeployLib.sol";
import {MCFinderLib} from "@mc-devkit/utils/global/MCFinderLib.sol";
import {MCMockLib} from "@mc-devkit/utils/global/MCMockLib.sol";
import {MCHelpers} from "@mc-devkit/utils/global/MCHelpers.sol";

// System Methods
import {Tracer} from "@mc-devkit/system/Tracer.sol";


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
using MCInitLib for MCDevKit global;
using MCDeployLib for MCDevKit global;
using MCFinderLib for MCDevKit global;
using MCMockLib for MCDevKit global;
using MCHelpers for MCDevKit global;
using Tracer for MCDevKit global;

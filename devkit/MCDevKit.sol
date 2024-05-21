// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

// Registries
import {StdRegistry} from "devkit/registry/StdRegistry.sol";
import {FunctionRegistry} from "devkit/registry/FunctionRegistry.sol";
import {BundleRegistry} from "devkit/registry/BundleRegistry.sol";
import {DictionaryRegistry} from "devkit/registry/DictionaryRegistry.sol";
import {ProxyRegistry} from "devkit/registry/ProxyRegistry.sol";

// Global Methods
import {MCInitLib} from "devkit/utils/global/MCInitLib.sol";
import {MCDeployLib} from "devkit/utils/global/MCDeployLib.sol";
import {MCFinderLib} from "devkit/utils/global/MCFinderLib.sol";
import {MCMockLib} from "devkit/utils/global/MCMockLib.sol";
import {MCHelpers} from "devkit/utils/global/MCHelpers.sol";

// System Methods
import {Tracer} from "devkit/system/Tracer.sol";


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

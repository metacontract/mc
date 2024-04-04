// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Registries
import {FuncRegistry} from "./core/functions/FuncRegistry.sol";
import {DictRegistry} from "./core/dictionary/DictRegistry.sol";
import {ProxyRegistry} from "./core/proxy/ProxyRegistry.sol";

// Core Utils
import {SetupUtils} from "./core/SetupUtils.sol";
import {BundleUtils} from "./core/BundleUtils.sol";
import {DeployUtils} from "./core/DeployUtils.sol";
import {FinderUtils} from "./core/FinderUtils.sol";
import {ContextUtils} from "./core/ContextUtils.sol";
import {TestUtils} from "./core/TestUtils.sol";
import {DebugUtils} from "./core/DebugUtils.sol";


/********************************
    🌟 Meta Contract DevKit
*********************************/
struct MCDevKit {
    FuncRegistry functions;
    DictRegistry dictionary;
    ProxyRegistry proxy;
}
using SetupUtils for MCDevKit global;
using BundleUtils for MCDevKit global;
using DeployUtils for MCDevKit global;
using FinderUtils for MCDevKit global;
using ContextUtils for MCDevKit global;
using TestUtils for MCDevKit global;
using DebugUtils for MCDevKit global;

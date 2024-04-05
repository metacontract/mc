// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Registries
import {FuncRegistry} from "./core/functions/FuncRegistry.sol";
import {DictRegistry} from "./core/dictionary/DictRegistry.sol";
import {ProxyRegistry} from "./core/proxy/ProxyRegistry.sol";

// Core Utils
import {SetupLib} from "./global/SetupLib.sol";
import {BundleLib} from "./global/BundleLib.sol";
import {DeployLib} from "./global/DeployLib.sol";
import {FinderLib} from "./global/FinderLib.sol";
import {ContextLib} from "./global/ContextLib.sol";
import {TestLib} from "./global/TestLib.sol";
import {DebugLib} from "./global/DebugLib.sol";


/********************************
    🌟 Meta Contract DevKit
*********************************/
struct MCDevKit {
    FuncRegistry functions;
    DictRegistry dictionary;
    ProxyRegistry proxy;
}
using SetupLib for MCDevKit global;
using BundleLib for MCDevKit global;
using DeployLib for MCDevKit global;
using FinderLib for MCDevKit global;
using ContextLib for MCDevKit global;
using TestLib for MCDevKit global;
using DebugLib for MCDevKit global;

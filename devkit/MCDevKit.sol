// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Registries
import {FunctionRegistry} from "devkit/ucs/functions/FunctionRegistry.sol";
import {DictionaryRegistry} from "devkit/ucs/dictionary/DictionaryRegistry.sol";
import {ProxyRegistry} from "devkit/ucs/proxy/ProxyRegistry.sol";

// Global Methods
import {SetupLib} from "devkit/global/SetupLib.sol";
import {BundleLib} from "devkit/global/BundleLib.sol";
import {DeployLib} from "devkit/global/DeployLib.sol";
import {FinderLib} from "devkit/global/FinderLib.sol";
import {ContextLib} from "devkit/global/ContextLib.sol";
import {TestLib} from "devkit/global/TestLib.sol";
import {DebugLib} from "devkit/global/DebugLib.sol";


/********************************
    🌟 Meta Contract DevKit
*********************************/
struct MCDevKit {
    FunctionRegistry functions;
    DictionaryRegistry dictionary;
    ProxyRegistry proxy;
}
using SetupLib for MCDevKit global;
using BundleLib for MCDevKit global;
using DeployLib for MCDevKit global;
using FinderLib for MCDevKit global;
using ContextLib for MCDevKit global;
using TestLib for MCDevKit global;
using DebugLib for MCDevKit global;

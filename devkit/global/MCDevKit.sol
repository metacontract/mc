// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Registries
import {FunctionRegistry} from "devkit/ucs/functions/FunctionRegistry.sol";
import {DictionaryRegistry} from "devkit/ucs/dictionary/DictionaryRegistry.sol";
import {ProxyRegistry} from "devkit/ucs/proxy/ProxyRegistry.sol";

// Global Methods
import {MCSetupLib} from "devkit/global/MCSetupLib.sol";
import {MCBundleLib} from "devkit/global/MCBundleLib.sol";
import {MCDeployLib} from "devkit/global/MCDeployLib.sol";
import {MCFinderLib} from "devkit/global/MCFinderLib.sol";
import {MCContextLib} from "devkit/global/MCContextLib.sol";
import {MCTestLib} from "devkit/global/MCTestLib.sol";
import {MCDebugLib} from "devkit/global/MCDebugLib.sol";


/********************************
    🌟 Meta Contract DevKit
*********************************/
struct MCDevKit {
    FunctionRegistry functions;
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

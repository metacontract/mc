// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Dev Utils for Environments
// 🌟 Global
import {UCSDevEnvUtils} from "./UCSDevEnvUtils.sol";
/// 🧩 Ops
import {OpsEnvUtils} from "./ops/OpsEnvUtils.sol";
import {StdOpsUtils} from "./ops/StdOpsUtils.sol";
// import CustomOpsUtils TODO
import {OpInfoUtils} from "./ops/OpInfoUtils.sol";
import {BundleOpsInfoUtils} from "./ops/BundleOpsInfoUtils.sol";
/// 📚 Dictionary
import {DictionaryUtils} from "./dictionary/DictionaryUtils.sol";
import {DictionaryEnvUtils} from "./dictionary/DictionaryEnvUtils.sol";
/// 🏠 Proxy
import {ProxyUtils} from "./proxy/ProxyUtils.sol";
import {ProxyEnvUtils} from "./proxy/ProxyEnvUtils.sol";
/// 🧪 Test
import {UCSTestEnvUtils} from "./test/UCSTestEnvUtils.sol";
import {MockProxyUtils} from "dev-env/proxy/MockProxyUtils.sol";
import {MockDictionaryUtils} from "dev-env/dictionary/MockDictionaryUtils.sol";
/// 🎭 Context
import {ContextUtils} from "./context/ContextUtils.sol";


/******************************************
🌟 UCS Development Environment for Global
*******************************************/
using UCSDevEnvUtils for UCSDevEnv global;
struct UCSDevEnv {
    /** UCS Contracts */
    UCSOpsEnv ops;
    UCSDictionaryEnv dictionary;
    UCSProxyEnv proxy;

    UCSTestEnv test;
    UCSContext context;
    // UCSDevEnvSettings settings;
}


/****************************
    🧩 UCS Ops Environment
*****************************/
using OpsEnvUtils for UCSOpsEnv global;
struct UCSOpsEnv {
    StdOps stdOps;
    CustomOps customOps;
}

    using StdOpsUtils for StdOps global;
    struct StdOps {
        OpInfo initSetAdmin;
        OpInfo getDeps;
        OpInfo clone;
        OpInfo setImplementation;
        BundleOpsInfo allStdOps;
        BundleOpsInfo defaultOps;
    }

    struct CustomOps {
        mapping(bytes32 nameHash => OpInfo) ops;
        mapping(bytes32 nameHash => BundleOpsInfo) bundles;
    }

        using OpInfoUtils for OpInfo global;
        struct OpInfo { /// @dev OpInfo may be different depending on the op version.
            string keyword;
            bytes4 selector;
            address deployedContract;
        }

        using BundleOpsInfoUtils for BundleOpsInfo global;
        struct BundleOpsInfo {
            string keyword;
            OpInfo[] opInfos;
            address facade;
        }


/************************************
    📚 UCS Dictionary Environment
*************************************/
using DictionaryEnvUtils for UCSDictionaryEnv global;
struct UCSDictionaryEnv {
    mapping(bytes32 nameHash => Dictionary) deployed;
    address upgradeableImpl;
    address upgradeableEtherscanImpl;
}
    type Dictionary is address;
    using DictionaryUtils for Dictionary global;


/*******************************
    🏠 UCS Proxy Environment
********************************/
using ProxyEnvUtils for UCSProxyEnv global;
struct UCSProxyEnv {
    mapping(bytes32 nameHash => Proxy) deployed;
}
    type Proxy is address;
    using ProxyUtils for Proxy global;
    using {ProxyUtils.asProxy} for address;


/******************************
    🧪 UCS Test Environment
*******************************/
using UCSTestEnvUtils for UCSTestEnv global;
struct UCSTestEnv {
    mapping(bytes32 nameHash => MockProxy) mockProxies;
    mapping(bytes32 nameHash => MockDictionary) mockDictionaries;
    // mapping(bytes32 nameHash => uint256) namedMockProxyIndicesPlusOne; /// @dev To avoid retrieving a default zero value, we store values that are one greater than the actual index.
    // MockProxy[] mockProxies;
    // stubs TODO
}
    // Define Mock Proxy
    type MockProxy is address;
    using MockProxyUtils for MockProxy global;
    // Define Mock Dictionary
    type MockDictionary is address;
    using MockDictionaryUtils for MockDictionary global;


/*****************************
    🎭 UCS DevEnv Context
******************************/
using ContextUtils for UCSContext global;
struct UCSContext {
    Proxy currentProxy;
    Dictionary currentDictionary;
}


/***********************
    📝 UCS Settings
************************/
/// @dev We will utilize this struct after Solidity is updated to allow Structs to be applied to Transient Storage.
// struct UCSDevEnvSettings {
//     bool outputLogs;
// }


/****************************
    🎨 General UCS Types
*****************************/
struct Op {
    bytes4 selector;
    address implementation;
}

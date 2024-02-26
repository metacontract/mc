// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Commons
import {DevUtils} from "./common/DevUtils.sol";
import {ForgeHelper, vm, console2} from "./common/ForgeHelper.sol";

// Dev Environment
/// for General
import {UCSDevEnvUtils} from "./UCSDevEnvUtils.sol";
/// for Ops
import {OpsEnvUtils} from "./ops/OpsEnvUtils.sol";
import {StdOpsUtils} from "./ops/StdOpsUtils.sol";
import {OpInfoUtils} from "./ops/OpInfoUtils.sol";
import {BundleOpsInfoUtils} from "./ops/BundleOpsInfoUtils.sol";
/// for Dictionary
import {DictionaryUtils} from "./dictionary/DictionaryUtils.sol";
import {DictionaryEnvUtils} from "./dictionary/DictionaryEnvUtils.sol";
/// for Proxy
import {ProxyUtils} from "./proxy/ProxyUtils.sol";
import {ProxyEnvUtils} from "./proxy/ProxyEnvUtils.sol";
/// for Testing
import {UCSTestEnvUtils} from "./test/UCSTestEnvUtils.sol";
import {MockUtils} from "./test/MockUtils.sol";
/// for Context
import {ContextUtils} from "./context/ContextUtils.sol";


using UCSDevEnvUtils for UCSDevEnv global;
struct UCSDevEnv {
    /** Depenedent Contracts */
    UCSOpsEnv ops;
    UCSDictionaryEnv dictionary;
    UCSProxyEnv proxy;

    /** Environment */
    UCSTestEnv test;
    UCSContext context;
    // UCSDevEnvSettings settings;
}


/**********************************
    🧩 Utils for Ops
 */
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

        struct Op {
            bytes4 selector;
            address implementation;
        }


/**********************************
    📚 Utils for Dictionary
 */
using DictionaryEnvUtils for UCSDictionaryEnv global;
struct UCSDictionaryEnv {
    mapping(bytes32 nameHash => Dictionary) deployed;
    address upgradeableImpl;
    address upgradeableEtherscanImpl;
}
    using DictionaryUtils for Dictionary global;
    type Dictionary is address;


/**********************************
    🏠 Utils for Proxy
 */
using ProxyEnvUtils for UCSProxyEnv global;
struct UCSProxyEnv {
    mapping(bytes32 nameHash => Proxy) deployed;
}
    type Proxy is address;
    using ProxyUtils for Proxy global;
    using {ProxyUtils.asProxy} for address;


/**********************************
    🧪 Utils for Testing
 */
using UCSTestEnvUtils for UCSTestEnv global;
struct UCSTestEnv {
    mapping(bytes32 nameHash => MockProxy) mockProxies;
    // mapping(bytes32 nameHash => uint256) namedMockProxyIndicesPlusOne; /// @dev To avoid retrieving a default zero value, we store values that are one greater than the actual index.
    // MockProxy[] mockProxies;
    // stubs TODO
}
    // Define Mock Proxy
    type MockProxy is address;
    using MockUtils for MockProxy global;
    using {MockUtils.asMockProxy} for address;
    // Define Mock Dictionary
    type MockDictionary is address;
    using MockUtils for MockDictionary global;
    using {MockUtils.asMockDictionary} for address;


/**********************************
    🎭 Utils for Context
 */
using ContextUtils for UCSContext global;
struct UCSContext {
    Proxy currentProxy;
    Dictionary currentDictionary;
}


/**********************************
    ⚙ Utils for Settings
 */
/// @dev We will utilize this struct after Solidity is updated to allow Structs to be applied to Transient Storage.
// struct UCSDevEnvSettings {
//     bool outputLogs;
// }

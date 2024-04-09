// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {validate} from "devkit/error/Validate.sol";
import {Require} from "devkit/error/Require.sol";
import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;
import {AddressUtils} from "devkit/utils/AddressUtils.sol";
    using AddressUtils for address;
import {BoolUtils} from "devkit/utils/BoolUtils.sol";
    using BoolUtils for bool;
import {Bytes4Utils} from "devkit/utils/Bytes4Utils.sol";
    using Bytes4Utils for bytes4;
import {ForgeHelper} from "devkit/utils/ForgeHelper.sol";
// External Library
import {IBeacon} from "@oz.mc/proxy/beacon/IBeacon.sol";
import {IDictionary} from "@ucs.mc/dictionary/IDictionary.sol";
// Core Types
import {Function} from "devkit/core/Function.sol";
import {Bundle} from "devkit/core/Bundle.sol";
import {BundleRegistry} from "devkit/core/BundleRegistry.sol";
import {Proxy, ProxyKind} from "devkit/core/Proxy.sol";
import {ProxyRegistry} from "devkit/core/ProxyRegistry.sol";
import {Dictionary, DictionaryKind} from "devkit/core/Dictionary.sol";
import {DictionaryRegistry} from "devkit/core/DictionaryRegistry.sol";


/**-------------------------------
    🧐 Inspectors & Assertions
---------------------------------*/
library Inspector {
    /**==================
        🧩 Function
    ====================*/
    function exists(Function memory func) internal returns(bool) {
        return func.implementation.isContract();
    }

    function assignLabel(Function storage func) internal returns(Function storage) {
        if (func.exists()) {
            ForgeHelper.assignLabel(func.implementation, func.name);
        }
        return func;
    }

    function notExists(Function storage func) internal returns(bool) {
        return func.exists().isFalse();
    }

    function assertExists(Function storage func) internal returns(Function storage) {
        validate(func.exists(), "func does not exists");
        return func;
    }

    function assertEmptyName(Function storage func) internal returns(Function storage) {
        Require.isUnassigned(func.name);
        return func;
    }
    function assertEmptySelector(Function storage func) internal returns(Function storage) {
        Require.isUnassigned(func.selector);
        return func;
    }
    function assertEmptyImpl(Function storage func) internal returns(Function storage) {
        validate(func.implementation.isNotContract(), "Implementation Already Exist");
        return func;
    }

    function assertNotEmpty(Function storage func) internal returns(Function storage) {
        validate(func.exists(), "Empty Deployed Contract");
        return func;
    }

    function assertNotIncludedIn(Function storage func, Bundle storage bundleInfo) internal returns(Function storage) {
        validate(bundleInfo.hasNot(func), "Already exists in the Bundel");
        return func;
    }

    function assertImplIsContract(Function storage func) internal returns(Function storage) {
        validate(func.implementation.isContract(), "Implementation Not Contract");
        return func;
    }

    function isComplete(Function storage func) internal returns(bool) {
        return  func.name.isNotEmpty() &&
                func.selector.isNotEmpty() &&
                func.implementation.isContract();
    }
    function assertComplete(Function storage func) internal returns(Function storage) {
        validate(func.isComplete(), "Function Info Not Complete");
        return func;
    }

    function isEqual(Function memory a, Function memory b) internal pure returns(bool) {
        return keccak256(abi.encode(a)) == keccak256(abi.encode(b));
    }


    /**===============
        🗂️ Bundle
    =================*/
    function has(Bundle storage bundle, Function storage functionInfo) internal view returns(bool flag) {
        for (uint i; i < bundle.functions.length; ++i) {
            if (functionInfo.isEqual(bundle.functions[i])) return true;
        }
    }
    function hasNot(Bundle storage bundle, Function storage functionInfo) internal returns(bool) {
        return bundle.has(functionInfo).isFalse();
    }

    function isComplete(Bundle storage bundle) internal returns(bool) {
        return  bundle.name.isNotEmpty() &&
                bundle.functions.length != 0 &&
                bundle.facade.isContract();
    }
    function assertComplete(Bundle storage bundle) internal returns(Bundle storage) {
        validate(bundle.isComplete(), "Bundle Info Not Complete", bundle.parse());
        return bundle;
    }

    function hasName(Bundle storage bundle) internal returns(bool) {
        return bundle.name.isNotEmpty();
    }
    function hasNotName(Bundle storage bundle) internal returns(bool) {
        return bundle.name.isEmpty();
    }

    function exists(Bundle storage bundle) internal returns(bool) {
        return  bundle.name.isNotEmpty() ||
                bundle.functions.length != 0 ||
                bundle.facade.isNotContract();
    }
    function notExists(Bundle storage bundle) internal returns(bool) {
        return bundle.exists().isNot();
    }
    function assertExists(Bundle storage bundle) internal returns(Bundle storage) {
        validate(bundle.exists(), "Bundle Info Not Exists");
        return bundle;
    }
    function assertNotExists(Bundle storage bundle) internal returns(Bundle storage) {
        validate(bundle.notExists(), "Bundle Info Already Exists");
        return bundle;
    }


    /**=======================
        🗂️ Bundle Registry
    =========================*/
    function existsBundle(BundleRegistry storage bundle, string memory name) internal returns(bool) {
        return bundle.bundles[name].hasName();
    }
    function notExistsBundle(BundleRegistry storage bundle, string memory name) internal returns(bool) {
        return bundle.existsBundle(name).isNot();
    }
    function assertBundleNotExists(BundleRegistry storage bundle, string memory name) internal returns(BundleRegistry storage) {
        validate(bundle.notExistsBundle(name), "Bundle Already Exists");
        return bundle;
    }

    function existsCurrentBundle(BundleRegistry storage bundle) internal returns(bool) {
        return bundle.currentBundleName.isNotEmpty();
    }
    function notExistsCurrentBundle(BundleRegistry storage bundle) internal returns(bool) {
        return bundle.existsCurrentBundle().isNot();
    }


    /**==============
        🏠 Proxy
    ================*/
    function exists(Proxy storage proxy) internal returns(bool) {
        return proxy.addr.isContract();
    }
    function assertExists(Proxy storage proxy) internal returns(Proxy storage) {
        validate(proxy.exists(), "Proxy Not Exist");
        return proxy;
    }

    function notExists(Proxy storage proxy) internal returns(bool) {
        return proxy.exists().isFalse();
    }

    function isNotEmpty(Proxy memory proxy) internal returns(bool) {
        return proxy.addr.isContract();
    }
    function assertNotEmpty(Proxy memory proxy) internal returns(Proxy memory) {
        validate(proxy.isNotEmpty(), "Empty Proxy");
        return proxy;
    }

    function isMock(Proxy memory proxy) internal pure returns(bool) {
        return proxy.kind == ProxyKind.Mock;
    }
    function isNotMock(Proxy memory proxy) internal returns(bool) {
        return proxy.isMock().isNot();
    }

    function assignLabel(Proxy storage proxy, string memory name) internal returns(Proxy storage) {
        ForgeHelper.assignLabel(proxy.addr, name);
        return proxy;
    }

    /**~~~~~~~~~~~~~~~~~~~
        🏠 Proxy Kind
    ~~~~~~~~~~~~~~~~~~~~~*/
    function isNotUndefined(ProxyKind kind) internal pure returns(bool) {
        return kind != ProxyKind.undefined;
    }
    function assertNotUndefined(ProxyKind kind) internal returns(ProxyKind) {
        validate(kind.isNotUndefined(), "Undefined Proxy Kind");
        return kind;
    }

    /**=======================
        🏠 Proxy Registry
    =========================*/
    function existsInDeployed(ProxyRegistry storage proxies, string memory name) internal returns(bool) {
        return proxies.deployed[name].exists();
    }
    // function existsInMocks(ProxyRegistry storage proxies, string memory name) internal returns(bool) {
    //     return proxies.mocks[name].exists();
    // }


    /**====================
        📚 Dictionary
    ======================*/
    function exists(Dictionary storage dictionary) internal returns(bool) {
        return dictionary.addr.isContract();
    }
    function assertExists(Dictionary storage dictionary) internal returns(Dictionary storage) {
        validate(dictionary.exists(), "Dictionary Not Exists");
        return dictionary;
    }

    function notExists(Dictionary storage dictionary) internal returns(bool) {
        return dictionary.exists().isFalse();
    }

    function isNotEmpty(Dictionary memory dictionary) internal returns(bool) {
        return dictionary.addr.isContract();
    }
    function assertNotEmpty(Dictionary memory dictionary) internal returns(Dictionary memory) {
        validate(dictionary.isNotEmpty(), "Empty Dictionary");
        return dictionary;
    }

    function isSupported(Dictionary memory dictionary, bytes4 selector) internal view returns(bool) {
        return IDictionary(dictionary.addr).supportsInterface(selector);
    }
    function assertSupports(Dictionary storage dictionary, bytes4 selector) internal returns(Dictionary storage) {
        validate(dictionary.isSupported(selector), "Unsupported Selector");
        return dictionary;
    }

    function isVerifiable(Dictionary memory dictionary) internal returns(bool) {
        (bool success,) = dictionary.addr.call(abi.encodeWithSelector(IBeacon.implementation.selector));
        return success;
    }
    function assertVerifiable(Dictionary memory dictionary) internal returns(Dictionary memory) {
        validate(dictionary.isVerifiable(), "Dictionary Not Verifiable");
        return dictionary;
    }

    function isMock(Dictionary memory dictionary) internal pure returns(bool) {
        return dictionary.kind == DictionaryKind.Mock;
    }
    function isNotMock(Dictionary memory dictionary) internal returns(bool) {
        return dictionary.isMock().isNot();
    }
    // function isUUPS(Dictionary dictionary) internal returns(bool) {
    //     return UUPSUpgradeable(dictionary.toAddress()).proxiableUUID() == ERC1967Utils.IMPLEMENTATION_SLOT;
    // }

    /**------------------------
        📚 Dictionary Kind
    --------------------------*/
    function isNotUndefined(DictionaryKind kind) internal pure returns(bool) {
        return kind != DictionaryKind.undefined;
    }
    function assertNotUndefined(DictionaryKind kind) internal returns(DictionaryKind) {
        validate(kind.isNotUndefined(), "Undefined Dictionary Kind");
        return kind;
    }

    /**============================
        📚 Dictionary Registry
    ==============================*/
    function existsInDeployed(DictionaryRegistry storage dictionaries, string memory name) internal returns(bool) {
        return dictionaries.deployed[name].exists();
    }
    // function existsInMocks(DictionaryRegistry storage dictionaries, string memory name) internal returns(bool) {
    //     return dictionaries.mocks[name].exists();
    // }
}

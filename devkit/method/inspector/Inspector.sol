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


/**--------------------
    🧐 Inspectors
----------------------*/
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

    function isComplete(Function storage func) internal returns(bool) {
        return  func.name.isNotEmpty() &&
                func.selector.isNotEmpty() &&
                func.implementation.isContract();
        // return func.buildStatus == BuildStatus.Built;
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


    /**=======================
        📙 Bundle Registry
    =========================*/
    function existsBundle(BundleRegistry storage bundle, string memory name) internal returns(bool) {
        return bundle.bundles[name].hasName();
    }
    function notExistsBundle(BundleRegistry storage bundle, string memory name) internal returns(bool) {
        return bundle.existsBundle(name).isNot();
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

    function notExists(Proxy storage proxy) internal returns(bool) {
        return proxy.exists().isFalse();
    }

    function isNotEmpty(Proxy memory proxy) internal returns(bool) {
        return proxy.addr.isContract();
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

    function notExists(Dictionary storage dictionary) internal returns(bool) {
        return dictionary.exists().isFalse();
    }

    function isNotEmpty(Dictionary memory dictionary) internal returns(bool) {
        return dictionary.addr.isContract();
    }

    function isSupported(Dictionary memory dictionary, bytes4 selector) internal view returns(bool) {
        return IDictionary(dictionary.addr).supportsInterface(selector);
    }

    function isVerifiable(Dictionary memory dictionary) internal returns(bool) {
        (bool success,) = dictionary.addr.call(abi.encodeWithSelector(IBeacon.implementation.selector));
        return success;
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

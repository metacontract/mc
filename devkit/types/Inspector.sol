// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Validate} from "devkit/system/Validate.sol";
import {Inspector} from "devkit/types/Inspector.sol";
    using Inspector for bool;
import {ForgeHelper} from "devkit/utils/ForgeHelper.sol";
// External Library
import {IDictionary} from "@ucs.mc/dictionary/IDictionary.sol";
import {IBeacon as IVerifiable} from "@oz.mc/proxy/beacon/IBeacon.sol";
// Core Types
import {Function} from "devkit/core/Function.sol";
import {Bundle} from "devkit/core/Bundle.sol";
import {BundleRegistry} from "devkit/registry/BundleRegistry.sol";
import {Proxy, ProxyKind} from "devkit/core/Proxy.sol";
import {ProxyRegistry} from "devkit/registry/ProxyRegistry.sol";
import {Dictionary, DictionaryKind} from "devkit/core/Dictionary.sol";
import {DictionaryRegistry} from "devkit/registry/DictionaryRegistry.sol";


/**--------------------
    🧐 Inspectors
----------------------*/
library Inspector {
    using Inspector for string;
    using Inspector for bytes4;
    using Inspector for address;

    /**==================
        🧩 Function
    ====================*/
    function hasNotContract(Function storage func) internal returns(bool) {
        return func.implementation.isNotContract();
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
    function hasName(Bundle storage bundle) internal returns(bool) {
        return bundle.name.isNotEmpty();
    }
    function hasNotName(Bundle storage bundle) internal returns(bool) {
        return bundle.name.isEmpty();
    }
    /**=======================
        📙 Bundle Registry
    =========================*/
    function existsCurrentBundle(BundleRegistry storage bundle) internal returns(bool) {
        return bundle.current.name.isNotEmpty();
    }
    function notExistsCurrentBundle(BundleRegistry storage bundle) internal returns(bool) {
        return bundle.existsCurrentBundle().isNot();
    }

    /**==============
        🏠 Proxy
    ================*/
    /**~~~~~~~~~~~~~~~~~~~
        🏠 Proxy Kind
    ~~~~~~~~~~~~~~~~~~~~~*/
    function isNotUndefined(ProxyKind kind) internal pure returns(bool) {
        return kind != ProxyKind.undefined;
    }
    /**=======================
        🏠 Proxy Registry
    =========================*/
    function existsInDeployed(ProxyRegistry storage registry, string memory name) internal returns(bool) {
        return registry.proxies[name].isInitialized();
    }
    // function existsInMocks(ProxyRegistry storage registry, string memory name) internal returns(bool) {
    //     return registry.mocks[name].exists();
    // }


    /**====================
        📚 Dictionary
    ======================*/
    function isSupported(Dictionary memory dictionary, bytes4 selector) internal view returns(bool) {
        return IDictionary(dictionary.addr).supportsInterface(selector);
    }
    function isVerifiable(Dictionary memory dictionary) internal returns(bool) {
        (bool success,) = dictionary.addr.call(abi.encodeWithSelector(IVerifiable.implementation.selector));
        return success;
    }
    /**------------------------
        📚 Dictionary Kind
    --------------------------*/
    function isNotUndefined(DictionaryKind kind) internal pure returns(bool) {
        return kind != DictionaryKind.undefined;
    }
    /**============================
        📚 Dictionary Registry
    ==============================*/
    function existsInDeployed(DictionaryRegistry storage registry, string memory name) internal returns(bool) {
        return registry.dictionaries[name].isComplete();
    }
    // function existsInMocks(DictionaryRegistry storage dictionaries, string memory name) internal returns(bool) {
    //     return dictionaries.mocks[name].exists();
    // }


    /**===================
        🧱 Primitives
    =====================*/
    /// 📝 String
    function isAssigned(string storage str) internal returns(bool) {
        return str.isNotEmpty();
    }
    function isEmpty(string memory str) internal returns(bool) {
        return bytes(str).length == 0;
    }
    function isNotEmpty(string memory str) internal returns(bool) {
        return str.isEmpty().isNot();
    }
    function isEqual(string memory a, string memory b) internal returns(bool) {
        return keccak256(abi.encode(a)) == keccak256(abi.encode(b));
    }
    function isNotEqual(string memory a, string memory b) internal returns(bool) {
        return a.isEqual(b).isNot();
    }
    /// 💾 Bytes4
    function isAssigned(bytes4 selector) internal pure returns(bool) {
        return selector.isNotEmpty();
    }
    function isEmpty(bytes4 selector) internal pure returns(bool) {
        return selector == bytes4(0);
    }
    function isNotEmpty(bytes4 selector) internal pure returns(bool) {
        return selector.isEmpty().isFalse();
    }
    function isEqual(bytes4 a, bytes4 b) internal pure returns(bool) {
        return a == b;
    }
    function isNotEqual(bytes4 a, bytes4 b) internal pure returns(bool) {
        return a.isEqual(b).isFalse();
    }
    /// 📌 Address
    function isZero(address addr) internal returns(bool) {
        return addr == address(0);
    }
    function isNotZero(address addr) internal returns(bool) {
        return addr.isZero().isNot();
    }
    function hasCode(address addr) internal returns(bool) {
        return addr.code.length != 0;
    }
    function hasNotCode(address addr) internal returns(bool) {
        return addr.hasCode().isNot();
    }
    function isContract(address addr) internal returns(bool) {
        return addr.hasCode();
    }
    function isNotContract(address addr) internal returns(bool) {
        return addr.isContract().isNot();
    }
    /// ✅ Bool
    function isNot(bool flag) internal pure returns(bool) {
        return !flag;
    }
    function isFalse(bool flag) internal pure returns(bool) {
        return flag == false;
    }
    /// #️⃣ Uint
    function isNotZero(uint256 num) internal pure returns(bool) {
        return num != 0;
    }

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Validator} from "devkit/system/Validator.sol";
import {Inspector} from "devkit/types/Inspector.sol";
import {TypeStatus} from "devkit/types/TypeGuard.sol";
import {ForgeHelper} from "devkit/utils/ForgeHelper.sol";
// External Library
import {IDictionary} from "@ucs.mc/dictionary/interfaces/IDictionary.sol";
import {IBeacon as IVerifiable} from "@oz.mc/proxy/beacon/IBeacon.sol";
// Core Types
import {Function} from "devkit/core/Function.sol";
import {Bundle} from "devkit/core/Bundle.sol";
import {BundleRegistry} from "devkit/registry/BundleRegistry.sol";
import {Proxy, ProxyKind} from "devkit/core/Proxy.sol";
import {ProxyRegistry} from "devkit/registry/ProxyRegistry.sol";
import {Dictionary, DictionaryKind} from "devkit/core/Dictionary.sol";
import {DictionaryRegistry} from "devkit/registry/DictionaryRegistry.sol";

/**===================
    🕵️‍♀️ Inspector
=====================*/
library Inspector {
    using Inspector for string;
    using Inspector for bytes4;
    using Inspector for address;
    using Inspector for bool;

    /**==================
        🧩 Function
    ====================*/
    function hasNotContract(Function storage func) internal view returns(bool) {
        return func.implementation.isNotContract();
    }
    function isEqual(Function memory a, Function memory b) internal pure returns(bool) {
        return keccak256(abi.encode(a)) == keccak256(abi.encode(b));
    }
    function isComplete(Function memory func) internal pure returns(bool) {
        return func.status.isComplete();
    }
    function isUninitialized(Function storage func) internal view returns(bool) {
        return func.status.isUninitialized();
    }

    /**===============
        🗂️ Bundle
    =================*/
    function hasSameSelector(Bundle storage bundle, Function storage func) internal view returns(bool flag) {
        for (uint i; i < bundle.functions.length; ++i) {
            if (func.selector == bundle.functions[i].selector) return true;
        }
    }
    function hasNotSameSelector(Bundle storage bundle, Function storage func) internal view returns(bool) {
        return hasSameSelector(bundle, func).isFalse();
    }
    function isComplete(Bundle storage bundle) internal view returns(bool) {
        return bundle.status.isComplete();
    }
    function isUninitialized(Bundle storage bundle) internal view returns(bool) {
        return bundle.status.isUninitialized();
    }
    /**=======================
        📙 Bundle Registry
    =========================*/
    function hasCurrentBundle(BundleRegistry storage bundle) internal view returns(bool) {
        return bundle.current.name.isNotEmpty();
    }
    function hasNotCurrentBundle(BundleRegistry storage bundle) internal view returns(bool) {
        return bundle.hasCurrentBundle().isNot();
    }

    /**==============
        🏠 Proxy
    ================*/
    function isComplete(Proxy memory proxy) internal pure returns(bool) {
        return proxy.status.isComplete();
    }
    function isInitialized(Proxy storage proxy) internal view returns(bool) {
        return proxy.status.isInitialized();
    }
    function isUninitialized(Proxy storage proxy) internal view returns(bool) {
        return proxy.status.isUninitialized();
    }
    /**~~~~~~~~~~~~~~~~~~~
        🏠 Proxy Kind
    ~~~~~~~~~~~~~~~~~~~~~*/
    function isNotUndefined(ProxyKind kind) internal pure returns(bool) {
        return kind != ProxyKind.undefined;
    }


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
    function isComplete(Dictionary memory dictionary) internal pure returns(bool) {
        return dictionary.status.isComplete();
    }
    function isUninitialized(Dictionary storage dictionary) internal view returns(bool) {
        return dictionary.status.isUninitialized();
    }
    /**------------------------
        📚 Dictionary Kind
    --------------------------*/
    function isNotUndefined(DictionaryKind kind) internal pure returns(bool) {
        return kind != DictionaryKind.undefined;
    }


    /**===================
        🧱 Primitives
    =====================*/
    /// 📝 String
    function isAssigned(string storage str) internal pure returns(bool) {
        return str.isNotEmpty();
    }
    function isEmpty(string memory str) internal pure returns(bool) {
        return bytes(str).length == 0;
    }
    function isNotEmpty(string memory str) internal pure returns(bool) {
        return str.isEmpty().isNot();
    }
    function isEqual(string memory a, string memory b) internal pure returns(bool) {
        return keccak256(abi.encode(a)) == keccak256(abi.encode(b));
    }
    function isNotEqual(string memory a, string memory b) internal pure returns(bool) {
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
    function isZero(address addr) internal pure returns(bool) {
        return addr == address(0);
    }
    function isNotZero(address addr) internal pure returns(bool) {
        return addr.isZero().isNot();
    }
    function hasCode(address addr) internal view returns(bool) {
        return addr.code.length != 0;
    }
    function hasNotCode(address addr) internal view returns(bool) {
        return addr.hasCode().isNot();
    }
    function isContract(address addr) internal view returns(bool) {
        return addr.hasCode();
    }
    function isNotContract(address addr) internal view returns(bool) {
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

    /**===================
        🔒 Type Guard
    =====================*/
    function isUninitialized(TypeStatus status) internal pure returns(bool) {
        return status == TypeStatus.Uninitialized;
    }
    function isInitialized(TypeStatus status) internal pure returns(bool) {
        return status != TypeStatus.Uninitialized;
    }
    function isBuilding(TypeStatus status) internal pure returns(bool) {
        return status == TypeStatus.Building;
    }
    function isBuilt(TypeStatus status) internal pure returns(bool) {
        return status == TypeStatus.Built;
    }
    function isLocked(TypeStatus status) internal pure returns(bool) {
        return status == TypeStatus.Locked;
    }
    function isNotLocked(TypeStatus status) internal pure returns(bool) {
        return status.isLocked().isNot();
    }
    function isComplete(TypeStatus status) internal pure returns(bool) {
        return status.isBuilt() || status.isLocked();
    }

}

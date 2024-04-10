// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {throwError, ERR} from "devkit/error/Error.sol";
import {validate} from "devkit/error/Validate.sol";
// Utils
import {BoolUtils} from "devkit/utils/BoolUtils.sol";
    using BoolUtils for bool;
import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;
import {Bytes4Utils} from "devkit/utils/Bytes4Utils.sol";
    using Bytes4Utils for bytes4;
import {AddressUtils} from "devkit/utils/AddressUtils.sol";
    using AddressUtils for address;
import {UintUtils} from "devkit/utils/UintUtils.sol";
    using UintUtils for uint256;
import {TypeGuard, TypeStatus} from "devkit/core/types/TypeGuard.sol";
// Core Types
import {Function} from "devkit/core/types/Function.sol";
import {Bundle} from "devkit/core/types/Bundle.sol";
import {BundleRegistry} from "devkit/core/registry/BundleRegistry.sol";
import {Proxy, ProxyKind} from "devkit/core/types/Proxy.sol";
import {ProxyRegistry} from "devkit/core/registry/ProxyRegistry.sol";
import {Dictionary, DictionaryKind} from "devkit/core/types/Dictionary.sol";
import {DictionaryRegistry} from "devkit/core/registry/DictionaryRegistry.sol";
import {StdRegistry} from "devkit/core/registry/StdRegistry.sol";
import {StdFunctions} from "devkit/core/registry/StdFunctions.sol";
import {StdBundle} from "devkit/core/registry/StdBundle.sol";


library Require {
    /**
        Type Guard
     */
    function isBuilt(TypeStatus status) internal {
        validate(status.isBuilt(), "Not Built Yet");
    }

    function notZero(uint256 num) internal {
        validate(num.isNotZero(), "Zero Number");
    }

    function assigned(string memory str) internal {
        validate(str.isNotEmpty(), "Not Assigned");
    }

    /**==================
        🧩 Function
    ====================*/
    function exists(Function storage func) internal {
        validate(func.exists(), "func does not exists");
        // validate(func.isBuilt(), "func does not exists"); // TODO
    }

    function EmptyName(Function storage func) internal {
        Require.isUnassigned(func.name);
    }
    function EmptySelector(Function storage func) internal {
        Require.isUnassigned(func.selector);
    }
    function EmptyImpl(Function storage func) internal {
        validate(func.implementation.isNotContract(), "Implementation Already Exist");
    }

    function NotEmpty(Function storage func) internal {
        validate(func.exists(), "Empty Deployed Contract");
    }

    function NotIncludedIn(Function storage func, Bundle storage bundleInfo) internal {
        validate(bundleInfo.hasNot(func), "Already exists in the Bundel");
    }

    function implIsContract(Function storage func) internal {
        validate(func.implementation.isContract(), "Implementation Not Contract");
    }
    function isComplete(Function storage func) internal {
        validate(func.isComplete(), "Function Not Complete");
    }


    /**===============
        🗂️ Bundle
    =================*/
    function isComplete(Bundle storage bundle) internal returns(Bundle storage) {
        validate(bundle.isComplete(), "Bundle Info Not Complete", bundle.parse());
        return bundle;
    }
    function exists(Bundle storage bundle) internal returns(Bundle storage) {
        validate(bundle.exists(), "Bundle Info Not Exists");
        return bundle;
    }
    function notExists(Bundle storage bundle) internal returns(Bundle storage) {
        validate(bundle.notExists(), "Bundle Already Exists");
        return bundle;
    }
    function isUnassigned(Bundle storage bundle) internal {
        validate(bundle.hasNotName(), "Bundle Already Assigned.");
    }
    function hasNot(Bundle storage bundle, Function storage func) internal {
        validate(bundle.hasNot(func), "Bundle has same Function");
    }

    /**=======================
        📙 Bundle Registry
    =========================*/
    function bundleNotExists(BundleRegistry storage bundle, string memory name) internal returns(BundleRegistry storage) {
        validate(bundle.notExistsBundle(name), "Bundle Already Exists");
        return bundle;
    }

    /**==============
        🏠 Proxy
    ================*/
    function exists(Proxy storage proxy) internal returns(Proxy storage) {
        validate(proxy.exists(), "Proxy Not Exist");
        return proxy;
    }
    function notEmpty(Proxy memory proxy) internal returns(Proxy memory) {
        validate(proxy.isNotEmpty(), "Empty Proxy");
        return proxy;
    }
    /*---- Proxy Kind -----*/
    function NotUndefined(ProxyKind kind) internal returns(ProxyKind) {
        validate(kind.isNotUndefined(), "Undefined Proxy Kind");
        return kind;
    }

    /**====================
        📚 Dictionary
    ======================*/
    function exists(Dictionary storage dictionary) internal returns(Dictionary storage) {
        validate(dictionary.exists(), "Dictionary Not Exists");
        return dictionary;
    }
    function notEmpty(Dictionary memory dictionary) internal returns(Dictionary memory) {
        validate(dictionary.isNotEmpty(), "Empty Dictionary");
        return dictionary;
    }
    function Supports(Dictionary storage dictionary, bytes4 selector) internal returns(Dictionary storage) {
        validate(dictionary.isSupported(selector), "Unsupported Selector");
        return dictionary;
    }
    function verifiable(Dictionary memory dictionary) internal returns(Dictionary memory) {
        validate(dictionary.isVerifiable(), "Dictionary Not Verifiable");
        return dictionary;
    }
    /*---- Dictionary Kind -----*/
    function NotUndefined(DictionaryKind kind) internal returns(DictionaryKind) {
        validate(kind.isNotUndefined(), "Undefined Dictionary Kind");
        return kind;
    }


    function isUnassigned(string storage str) internal {
        validate(str.isEmpty(), ERR.STR_ALREADY_ASSIGNED);
    }
    function notEmpty(string memory str) internal {
        validate(str.isNotEmpty(), ERR.EMPTY_STR);
    }

    function isUnassigned(bytes4 b4) internal {
        validate(b4.isEmpty(), ERR.B4_ALREADY_ASSIGNED);
    }
    function isNotEmpty(bytes4 b4) internal {
        validate(b4.isNotEmpty(), ERR.EMPTY_B4);
    }

    function isContract(address addr) internal {
        validate(addr.isContract(), ERR.NOT_CONTRACT);
    }

    function notEmptyString(string memory str) internal {
        validate(str.isNotEmpty(), ERR.RQ_NOT_EMPTY_STRING);
    }

    function assigned(bytes4 b4) internal {
        validate(b4.isNotEmpty(), ERR.RQ_SELECTOR);
    }
    function contractAssigned(address addr) internal {
        validate(addr.isContract(), ERR.RQ_CONTRACT);
    }

    function notLocked(TypeStatus status) internal {
        validate(status != TypeStatus.Locked, ERR.LOCKED_OBJECT);
    }

    function isNotEmpty(Dictionary memory dictionary) internal {
        validate(dictionary.isNotEmpty(), ERR.EMPTY_DICTIONARY);
    }

    function isNotZero(address addr) internal {
        validate(addr.isNotZero(), ERR.ZERO_ADDRESS);
    }


    /**==========================
        🏛 Standard Registry
    ============================*/
    function isComplete(StdRegistry storage registry) internal {
        validate(registry.status.isComplete(), "Registry Not Complete");
    }
    function isComplete(StdFunctions storage stdFunctions) internal {
        validate(stdFunctions.status.isComplete(), "Registry Not Complete");
    }
    function isComplete(StdBundle storage stdBundle) internal {
        validate(stdBundle.status.isComplete(), "Registry Not Complete");
    }
}

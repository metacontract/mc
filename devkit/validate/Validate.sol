// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {throwError} from "devkit/log/error/ThrowError.sol";
import {ERR} from "devkit/log/message/ERR.sol";
import {Debug, LogLevel} from "devkit/log/debug/Debug.sol";
import {Logger} from "devkit/log/debug/Logger.sol";
// Utils
import {BoolUtils} from "devkit/utils/primitive/BoolUtils.sol";
    using BoolUtils for bool;
import {StringUtils} from "devkit/utils/primitive/StringUtils.sol";
    using StringUtils for string;
import {Bytes4Utils} from "devkit/utils/primitive/Bytes4Utils.sol";
    using Bytes4Utils for bytes4;
import {AddressUtils} from "devkit/utils/primitive/AddressUtils.sol";
    using AddressUtils for address;
import {UintUtils} from "devkit/utils/primitive/UintUtils.sol";
    using UintUtils for uint256;
import {TypeGuard, TypeStatus} from "devkit/types/TypeGuard.sol";
// Core Types
import {Function} from "devkit/core/Function.sol";
import {FunctionRegistry} from "devkit/registry/FunctionRegistry.sol";
import {Bundle} from "devkit/core/Bundle.sol";
import {BundleRegistry} from "devkit/registry/BundleRegistry.sol";
import {Proxy, ProxyKind} from "devkit/core/Proxy.sol";
import {ProxyRegistry} from "devkit/registry/ProxyRegistry.sol";
import {Dictionary, DictionaryKind} from "devkit/core/Dictionary.sol";
import {DictionaryRegistry} from "devkit/registry/DictionaryRegistry.sol";
import {StdRegistry} from "devkit/registry/StdRegistry.sol";
import {StdFunctions} from "devkit/registry/StdFunctions.sol";


library Validate {
    enum Type { MUST, SHOULD }
    Type constant MUST = Type.MUST;
    Type constant SHOULD = Type.SHOULD;

    function validate(Type T, bool condition, string memory messageBody, string memory messageDetail) internal {
        if (condition) return;
        Logger.log(messageBody.append(messageDetail));
        if (T == MUST) revert(ERR.message(messageBody)); // TODO
    }
    function validate(bool condition, string memory logMessage) internal {
        validate(MUST, condition, logMessage, "");
    }
    function validate(bool condition, string memory errorBody, string memory errorDetail) internal {
        validate(condition, errorBody.append(errorDetail));
    }

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
    function isComplete(Function storage func) internal {
        validate(func.isComplete(), "Function Not Complete");
    }
    function valid(Function storage func) internal {
        exists(func);
        isComplete(func);
    }

    function EmptyName(Function storage func) internal {
        Validate.isUnassigned(func.name);
    }
    function EmptySelector(Function storage func) internal {
        Validate.isUnassigned(func.selector);
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
    function validRegistration(FunctionRegistry storage registry, string memory name) internal {
        validate(registry.functions[name].isComplete(), "Function Not Complete");
    }


    /**===============
        🗂️ Bundle
    =================*/
    function isComplete(Bundle storage bundle) internal {
        validate(bundle.isComplete(), "Bundle Info Not Complete", bundle.parse());
    }
    function valid(Bundle storage bundle) internal {
        exists(bundle);
        isComplete(bundle);
    }
    function SHOULD_valid(Bundle storage bundle) internal {
        validate(SHOULD, bundle.exists(), "Bundle Not Exists", "");
        // exists(bundle);
        validate(SHOULD, bundle.isComplete(), "Bundle Not Complete", "");
        // isComplete(bundle);
    }

    function exists(Bundle storage bundle) internal {
        validate(bundle.exists(), "Bundle Info Not Exists");
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
    function SHOULD_beCompleted(BundleRegistry storage registry, string memory name) internal {
        validate(SHOULD, registry.bundles[name].isComplete(), "Incompleted Bundle", "");
    }
    function MUST_existCurrent(BundleRegistry storage registry) internal {
        validate(MUST, registry.current.name.isNotEmpty(), "Current Not Exist", "");
    }
    function MUST_beInitialized(BundleRegistry storage registry) internal {
        validate(MUST, registry.current.name.isNotEmpty(), ERR.NOT_INIT, "");
    }

    /**==============
        🏠 Proxy
    ================*/
    function exists(Proxy storage proxy) internal returns(Proxy storage) {
        validate(proxy.exists(), "Proxy Not Exist");
        return proxy;
    }
    function isComplete(Proxy storage proxy) internal {
        validate(proxy.isComplete(), "Proxy Not Complete");
    }
    function valid(Proxy storage proxy) internal {
        exists(proxy);
        isComplete(proxy);
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

    function notRegistered(ProxyRegistry storage registry, string memory name) internal {
        validate(registry.proxies[name].notExists(), "Proxy Already Exists");
    }
    function validRegistration(ProxyRegistry storage registry, string memory name) internal {
        validate(registry.proxies[name].isComplete(), "Proxy Not Complete");
    }


    /**====================
        📚 Dictionary
    ======================*/
    function exists(Dictionary storage dictionary) internal returns(Dictionary storage) {
        validate(dictionary.exists(), "Dictionary Not Exists");
        return dictionary;
    }
    function isComplete(Dictionary storage dictionary) internal {
        validate(dictionary.isComplete(), "Dictionary Not Complete");
    }
    function valid(Dictionary storage dictionary) internal {
        exists(dictionary);
        isComplete(dictionary);
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
    function notUndefined(DictionaryKind kind) internal {
        validate(kind.isNotUndefined(), "Undefined Dictionary Kind");
    }
    function notUndefined(ProxyKind kind) internal {
        validate(kind.isNotUndefined(), "Undefined Dictionary Kind");
    }

    function notRegistered(DictionaryRegistry storage registry, string memory name) internal {
        validate(registry.dictionaries[name].notExists(), "Dictionary Already Exists");
    }
    function validRegistration(DictionaryRegistry storage registry, string memory name) internal {
        validate(registry.dictionaries[name].isComplete(), "Dictionary Not Registered");
    }


    function isUnassigned(string storage str) internal {
        validate(str.isEmpty(), ERR.STR_ALREADY_ASSIGNED);
    }
    function notEmpty(string memory str) internal {
        validate(str.isNotEmpty(), ERR.EMPTY_STR);
    }
    function MUST_notEmpty(string memory str) internal {
        validate(MUST, str.isNotEmpty(), "Current Bundle Not Found", "");
    }

    function isUnassigned(bytes4 b4) internal {
        validate(b4.isEmpty(), ERR.B4_ALREADY_ASSIGNED);
    }
    function notEmpty(bytes4 b4) internal {
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

    function notZero(address addr) internal {
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
}

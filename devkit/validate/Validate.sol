// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERR} from "devkit/log/message/ERR.sol";
import {Debug, LogLevel} from "devkit/log/debug/Debug.sol";
import {Parser} from "devkit/log/debug/Parser.sol";
import {Logger} from "devkit/log/debug/Logger.sol";
import {Inspector} from "devkit/types/Inspector.sol";
    using Inspector for string;
    using Inspector for bytes4;
    using Inspector for address;
    using Inspector for bool;
    using Inspector for uint256;
// Utils
import {StringUtils} from "devkit/types/StringUtils.sol";
    using StringUtils for string;
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


/**=================
    ✅ Validate
===================*/
library Validate {
    enum Type { MUST, SHOULD }
    Type constant MUST = Type.MUST;
    Type constant SHOULD = Type.SHOULD;

    function validate(Type T, bool condition, string memory messageBody, string memory messageDetail) internal {
        if (condition) return;
        Logger.log(messageBody.append(messageDetail));
        if (T == MUST) revert(ERR.message(messageBody)); // TODO
    }


    /**===================
        🔒 Type Guard
    =====================*/
    function MUST_built(TypeStatus status) internal {
        validate(MUST, status.isBuilt(), "Not Built Yet", "");
    }

    /**===================
        🧱 Primitives
    =====================*/
    function MUST_NotZeroUint(uint256 num) internal {
        validate(MUST, num.isNotZero(), "Zero Number", "");
    }
    function MUST_NotEmptyName(string memory name) internal {
        validate(MUST, name.isNotEmpty(), ERR.EMPTY_STR, "");
    }
    function MUST_NotEmptyEnvKey(string memory envKey) internal {
        validate(MUST, envKey.isNotEmpty(), ERR.EMPTY_STR, "");
    }
    function MUST_Bytes4NotEmpty(bytes4 b4) internal {
        validate(MUST, b4.isNotEmpty(), ERR.EMPTY_B4, "");
    }
    function MUST_AddressIsContract(address addr) internal {
        validate(MUST, addr.isContract(), ERR.NOT_CONTRACT, "");
    }
    function MUST_AddressIsNotZero(address addr) internal {
        validate(MUST, addr.isNotZero(), ERR.ZERO_ADDRESS, "");
    }


    /**==================
        🧩 Function
    ====================*/
    function MUST_nameAssigned(Function storage func) internal {
        validate(MUST, func.name.isAssigned(), "Name must be assigned", "");
    }
    function MUST_selectorAssigned(Function storage func) internal {
        validate(MUST, func.selector.isAssigned(), "Selector must be assigned", "");
    }
    function MUST_implementationAssigned(Function storage func) internal {
        validate(MUST, func.implementation.isContract(), "Contract must be assigned", "");
    }
    function MUST_completed(Function storage func) internal {
        validate(MUST, func.isComplete(), "Function Not Complete", "");
    }
    function MUST_FunctionNotLocked(Function storage func) internal {
        validate(MUST, func.status.isNotLocked(), ERR.LOCKED_OBJECT, "");
    }
    /**===========================
        📗 Functions Registry
    =============================*/
    function MUST_registered(FunctionRegistry storage registry, string memory name) internal {
        validate(MUST, registry.functions[name].isComplete(), "Function Not Found", "");
    }

    /**===============
        🗂️ Bundle
    =================*/
    function MUST_NameAssigned(Bundle storage bundle) internal {
        validate(MUST, bundle.name.isNotEmpty(), "Bundle Name is required", "");
    }
    function MUST_HaveAtLeastOneFunction(Bundle storage bundle) internal {
        validate(MUST, bundle.functions.length.isNotZero(), "At least one function is required", "");
    }
    function MUST_FacadeAssigned(Bundle storage bundle) internal {
        validate(MUST, bundle.facade.isContract(), "Bundle Facade is required", "");
    }
    function MUST_notInitialized(Bundle storage bundle) internal {
        validate(MUST, bundle.status.notInitialized(), "Bundle already initialized", "");
    }
    function MUST_completed(Bundle storage bundle) internal {
        validate(MUST, bundle.isComplete(), "Bundle Not Complete", Parser.parse(bundle));
    }
    function SHOULD_completed(Bundle storage bundle) internal {
        validate(SHOULD, bundle.isComplete(), "Bundle Not Complete", "");
    }
    function MUST_notHave(Bundle storage bundle, Function storage func) internal {
        validate(MUST, bundle.hasNot(func), "Bundle has same Function", "");
    }
    function MUST_BundleNotLocked(Bundle storage bundle) internal {
        validate(MUST, bundle.status.isNotLocked(), ERR.LOCKED_OBJECT, "");
    }

    /**=======================
        📙 Bundle Registry
    =========================*/
    function MUST_haveCurrent(BundleRegistry storage registry) internal {
        validate(MUST, registry.current.name.isNotEmpty(), "Current Not Exist", "");
    }

    /**==============
        🏠 Proxy
    ================*/
    function MUST_haveContract(Proxy memory proxy) internal {
        validate(MUST, proxy.addr.isContract(), "Contract is required", "");
    }
    function MUST_haveKind(Proxy memory proxy) internal {
        validate(MUST, proxy.kind.isNotUndefined(), "ProxyKind is required", "");
    }
    function MUST_contractAssigned(Proxy storage proxy) internal {
        validate(MUST, proxy.addr.isContract(), "Contract is not assigned", "");
    }
    function MUST_kindAssigned(Proxy storage proxy) internal {
        validate(MUST, proxy.kind.isNotUndefined(), "ProxyKind is not assigned", "");
    }
    function MUST_completed(Proxy storage proxy) internal {
        validate(MUST, proxy.isComplete(), "Proxy Not Complete", "");
    }
    /**=======================
        📕 Proxy Registry
    =========================*/
    function MUST_registered(ProxyRegistry storage registry, string memory name) internal {
        validate(MUST, registry.proxies[name].isComplete(), "Proxy Not Found", "");
    }
    function MUST_notRegistered(ProxyRegistry storage registry, string memory name) internal {
        validate(MUST, registry.proxies[name].notExists(), "Proxy Already Exists", "");
    }

    /**====================
        📚 Dictionary
    ======================*/
    function MUST_haveContract(Dictionary memory dictionary) internal {
        validate(MUST, dictionary.addr.isContract(), "Contract is required", "");
    }
    function MUST_haveKind(Dictionary memory dictionary) internal {
        validate(MUST, dictionary.kind.isNotUndefined(), "DictionaryKind is required", "");
    }
    function MUST_contractAssigned(Dictionary storage dictionary) internal {
        validate(MUST, dictionary.addr.isContract(), "Contract is not assigned", "");
    }
    function MUST_kindAssigned(Dictionary storage dictionary) internal {
        validate(MUST, dictionary.kind.isNotUndefined(), "DictionaryKind is not assigned", "");
    }
    function MUST_completed(Dictionary storage dictionary) internal {
        validate(MUST, dictionary.isComplete(), "Dictionary Not Complete", "");
    }
    /**============================
        📘 Dictionary Registry
    ==============================*/
    function MUST_registered(DictionaryRegistry storage registry, string memory name) internal {
        validate(MUST, registry.dictionaries[name].isComplete(), "Dictionary Not Found", "");
    }
    function MUST_notRegistered(DictionaryRegistry storage registry, string memory name) internal {
        validate(MUST, registry.dictionaries[name].notExists(), "Dictionary Already Exists", "");
    }

    /**==========================
        🏛 Standard Registry
    ============================*/
    function MUST_Completed(StdRegistry storage registry) internal {
        validate(MUST, registry.status.isComplete(), "Registry Not Complete", "");
    }
    function MUST_StdNotLocked(StdRegistry storage registry) internal {
        validate(MUST, registry.status.isNotLocked(), "Std Registry is locked", "");
    }
    function MUST_Completed(StdFunctions storage stdFunctions) internal {
        validate(MUST, stdFunctions.status.isComplete(), "Registry Not Complete", "");
    }

    /**=======================
        🏷️ Name Generator
    =========================*/
    function MUST_FoundInRange() internal {
        validate(MUST, false, ERR.FIND_NAME_OVER_RANGE, "");
    }

}

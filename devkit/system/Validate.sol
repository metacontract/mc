// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import {vm, VmSafe, ForgeHelper} from "devkit/utils/ForgeHelper.sol";
import {ERR} from "devkit/system/message/ERR.sol";
import {Formatter} from "devkit/types/Formatter.sol";
    using Formatter for string;
import {Logger} from "devkit/system/debug/Logger.sol";
import {Inspector} from "devkit/types/Inspector.sol";
    using Inspector for string;
    using Inspector for bytes4;
    using Inspector for address;
    using Inspector for bool;
    using Inspector for uint256;
// Utils
import {TypeGuard, TypeStatus} from "devkit/types/TypeGuard.sol";
import {System} from "devkit/system/System.sol";
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
    enum Type { MUST, SHOULD, COMPLETION }
    Type constant MUST = Type.MUST;
    Type constant SHOULD = Type.SHOULD;
    Type constant COMPLETION = Type.COMPLETION;

    function validate(Type T, bool condition, string memory title, string memory message) internal returns(bool) {
        if (condition) return true;
        if (T == COMPLETION) Logger.logInfo(Formatter.formatLog(title, message));
        if (T == SHOULD) Logger.logWarn(Formatter.formatLog(title, message));
        if (T == MUST) System.Exit(title, message);
    }

    // Validate without broadcast
    modifier noBroadcast() {
        (VmSafe.CallerMode mode,,) = vm.readCallers();
        if (mode == VmSafe.CallerMode.RecurrentBroadcast) vm.stopBroadcast();
        _;
        if (mode == VmSafe.CallerMode.RecurrentBroadcast) vm.startBroadcast(ForgeHelper.getPrivateKey("DEPLOYER_PRIV_KEY")); // Without CALL TODO

    }


    /**================
        📝 Config
    ==================*/
    function SHOULD_FileExists(string memory path) internal returns(bool condition) {
        condition = vm.exists(path);
        validate(SHOULD, condition, "Config File Not Found", "Please consider creating mc.toml in your project root.");
    }
    function MUST_FileExists(string memory path) internal {
        validate(MUST, vm.exists(path), "Config File Not Found", "Please creating mc.toml in your project root.");
    }


    /**===================
        🔒 Type Guard
    =====================*/
    function MUST_Built(TypeStatus status) internal {
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
    function MUST_NotEmptySelector(bytes4 selector) internal {
        validate(MUST, selector.isNotEmpty(), ERR.EMPTY_B4, "");
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
    function Completion(Function storage func) internal returns(bool) {
        return (
            validate(COMPLETION, func.name.isAssigned(), "Name must be assigned", "") &&
            validate(COMPLETION, func.selector.isAssigned(), "Selector must be assigned", "") &&
            validate(COMPLETION, func.implementation.isContract(), "Contract must be assigned", "")
        );
    }
    function MUST_Completed(Function memory func) internal {
        validate(MUST, func.isComplete(), "Function Not Complete", "");
    }
    function MUST_NotLocked(Function storage func) internal {
        validate(MUST, func.status.isNotLocked(), ERR.LOCKED_OBJECT, "");
    }
    function MUST_Building(Function storage func) internal {
        validate(MUST, func.status.isBuilding(), "Function is not building", "");
    }
    function MUST_Built(Function storage func) internal {
        validate(MUST, func.status.isBuilt(), "Function is not Built", "");
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
    function Completion(Bundle storage bundle) internal returns(bool) {
        return (
            validate(COMPLETION, bundle.name.isNotEmpty(), "Bundle Name should not be empty", "") &&
            validate(COMPLETION, bundle.functions.length.isNotZero(), "At least one function should not be empty", "") &&
            validate(COMPLETION, bundle.facade.isContract(), "Bundle Facade should not be empty", "")
        );
    }
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
        validate(MUST, bundle.status.isUninitialized(), "Bundle already initialized", "");
    }
    function MUST_completed(Bundle storage bundle) internal {
        validate(MUST, bundle.isComplete(), "Bundle MUST be Completed", Formatter.toString(bundle));
    }
    function SHOULD_Completed(Bundle storage bundle) internal {
        validate(SHOULD, bundle.isComplete(), "Bundle SHOULD be Completed", "");
    }
    function MUST_NotHaveSameFunction(Bundle storage bundle, Function storage func) internal {
        validate(MUST, bundle.hasNot(func), "Bundle has same Function", "");
    }
    function MUST_NotLocked(Bundle storage bundle) internal {
        validate(MUST, bundle.status.isNotLocked(), ERR.LOCKED_OBJECT, "");
    }
    function MUST_Building(Bundle storage bundle) internal {
        validate(MUST, bundle.status.isBuilding(), "Bundle is not building", "");
    }

    /**=======================
        📙 Bundle Registry
    =========================*/
    function SHOULD_ExistCurrentBundle(BundleRegistry storage registry) internal returns(bool condition) {
        condition = registry.current.name.isNotEmpty();
        validate(SHOULD, condition, ERR.EMPTY_CURRENT_BUNDLE, "");
    }

    /**==============
        🏠 Proxy
    ================*/
    function Completion(Proxy memory proxy) internal returns(bool) {
        return (
            validate(MUST, proxy.addr.isContract(), "Contract is required", "") &&
            validate(MUST, proxy.kind.isNotUndefined(), "ProxyKind is required", "")
        );
    }
    function MUST_contractAssigned(Proxy storage proxy) internal {
        validate(MUST, proxy.addr.isContract(), "Contract is not assigned", "");
    }
    function MUST_kindAssigned(Proxy storage proxy) internal {
        validate(MUST, proxy.kind.isNotUndefined(), "ProxyKind is not assigned", "");
    }
    function MUST_Completed(Proxy memory proxy) internal {
        validate(MUST, proxy.isComplete(), "Proxy Not Complete", "");
    }
    function MUST_NotLocked(Proxy memory proxy) internal {
        validate(MUST, proxy.status.isNotLocked(), ERR.LOCKED_OBJECT, "");
    }
    function MUST_Building(Proxy memory proxy) internal {
        validate(MUST, proxy.status.isBuilding(), "Proxy is not building", "");
    }
    /**=======================
        📕 Proxy Registry
    =========================*/
    function MUST_Registered(ProxyRegistry storage registry, string memory name) internal {
        validate(MUST, registry.proxies[name].isComplete(), "Proxy Not Found", "");
    }
    function MUST_NotRegistered(ProxyRegistry storage registry, string memory name) internal {
        validate(MUST, registry.proxies[name].isUninitialized(), "Proxy Already Exists", "");
    }

    /**====================
        📚 Dictionary
    ======================*/
    // In Storage
    function COMPLETION_contractAssigned(Dictionary storage dictionary) internal {
        validate(COMPLETION, dictionary.addr.isContract(), "Contract is not assigned", "");
    }
    function COMPLETION_kindAssigned(Dictionary storage dictionary) internal {
        validate(COMPLETION, dictionary.kind.isNotUndefined(), "DictionaryKind is not assigned", "");
    }
    // In Memory
    function Completion(Dictionary memory dictionary) internal returns(bool) {
        return (
            validate(COMPLETION, dictionary.addr.isContract(), "Contract is required", "") &&
            validate(COMPLETION, dictionary.kind.isNotUndefined(), "DictionaryKind is required", "")
        );
    }
    function MUST_Completed(Dictionary memory dictionary) internal {
        validate(MUST, dictionary.isComplete(), "Dictionary Not Complete", "");
    }
    function MUST_Verifiable(Dictionary memory dictionary) internal noBroadcast {
        validate(MUST, dictionary.isVerifiable(), "Dictionary Is Not Verifiable", "");
    }
    function MUST_NotLocked(Dictionary memory dictionary) internal {
        validate(MUST, dictionary.status.isNotLocked(), ERR.LOCKED_OBJECT, "");
    }
    function MUST_Building(Dictionary memory dictionary) internal {
        validate(MUST, dictionary.status.isBuilding(), "Dictionary is not building", "");
    }
    /**============================
        📘 Dictionary Registry
    ==============================*/
    function MUST_Registered(DictionaryRegistry storage registry, string memory name) internal {
        validate(MUST, registry.dictionaries[name].isComplete(), "Dictionary Not Found", "");
    }
    function MUST_NotRegistered(DictionaryRegistry storage registry, string memory name) internal {
        validate(MUST, registry.dictionaries[name].isUninitialized(), "Dictionary Already Exists", "");
    }

    /**==========================
        🏛 Standard Registry
    ============================*/
    function Completion(StdRegistry storage registry) internal returns(bool) {
        return (
            Validate.Completion(registry.functions) &&
            Validate.Completion(registry.all)
        );
    }
    function MUST_Completed(StdRegistry storage registry) internal {
        validate(MUST, registry.status.isComplete(), "Registry Not Complete", "");
    }
    function MUST_NotLocked(StdRegistry storage registry) internal {
        validate(MUST, registry.status.isNotLocked(), "Std Registry is locked", "");
    }
    function MUST_Building(StdRegistry storage registry) internal {
        validate(MUST, registry.status.isBuilding(), "Std Registry is not building", "");
    }
    /**==========================
        🏰 Standard Functions
    ============================*/
    function Completion(StdFunctions storage std) internal returns(bool) {
        return (
            Validate.Completion(std.initSetAdmin) &&
            Validate.Completion(std.getDeps) &&
            Validate.Completion(std.clone)
        );
    }
    function MUST_Completed(StdFunctions storage std) internal {
        validate(MUST, std.status.isComplete(), "Registry Not Complete", "");
    }
    function MUST_NotLocked(StdFunctions storage std) internal {
        validate(MUST, std.status.isNotLocked(), "StdFunctions is Locked", "");
    }
    function MUST_Building(StdFunctions storage std) internal {
        validate(MUST, std.status.isBuilding(), "StdFunctions is not building", "");
    }

    /**=======================
        🏷️ Name Generator
    =========================*/
    function MUST_FoundInRange() internal {
        validate(MUST, false, ERR.FIND_NAME_OVER_RANGE, "");
    }

}

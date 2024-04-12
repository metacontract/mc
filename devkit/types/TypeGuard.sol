// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// import {StringUtils} from "devkit/utils/primitive/StringUtils.sol";
//     using StringUtils for string;
// import {AddressUtils} from "devkit/utils/primitive/AddressUtils.sol";
//     using AddressUtils for address;
// import {Bytes4Utils} from "devkit/utils/primitive/Bytes4Utils.sol";
//     using Bytes4Utils for bytes4;
import {Validate} from "devkit/validate/Validate.sol";
// Core Types
import {Function} from "devkit/core/Function.sol";
import {Bundle} from "devkit/core/Bundle.sol";
import {Dictionary} from "devkit/core/Dictionary.sol";
import {Proxy} from "devkit/core/Proxy.sol";
import {StdRegistry} from "devkit/registry/StdRegistry.sol";
import {StdFunctions} from "devkit/registry/StdFunctions.sol";

using TypeGuard for TypeStatus global;
enum TypeStatus { Uninitialized, Building, Built, Locked }


/**===================
    🔒 Type Guard
=====================*/
library TypeGuard {
    function building(TypeStatus status) internal {
        status = TypeStatus.Building;
    }
    function isBuilt(TypeStatus status) internal returns(bool) {
        return status == TypeStatus.Built;
    }

    function isLocked(TypeStatus status) internal returns(bool) {
        return status == TypeStatus.Locked;
    }

    function isComplete(TypeStatus status) internal returns(bool) {
        return status.isBuilt() || status.isLocked();
    }


    /**==================
        🧩 Function
    ====================*/
    function building(Function storage func) internal returns(Function storage) {
        func.status.building();
        return func;
    }
    function build(Function storage func) internal returns(Function storage) {
        Validate.assigned(func.name);
        Validate.assigned(func.selector);
        Validate.contractAssigned(func.implementation);
        func.status = TypeStatus.Built;
        return func;
    }
    function lock(Function storage func) internal returns(Function storage) {
        Validate.MUST_beBuilt(func.status);
        func.status = TypeStatus.Locked;
        return func;
    }
    function isComplete(Function storage func) internal returns(bool) {
        return func.status.isComplete();
    }


    /**================
        🗂️ Bundle
    ==================*/
    function building(Bundle storage bundle) internal returns(Bundle storage) {
        bundle.status.building();
        return bundle;
    }
    function build(Bundle storage bundle) internal returns(Bundle storage) {
        Validate.assigned(bundle.name);
        Validate.notZero(bundle.functions.length);
        Validate.contractAssigned(bundle.facade);
        bundle.status = TypeStatus.Built;
        return bundle;
    }
    function lock(Bundle storage bundle) internal returns(Bundle storage) {
        Validate.MUST_beBuilt(bundle.status);
        bundle.status = TypeStatus.Locked;
        return bundle;
    }
    function isComplete(Bundle storage bundle) internal returns(bool) {
        return bundle.status.isComplete();
    }


    /**==========================
        🏛 Standard Registry
    ============================*/
    function building(StdRegistry storage registry) internal returns(StdRegistry storage) {
        registry.status.building();
        return registry;
    }
    function build(StdRegistry storage registry) internal returns(StdRegistry storage) {
        Validate.isComplete(registry.functions);
        Validate.isComplete(registry.all);
        registry.status = TypeStatus.Built;
        return registry;
    }
    function lock(StdRegistry storage registry) internal returns(StdRegistry storage) {
        Validate.MUST_beBuilt(registry.status);
        registry.status = TypeStatus.Locked;
        return registry;
    }


    /**==========================
        🏰 Standard Functions
    ============================*/
    function building(StdFunctions storage stdFunctions) internal returns(StdFunctions storage) {
        stdFunctions.status.building();
        return stdFunctions;
    }
    function build(StdFunctions storage stdFunctions) internal returns(StdFunctions storage) {
        Validate.isComplete(stdFunctions.initSetAdmin);
        Validate.isComplete(stdFunctions.getDeps);
        Validate.isComplete(stdFunctions.clone);
        stdFunctions.status = TypeStatus.Built;
        return stdFunctions;
    }
    function lock(StdFunctions storage stdFunctions) internal returns(StdFunctions storage) {
        Validate.MUST_beBuilt(stdFunctions.status);
        stdFunctions.status = TypeStatus.Locked;
        return stdFunctions;
    }


    /**====================
        📚 Dictionary
    ======================*/
    function building(Dictionary storage dictionary) internal returns(Dictionary storage) {
        dictionary.status.building();
        return dictionary;
    }
    function build(Dictionary storage dictionary) internal returns(Dictionary storage) {
        Validate.isContract(dictionary.addr);
        Validate.notUndefined(dictionary.kind);
        dictionary.status = TypeStatus.Built;
        return dictionary;
    }
    function lock(Dictionary storage dictionary) internal returns(Dictionary storage) {
        Validate.MUST_beBuilt(dictionary.status);
        dictionary.status = TypeStatus.Locked;
        return dictionary;
    }
    function isComplete(Dictionary storage dictionary) internal returns(bool) {
        return dictionary.status.isComplete();
    }


    /**===============
        🏠 Proxy
    =================*/
    function building(Proxy storage proxy) internal returns(Proxy storage) {
        proxy.status.building();
        return proxy;
    }
    function build(Proxy storage proxy) internal returns(Proxy storage) {
        Validate.isContract(proxy.addr);
        Validate.notUndefined(proxy.kind);
        proxy.status = TypeStatus.Built;
        return proxy;
    }
    function lock(Proxy storage proxy) internal returns(Proxy storage) {
        Validate.MUST_beBuilt(proxy.status);
        proxy.status = TypeStatus.Locked;
        return proxy;
    }
    function isComplete(Proxy storage proxy) internal returns(bool) {
        return proxy.status.isComplete();
    }
}

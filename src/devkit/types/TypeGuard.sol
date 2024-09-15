// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Inspector} from "devkit/types/Inspector.sol";
import {Validator} from "devkit/system/Validator.sol";
// Core Types
import {Function} from "devkit/core/Function.sol";
import {Bundle} from "devkit/core/Bundle.sol";
import {Dictionary} from "devkit/core/Dictionary.sol";
import {Proxy} from "devkit/core/Proxy.sol";
import {StdRegistry} from "devkit/registry/StdRegistry.sol";
import {StdFunctions} from "devkit/registry/StdFunctions.sol";


using Inspector for TypeStatus global;
enum TypeStatus { Uninitialized, Building, Built, Locked }

/**==================================================
    🔒 Type Guard
    @dev See details in docs/object_lifecycle.md
====================================================*/
library TypeGuard {
    using Inspector for bool;

    /**==================
        🧩 Function
    ====================*/
    function startBuilding(Function storage func) internal returns(Function storage) {
        uint pid = func.startProcess("startBuilding");
        Validator.MUST_NotLocked(func);
        func.status = TypeStatus.Building;
        return func.finishProcess(pid);
    }
    function finishBuilding(Function storage func) internal returns(Function storage) {
        uint pid = func.startProcess("finishBuilding");
        Validator.MUST_Building(func);
        if (Validator.ValidateBuilder(func)) func.status = TypeStatus.Built;
        return func.finishProcess(pid);
    }
    function lock(Function storage func) internal returns(Function storage) {
        uint pid = func.startProcess("lock");
        Validator.MUST_Built(func);
        func.status = TypeStatus.Locked;
        return func.finishProcess(pid);
    }

    /**================
        🗂️ Bundle
    ==================*/
    function startBuilding(Bundle storage bundle) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("startBuilding");
        Validator.MUST_NotLocked(bundle);
        bundle.status = TypeStatus.Building;
        return bundle.finishProcess(pid);
    }
    function finishBuilding(Bundle storage bundle) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("finishBuilding");
        Validator.MUST_Building(bundle);
        if (Validator.ValidateBuilder(bundle)) bundle.status = TypeStatus.Built;
        return bundle.finishProcess(pid);
    }
    function lock(Bundle storage bundle) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("lock");
        Validator.MUST_Built(bundle);
        bundle.status = TypeStatus.Locked;
        return bundle.finishProcess(pid);
    }

    /**===============
        🏠 Proxy
    =================*/
    function startBuilding(Proxy memory proxy) internal returns(Proxy memory) {
        uint pid = proxy.startProcess("startBuilding");
        Validator.MUST_NotLocked(proxy);
        proxy.status = TypeStatus.Building;
        return proxy.finishProcess(pid);
    }
    function finishBuilding(Proxy memory proxy) internal returns(Proxy memory) {
        uint pid = proxy.startProcess("finishBuilding");
        Validator.MUST_Building(proxy);
        if (Validator.ValidateBuilder(proxy)) proxy.status = TypeStatus.Built;
        return proxy.finishProcess(pid);
    }
    function lock(Proxy storage proxy) internal returns(Proxy storage) {
        uint pid = proxy.startProcess("lock");
        Validator.MUST_Built(proxy);
        proxy.status = TypeStatus.Locked;
        return proxy.finishProcessInStorage(pid);
    }

    /**====================
        📚 Dictionary
    ======================*/
    function startBuilding(Dictionary memory dictionary) internal returns(Dictionary memory) {
        uint pid = dictionary.startProcess("startBuilding");
        Validator.MUST_NotLocked(dictionary);
        dictionary.status = TypeStatus.Building;
        return dictionary.finishProcess(pid);
    }
    function finishBuilding(Dictionary memory dictionary) internal returns(Dictionary memory) {
        uint pid = dictionary.startProcess("finishBuilding");
        Validator.MUST_Building(dictionary);
        if (Validator.ValidateBuilder(dictionary)) dictionary.status = TypeStatus.Built;
        return dictionary.finishProcess(pid);
    }
    function lock(Dictionary storage dictionary) internal returns(Dictionary storage) {
        uint pid = dictionary.startProcess("lock");
        Validator.MUST_Built(dictionary);
        dictionary.status = TypeStatus.Locked;
        return dictionary.finishProcessInStorage(pid);
    }

    /**==========================
        🏛 Standard Registry
    ============================*/
    function startBuilding(StdRegistry storage registry) internal returns(StdRegistry storage) {
        uint pid = registry.startProcess("startBuilding");
        Validator.MUST_NotLocked(registry);
        registry.status = TypeStatus.Building;
        return registry.finishProcess(pid);
    }
    function finishBuilding(StdRegistry storage registry) internal returns(StdRegistry storage) {
        uint pid = registry.startProcess("finishBuilding");
        Validator.MUST_Building(registry);
        if (Validator.ValidateBuilder(registry)) registry.status = TypeStatus.Built;
        return registry.finishProcess(pid);
    }
    function lock(StdRegistry storage registry) internal returns(StdRegistry storage) {
        uint pid = registry.startProcess("lock");
        Validator.MUST_Built(registry);
        registry.status = TypeStatus.Locked;
        return registry.finishProcess(pid);
    }

    /**==========================
        🏰 Standard Functions
    ============================*/
    function startBuilding(StdFunctions storage std) internal returns(StdFunctions storage) {
        uint pid = std.startProcess("startBuilding");
        Validator.MUST_NotLocked(std);
        std.status = TypeStatus.Building;
        return std.finishProcess(pid);
    }
    function finishBuilding(StdFunctions storage std) internal returns(StdFunctions storage) {
        uint pid = std.startProcess("finishBuilding");
        Validator.MUST_Building(std);
        if (Validator.ValidateBuilder(std)) std.status = TypeStatus.Built;
        return std.finishProcess(pid);
    }
    function lock(StdFunctions storage std) internal returns(StdFunctions storage) {
        uint pid = std.startProcess("lock");
        Validator.MUST_Built(std);
        std.status = TypeStatus.Locked;
        return std.finishProcess(pid);
    }

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// import {StringUtils} from "devkit/utils/StringUtils.sol";
//     using StringUtils for string;
// import {AddressUtils} from "devkit/utils/AddressUtils.sol";
//     using AddressUtils for address;
// import {Bytes4Utils} from "devkit/utils/Bytes4Utils.sol";
//     using Bytes4Utils for bytes4;
import {Require} from "devkit/error/Require.sol";
// Core Types
import {Function} from "devkit/core/types/Function.sol";
import {Bundle} from "devkit/core/types/Bundle.sol";
import {StdFunctions} from "devkit/core/registry/StdFunctions.sol";
import {StdBundle} from "devkit/core/registry/StdBundle.sol";

using TypeGuard for TypeStatus global;
enum TypeStatus { Uninitialized, Building, Built, Locked }

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
        Require.assigned(func.name);
        Require.assigned(func.selector);
        Require.contractAssigned(func.implementation);
        func.status = TypeStatus.Built;
        return func;
    }
    function lock(Function storage func) internal returns(Function storage) {
        Require.isBuilt(func.status);
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
        Require.assigned(bundle.name);
        Require.notZero(bundle.functions.length);
        Require.contractAssigned(bundle.facade);
        bundle.status = TypeStatus.Built;
        return bundle;
    }
    function lock(Bundle storage bundle) internal returns(Bundle storage) {
        Require.isBuilt(bundle.status);
        bundle.status = TypeStatus.Locked;
        return bundle;
    }


    /**==========================
        🏰 Standard Functions
    ============================*/
    function building(StdFunctions storage stdFunctions) internal returns(StdFunctions storage) {
        stdFunctions.status.building();
        return stdFunctions;
    }
    function build(StdFunctions storage stdFunctions) internal returns(StdFunctions storage) {
        Require.isComplete(stdFunctions.initSetAdmin);
        Require.isComplete(stdFunctions.getDeps);
        Require.isComplete(stdFunctions.clone);
        stdFunctions.status = TypeStatus.Built;
        return stdFunctions;
    }
    function lock(StdFunctions storage stdFunctions) internal returns(StdFunctions storage) {
        Require.isBuilt(stdFunctions.status);
        stdFunctions.status = TypeStatus.Locked;
        return stdFunctions;
    }

}

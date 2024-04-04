// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {AddressUtils} from "devkit/utils/AddressUtils.sol";
    using AddressUtils for address;
import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;

import {FuncInfo} from "devkit/core/functions/FuncInfo.sol";
// import {BundleInfo} from "./BundleInfo.sol";

import {InitSetAdmin} from "mc-std/functions/protected/InitSetAdmin.sol";
import {GetDeps} from "mc-std/functions/GetDeps.sol";
import {Clone} from "mc-std/functions/Clone.sol";

library TestHelper {
    function isInitSetAdmin(FuncInfo memory functionInfo) internal returns(bool) {
        return
            functionInfo.name.isEqual("InitSetAdmin") &&
            functionInfo.selector == InitSetAdmin.initSetAdmin.selector &&
            functionInfo.implementation.isContract();
    }

    function isGetDeps(FuncInfo memory functionInfo) internal returns(bool) {
        return
            functionInfo.name.isEqual("GetDeps") &&
            functionInfo.selector == GetDeps.getDeps.selector &&
            functionInfo.implementation.isContract();
    }

    function isClone(FuncInfo memory functionInfo) internal returns(bool) {
        return
            functionInfo.name.isEqual("Clone") &&
            functionInfo.selector == Clone.clone.selector &&
            functionInfo.implementation.isContract();
    }
}

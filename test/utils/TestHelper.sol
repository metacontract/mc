// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// import {StringUtils} from "devkit/utils/primitive/StringUtils.sol";
//     using StringUtils for string;
import {Inspector} from "devkit/types/Inspector.sol";
    using Inspector for string;
    using Inspector for address;

import {Function} from "devkit/core/Function.sol";
// import {Bundle} from "./Bundle.sol";

import {InitSetAdmin} from "mc-std/functions/protected/InitSetAdmin.sol";
import {GetFunctions} from "mc-std/functions/GetFunctions.sol";
import {Clone} from "mc-std/functions/Clone.sol";

library TestHelper {
    function isInitSetAdmin(Function memory functionInfo) internal view returns(bool) {
        return
            functionInfo.name.isEqual("InitSetAdmin") &&
            functionInfo.selector == InitSetAdmin.initSetAdmin.selector &&
            functionInfo.implementation.isContract();
    }

    function isGetFunctions(Function memory functionInfo) internal view returns(bool) {
        return
            functionInfo.name.isEqual("GetFunctions") &&
            functionInfo.selector == GetFunctions.getFunctions.selector &&
            functionInfo.implementation.isContract();
    }

    function isClone(Function memory functionInfo) internal view returns(bool) {
        return
            functionInfo.name.isEqual("Clone") &&
            functionInfo.selector == Clone.clone.selector &&
            functionInfo.implementation.isContract();
    }
}

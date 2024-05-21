// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

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
    function isInitSetAdmin(Function memory func) internal view returns(bool) {
        return
            func.name.isEqual("InitSetAdmin") &&
            func.selector == InitSetAdmin.initSetAdmin.selector &&
            func.implementation.isContract();
    }

    function isGetFunctions(Function memory func) internal view returns(bool) {
        return
            func.name.isEqual("GetFunctions") &&
            func.selector == GetFunctions.getFunctions.selector &&
            func.implementation.isContract();
    }

    function isClone(Function memory func) internal view returns(bool) {
        return
            func.name.isEqual("Clone") &&
            func.selector == Clone.clone.selector &&
            func.implementation.isContract();
    }
}

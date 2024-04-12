// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Validation
import {Validate} from "devkit/validate/Validate.sol";
// Utils
import {vm} from "devkit/utils/ForgeHelper.sol";
import {BoolUtils} from "./BoolUtils.sol";
    using BoolUtils for bool;
// External Lib
import {ERC7546Utils} from "@ucs.mc/proxy/ERC7546Utils.sol";

/**======================\
|   📌 Address Utils     |
\=======================*/
using AddressUtils for address;
library AddressUtils {
    /**-----------------------
        🔀 Type Convertor
    -------------------------*/
    function toString(address addr) internal pure returns(string memory) {
        return vm.toString(addr);
    }


    /**-------------------------
        🧪 Utils for Testing
    ---------------------------*/
    function injectCode(address target, bytes memory runtimeBytecode) internal {
        // vm.assume(runtimeBytecode.length > 0);
        vm.etch(target, runtimeBytecode);
    }

    function injectDictionary(address target, address dictionary) internal {
        injectAddressToStorage(target, ERC7546Utils.DICTIONARY_SLOT, dictionary);
    }

    function injectAddressToStorage(address target, bytes32 slot, address addr) internal {
        vm.store(target, slot, bytes32(uint256(uint160(addr))));
    }

}

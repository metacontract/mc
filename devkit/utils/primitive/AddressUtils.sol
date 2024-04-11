// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Validation
import {validate} from "devkit/error/Validate.sol";
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


    /**-------------------------------
        🧐 Inspectors & Assertions
    ---------------------------------*/
    // isZero
    function isZero(address addr) internal returns(bool) {
        return addr == address(0);
    }
    function assertZero(address addr) internal returns(address) {
        validate(addr.isZero(), "Address Not Zero");
        return addr;
    }

    // isNotZero
    function isNotZero(address addr) internal returns(bool) {
        return addr.isZero().isNot();
    }
    function assertNotZero(address addr) internal returns(address) {
        validate(addr.isNotZero(), "Zero Address");
        return addr;
    }

    // hasCode
    function hasCode(address addr) internal returns(bool) {
        return addr.code.length != 0;
    }

    // hasNotCode
    function hasNotCode(address addr) internal returns(bool) {
        return addr.hasCode().isNot();
    }

    // isContract
    function isContract(address addr) internal returns(bool) {
        return addr.hasCode();
    }
    function assertIsContract(address addr) internal returns(address) {
        validate(addr.isContract(), "Address Not Contract");
        return addr;
    }

    // isNotContract
    function isNotContract(address addr) internal returns(bool) {
        return addr.isContract().isNot();
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

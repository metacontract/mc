// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Global Methods
import "./GlobalMethods.sol";
// Utils
import {ForgeHelper, vm} from "./ForgeHelper.sol";
import {BoolUtils} from "./BoolUtils.sol";
// External Lib
import {ERC7546Utils} from "@ucs.mc/proxy/ERC7546Utils.sol";

/**======================\
|   📌 Address Utils     |
\=======================*/
library AddressUtils {
    using AddressUtils for address;
    using BoolUtils for bool;

    /**-----------------------
        🔀 Type Convertor
    -------------------------*/
    function toString(address addr) internal pure returns(string memory) {
        return vm.toString(addr);
    }


    /**-------------------------------
        🧐 Inspectors & Assertions
    ---------------------------------*/
    function isZero(address addr) internal returns(bool) {
        return addr == address(0);
    }
    function isNotZero(address addr) internal returns(bool) {
        return addr.isZero().isNot();
    }
    function assertZero(address addr) internal returns(address) {
        check(addr.isZero(), "Address Not Zero");
        return addr;
    }
    function assertNotZero(address addr) internal returns(address) {
        check(addr.isNotZero(), "Zero Address");
        return addr;
    }

    function hasCode(address addr) internal returns(bool) {
        return addr.code.length != 0;
    }
    function hasNotCode(address addr) internal returns(bool) {
        return addr.hasCode().isNot();
    }
    function isContract(address addr) internal returns(bool) {
        return addr.hasCode();
    }
    function isNotContract(address addr) internal returns(bool) {
        return addr.isContract().isNot();
    }
    function assertIsContract(address addr) internal returns(address) {
        check(addr.isContract(), "Address Not Contract");
        return addr;
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

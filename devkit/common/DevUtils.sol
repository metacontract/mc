// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ForgeHelper, console2, StdStyle, vm} from "DevKit/common/ForgeHelper.sol";
import {ERC7546Utils} from "@ucs-contracts/src/proxy/ERC7546Utils.sol";
import "./Errors.sol";

//============================================
//  🛠 Development Utils
//      🔢 Utils for Primitives
//      📊 Utils for Logging
//      🚨 Utils for Errors & Assertions
library DevUtils {
    using DevUtils for *;
    using StdStyle for string;


    /**---------------------------
        🔢 Utils for Primitives
    -----------------------------*/
    function calcHash(string memory name) internal returns(bytes32) {
        return keccak256(abi.encode(name));
    }
    function safeCalcHashAt(string memory name, string memory errorLocation) internal returns(bytes32) {
        check(name.isNotEmpty(), "Calc Hash", errorLocation);
        return name.calcHash();
    }

    function append(string memory name, string memory str) internal returns(string memory) {
        return string.concat(name, str);
    }

    function getLabel(address addr) internal returns(string memory) {
        return ForgeHelper.getLabel(addr);
    }

    function isNot(bool flag) internal returns(bool) {
        return !flag;
    }
    function isFalse(bool flag) internal returns(bool) {
        return flag == false;
    }


    /**---------------
        Convertor
    ----------------*/
    function concat(string memory str, string memory str2) internal returns(string memory) {
        return string.concat(str, str2);
    }
    function concat(string memory str, address addr) internal returns(string memory) {
        return concat(str, vm.toString(addr));
    }
    function concat(string memory str, bytes4 selector) internal returns(string memory) {
        return concat(str, toString(selector));
    }
    function indent(string memory str) internal returns(string memory) {
        return concat("\t", str);
    }
    function toString(bytes4 selector) internal pure returns (string memory) {
        return vm.toString(selector).substring(10);
    }
    function substring(string memory str, uint n) internal pure returns (string memory) {
        bytes memory strBytes = bytes(str);
        bytes memory result = new bytes(n);
        for(uint i = 0; i < n; i++) {
            result[i] = strBytes[i];
        }
        return string(result);
    }


    /**-------------------------------
        🧐 Inspectors & Assertions
    ---------------------------------*/
    /* for address */
    function isZero(address addr) internal returns(bool) {
        return addr == address(0);
    }
    function isNotZero(address addr) internal returns(bool) {
        return addr.isZero().isNot();
    }
    function assertZeroAt(address addr, string memory errorLocation) internal returns(address) {
        check(addr.isZero(), "Address Not Zero", errorLocation);
        return addr;
    }
    function assertNotZeroAt(address addr, string memory errorLocation) internal returns(address) {
        check(addr.isNotZero(), "Zero Address", errorLocation);
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
    function assertIsContractAt(address addr, string memory errorLocation) internal returns(address) {
        check(addr.isContract(), "Address Not Contract", errorLocation);
        return addr;
    }

    /* for string */
    /// @dev only for memory
    function isEmpty(string memory str) internal returns(bool) {
        return bytes(str).length == 0;
    }
    function isNotEmpty(string memory str) internal returns(bool) {
        return str.isEmpty().isNot();
    }
    function assertEmptyAt(string memory str, string memory errorLocation) internal returns(string memory) {
        check(str.isEmpty(), "String Not Empty", errorLocation);
        return str;
    }
    function assertNotEmptyAt(string memory str, string memory errorLocation) internal returns(string memory) {
        check(str.isNotEmpty(), "Empty String", errorLocation);
        return str;
    }

    function isEqual(string memory a, string memory b) internal returns(bool) {
        return keccak256(abi.encode(a)) == keccak256(abi.encode(b));
    }
    function isNotEqual(string memory a, string memory b) internal returns(bool) {
        return a.isEqual(b).isNot();
    }

    /* for bytes4 */
    function isEmpty(bytes4 selector) internal returns(bool) {
        return selector == bytes4(0);
    }
    function isNotEmpty(bytes4 selector) internal returns(bool) {
        return selector.isEmpty().isNot();
    }
    function assertEmptyAt(bytes4 selector, string memory errorLocation) internal returns(bytes4) {
        check(selector.isEmpty(), "Selector Not Empty", errorLocation);
        return selector;
    }
    function assertNotEmptyAt(bytes4 selector, string memory errorLocation) internal returns(bytes4) {
        check(selector.isNotEmpty(), "Empty Selector", errorLocation);
        return selector;
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



    /**-------------------------
        📊 Utils for Logging
    ---------------------------*/

    /// @dev for settings
    /// 7201:mc.settings.log
    bytes32 constant SETTINGS_LOG_TRANSIENT_SLOT = 0xbde0fdc5ed1ea0336c91994660ac4a36d1b140bbccd99d8aa6d980b60a25d200;
    function toggleLog() internal {
        assembly {
            switch tload(SETTINGS_LOG_TRANSIENT_SLOT)
            case 0 {
                tstore(SETTINGS_LOG_TRANSIENT_SLOT, 1)
            }
            default {
                tstore(SETTINGS_LOG_TRANSIENT_SLOT, 0)
            }
        }
    }
    function shouldLog() internal returns(bool flag) {
        assembly {
            flag := tload(SETTINGS_LOG_TRANSIENT_SLOT)
        }
    }
    function log(string memory message) internal {
        if (shouldLog()) {
            console2.log(message);
        }
    }
    function logProcess(string memory message) internal {
        log(message.underline());
    }
    function logProcessStart(string memory message) internal {
        log((message.isNotEmpty() ? message : "Start Process").underline());
    }
    function logProcessFinish(string memory message) internal {
        log((message.isNotEmpty() ? message : "(Process Finished)").dim());
    }


    /**-------------------------
        🚨 Utils for Errors
    ---------------------------*/

    function revertUnusedNameNotFound() internal {
        string memory revertReason =
            "Default names are automatically set up to 5. Please manually assign names beyond that.";
        throwError(revertReason);
    }

    // TODO move to settings
    function getScanRange() internal returns(uint start, uint end) {
        return (1, 5);
    }
}

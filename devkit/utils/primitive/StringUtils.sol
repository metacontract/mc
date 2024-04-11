// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Validation
import {validate} from "devkit/validate/Validate.sol";
import {Debug} from "devkit/log/debug/Debug.sol";
// Utils
import {StdStyle, ForgeHelper, vm} from "devkit/utils/ForgeHelper.sol";
    using StdStyle for string;
import {Bytes4Utils} from "./Bytes4Utils.sol";
    using Bytes4Utils for bytes4;
import {BoolUtils} from "./BoolUtils.sol";
    using BoolUtils for bool;

/**=====================\
|   🖋 String Utils     |
\======================*/
using StringUtils for string;
library StringUtils {
    /**---------------------------
        🔢 Utils for Primitives
    -----------------------------*/
    function calcHash(string memory name) internal pure returns(bytes32) {
        return keccak256(abi.encode(name));
    }
    function safeCalcHash(string memory name) internal returns(bytes32) {
        validate(name.isNotEmpty(), "Calc Hash");
        return name.calcHash();
    }

    function loadAddress(string memory envKey) internal returns(address) {
        return ForgeHelper.loadAddressFromEnv(envKey);
    }

    function substring(string memory str, uint n) internal pure returns (string memory) {
        bytes memory strBytes = bytes(str);
        bytes memory result = new bytes(n);
        for(uint i = 0; i < n; i++) {
            result[i] = strBytes[i];
        }
        return string(result);
    }

    function toSequential(string memory str, uint i) internal returns(string memory) {
        return i == 1 ? str : str.append(i);
    }


    /**-----------------------
        🔀 Type Convertor
    -------------------------*/
    function toBytes(string memory str) internal returns (bytes memory) {
        return bytes(str);
    }


    /**----------------
        ➕ Append
    ------------------*/
    function append(string memory str, string memory addition) internal returns(string memory) {
        return string.concat(str, addition);
    }
    function append(string memory str, address addr) internal returns(string memory) {
        return str.append(vm.toString(addr));
    }
    function append(string memory str, bytes4 selector) internal returns(string memory) {
        return str.append(selector.toString());
    }
    function append(string memory str, uint num) internal returns(string memory) {
        return str.append(vm.toString(num));
    }

    function br(string memory str) internal returns(string memory) {
        return string.concat(str, "\n");
    }
    function sp(string memory str) internal returns(string memory) {
        return string.concat(str, " ");
    }
    function indent(string memory str) internal returns(string memory) {
        return string.concat(str, "\t");
    }
    function comma(string memory str) internal returns(string memory) {
        return string.concat(str, ", ");
    }
    function dot(string memory str) internal returns(string memory) {
        return string.concat(str, ".");
    }
    function parens(string memory str) internal returns(string memory) {
        return string.concat(str, "()");
    }
    function brackL(string memory str) internal returns(string memory) {
        return string.concat("[", str);
    }
    function brackR(string memory str) internal returns(string memory) {
        return string.concat(str, "]");
    }


    /**-------------------------------
        🧐 Inspectors & Assertions
    ---------------------------------*/
    // isEmpty
    /// @dev only for memory
    function isEmpty(string memory str) internal returns(bool) {
        return bytes(str).length == 0;
    }
    function assertEmpty(string memory str) internal returns(string memory) {
        validate(str.isEmpty(), "String Not Empty");
        return str;
    }

    // isNotEmpty
    function isNotEmpty(string memory str) internal returns(bool) {
        return str.isEmpty().isNot();
    }
    function assertNotEmpty(string memory str) internal returns(string memory) {
        validate(str.isNotEmpty(), "Empty String");
        return str;
    }

    // isEqual
    function isEqual(string memory a, string memory b) internal returns(bool) {
        return keccak256(abi.encode(a)) == keccak256(abi.encode(b));
    }

    // isNotEqual
    function isNotEqual(string memory a, string memory b) internal returns(bool) {
        return a.isEqual(b).isNot();
    }


    /**----------------
        🐞 Debug
    ------------------*/
    /**
        Record Finish
     */
    function recordExecFinish(string memory str, uint pid) internal returns(string memory) {
        Debug.recordExecFinish(pid);
        return str;
    }

}

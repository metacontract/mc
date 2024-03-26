// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Global Methods
import "./GlobalMethods.sol";
// Utils
import {StdStyle, ForgeHelper, vm} from "./ForgeHelper.sol";
import {Bytes4Utils} from "./Bytes4Utils.sol";
import {BoolUtils} from "./BoolUtils.sol";

/**=====================\
|   🖋 String Utils     |
\======================*/
library StringUtils {
    using StringUtils for string;
    using StdStyle for string;
    using Bytes4Utils for bytes4;
    using BoolUtils for bool;

    /**---------------------------
        🔢 Utils for Primitives
    -----------------------------*/
    function calcHash(string memory name) internal pure returns(bytes32) {
        return keccak256(abi.encode(name));
    }
    function safeCalcHash(string memory name) internal returns(bytes32) {
        check(name.isNotEmpty(), "Calc Hash");
        return name.calcHash();
    }

    function loadAddress(string memory envKey) internal returns(address) {
        return ForgeHelper.loadAddressFromEnv(envKey);
    }


    /**---------------
        Convertor
    ----------------*/
    function append(string memory original, string memory addition) internal returns(string memory) {
        return string.concat(original, addition);
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
    function sp(string memory str) internal returns(string memory) {
        return string.concat(str, " ");
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


    /**-------------------------------
        🧐 Inspectors & Assertions
    ---------------------------------*/
    /// @dev only for memory
    function isEmpty(string memory str) internal returns(bool) {
        return bytes(str).length == 0;
    }
    function isNotEmpty(string memory str) internal returns(bool) {
        return str.isEmpty().isNot();
    }
    function assertEmpty(string memory str) internal returns(string memory) {
        check(str.isEmpty(), "String Not Empty");
        return str;
    }
    function assertNotEmpty(string memory str) internal returns(string memory) {
        check(str.isNotEmpty(), "Empty Stringqqqqq");
        return str;
    }

    function isEqual(string memory a, string memory b) internal returns(bool) {
        return keccak256(abi.encode(a)) == keccak256(abi.encode(b));
    }
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

using StringQueueLib for StringQueue global;
struct StringQueue {
    string[] queue;
    uint front;
    uint back;
}
library StringQueueLib {
    function enqueue(StringQueue storage $, string memory item) internal {
        $.queue.push(item);
        $.back++;
    }

    function dequeue(StringQueue storage $) internal returns (string memory) {
        require($.back > $.front, "StringQueue is empty");

        string memory item = $.queue[$.front];
        $.front++;

        if ($.isEmpty()) {
            delete $.queue;
            $.front = 0;
            $.back = 0;
        }

        return item;
    }

    function isEmpty(StringQueue storage $) internal view returns (bool) {
        return $.back == $.front;
    }

    function size(StringQueue storage $) internal view returns (uint) {
        return $.back - $.front;
    }
}

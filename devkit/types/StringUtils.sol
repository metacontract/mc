// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Validation
import {Validate} from "devkit/system/validate/Validate.sol";
import {System} from "devkit/system/System.sol";
import {DebuggerLib} from "devkit/system/debug/Debugger.sol";
// Utils
import {StdStyle, ForgeHelper, vm} from "devkit/utils/ForgeHelper.sol";
    using StdStyle for string;
import {TypeConverter} from "devkit/types//TypeConverter.sol";
    using TypeConverter for bytes4;


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
        Validate.MUST_NotEmptyName(name);
        return name.calcHash();
    }

    // function loadAddress(string memory envKey) internal returns(address) {
    //     return ForgeHelper.loadAddressFromEnv(envKey);
    // }

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




    /**----------------
        🐞 Debug
    ------------------*/
    /**
        Record Finish
     */
    function recordExecFinish(string memory str, uint pid) internal returns(string memory) {
        DebuggerLib.recordExecFinish(pid);
        return str;
    }

}

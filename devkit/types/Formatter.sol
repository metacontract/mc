// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core Types
import {Function} from "devkit/core/Function.sol";
import {Bundle} from "devkit/core/Bundle.sol";
// Utils
import {StdStyle, vm} from "devkit/utils/ForgeHelper.sol";
    using StdStyle for string;
import {System} from "devkit/system/System.sol";
import {Process} from "devkit/system/debug/Process.sol";


/**==================
    🗒️ Formatter
====================*/
library Formatter {
    using Formatter for string;
    using Formatter for bytes4;

    /**==================
        🧩 Function
    ====================*/
    function toString(Function memory func) internal returns(string memory message) {
        return message  .append("Impl: ").append(func.implementation).comma()
                        .append("Selector: ").append(func.selector).comma()
                        .append("Name: ").append(func.name);
    }


    /**===============
        🗂️ Bundle
    =================*/
    function toString(Bundle storage bundle) internal returns(string memory message) {
        message = message.append("Facade: ").append(bundle.facade);

        Function[] memory _funcs = bundle.functions;
        for (uint i; i < _funcs.length; ++i) {
            message = message.br().append(toString(_funcs[i]));
        }
    }

    string constant LOCATION_HEADER = "\n\t    at ";
    function toString(Process memory proc) internal returns(string memory) {
        return LOCATION_HEADER.append(proc.libName.dot().append(proc.funcName).parens().append(proc.params.italic())).dim();
    }

    string constant PID = "pid:";
    function formatPid(uint pid) internal returns(string memory message) {
        return message.brackL().append(PID).append(pid).brackR().sp().dim();
    }
    function formatProc(uint pid, string memory status, string memory libName, string memory funcName) internal returns(string memory) {
        return formatPid(pid).append(status).append(libName.dot().append(funcName)).parens();
    }


    /**===================
        🧱 Primitives
    =====================*/
    /// 📝 String
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

    function toSequential(string memory str, uint i) internal returns(string memory) {
        return i == 1 ? str : str.append(i);
    }

    function toString(address addr) internal pure returns(string memory) {
        return vm.toString(addr);
    }

    function toString(bytes4 selector) internal pure returns (string memory) {
        return vm.toString(selector).substring(10);
    }

    function toBytes(string memory str) internal returns (bytes memory) {
        return bytes(str);
    }

    function substring(string memory str, uint n) internal pure returns (string memory) {
        bytes memory strBytes = bytes(str);
        bytes memory result = new bytes(n);
        for(uint i = 0; i < n; i++) {
            result[i] = strBytes[i];
        }
        return string(result);
    }

}


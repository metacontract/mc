// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core Types
import {Function} from "devkit/core/Function.sol";
import {Bundle} from "devkit/core/Bundle.sol";
// Utils
import {StdStyle, vm} from "devkit/utils/ForgeHelper.sol";
import {Process} from "devkit/system/debug/Process.sol";


/**==================
    🗒️ Formatter
====================*/
library Formatter {
    using Formatter for string;
    using Formatter for bytes4;
    using StdStyle for string;

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

    /**=================
        ⛓️ Process
    ===================*/
    function toLocation(Process memory process) internal returns(string memory) {
        string memory at = "\t    at ";
        return at.append(process.libName.dot().append(process.funcName.parens())).dim().br();
    }

    function formatPid(uint pid) internal returns(string memory) {
        string memory PID = "pid:";
        string memory strPid = vm.toString(pid);
        string memory paddedPid = pid < 10 ? string.concat("0", strPid) : strPid;
        return PID.append(paddedPid).sp();
    }

    function toStart(Process memory process, uint pid) internal returns(string memory) {
        string memory header = formatPid(pid);
        string memory nest;
        for (uint i; i <= process.nest; ++i) {
            nest = string.concat(nest, "> ");
        }
        return header.append(nest.dim()).append(process.libName.dot().append(process.funcName.parens())).append(process.params.italic());
    }

    function toFinish(Process memory process, uint pid) internal returns(string memory) {
        string memory header = formatPid(pid);
        string memory nest;
        for (uint i; i <= process.nest; ++i) {
            nest = string.concat(nest, "< ");
        }
        return header.append(nest).append(process.libName.dot().append(process.funcName.parens())).dim();
    }

    function formatLog(string memory title, string memory message) internal returns(string memory) {
        return title.sp().append(message);
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



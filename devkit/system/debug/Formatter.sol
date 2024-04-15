// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core Types
import {Function} from "devkit/core/Function.sol";
import {Bundle} from "devkit/core/Bundle.sol";
// Utils
import {StringUtils} from "devkit/types/StringUtils.sol";
    using StringUtils for string;
import {StdStyle} from "devkit/utils/ForgeHelper.sol";
    using StdStyle for string;
import {System} from "devkit/system/System.sol";
import {Process} from "devkit/system/debug/Process.sol";


/**==================
    🗒️ Formatter
====================*/
library Formatter {

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
}



// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core Types
import {Function} from "devkit/core/Function.sol";
import {Bundle} from "devkit/core/Bundle.sol";
// Utils
import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;

//================
//  🗒️ Parser
library Parser {
    /**==================
        🧩 Function
    ====================*/
    function parse(Function memory func) internal returns(string memory message) {
        return message  .append("Impl: ").append(func.implementation).comma()
                        .append("Selector: ").append(func.selector).comma()
                        .append("Name: ").append(func.name);
    }


    /**===============
        🗂️ Bundle
    =================*/
    function parse(Bundle storage bundle) internal returns(string memory message) {
        message = message.append("Facade: ").append(bundle.facade);

        Function[] memory _funcs = bundle.functionInfos;
        for (uint i; i < _funcs.length; ++i) {
            message = message.br().append(_funcs[i].parse());
        }
    }

}



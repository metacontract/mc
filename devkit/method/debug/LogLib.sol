// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Logger} from "devkit/debug/Logger.sol";
import {Function} from "devkit/core/functions/Function.sol";

import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;

//================
//  📊 LogLib
library LogLib {
    /**==================
        🧩 Function
    ====================*/
    function parseAndLog(Function storage func) internal returns(Function storage) {
        Logger.log(
            func.parse()
        );
        return func;
    }
    function parse(Function memory func) internal returns(string memory message) {
        return message  .append("Impl: ").append(func.implementation).comma()
                        .append("Selector: ").append(func.selector).comma()
                        .append("Name: ").append(func.name);
    }

}



// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Utils
import {StdStyle} from "devkit/utils/ForgeHelper.sol";
    using StdStyle for string;
import {Formatter} from "devkit/types/Formatter.sol";

/// @title Error Message
library CRITICAL {
    string constant HEADER = "\xF0\x9F\x9A\xA8 [CRITICAL] ";

    function header(string memory body) internal returns(string memory) {
        return Formatter.append(HEADER.red(), body).bold();
    }
}

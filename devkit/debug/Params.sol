// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;

library Params {
    string constant HEADER = " with params: ";

    function append(string memory str) internal returns(string memory) {
        return HEADER.append(str);
    }
    function append(string memory str, bytes4 b4, address addr) internal returns(string memory) {
        return HEADER.append(str).comma().append(b4).comma().append(addr);
    }
}

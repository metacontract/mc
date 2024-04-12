// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {vm} from "devkit/utils/ForgeHelper.sol";
import {StringUtils} from "devkit/types/StringUtils.sol";
    using StringUtils for string;

/**=====================\
|   🔀 Type Converter   |
\======================*/
library TypeConverter {
    function toString(address addr) internal pure returns(string memory) {
        return vm.toString(addr);
    }

    function toString(bytes4 selector) internal pure returns (string memory) {
        return vm.toString(selector).substring(10);
    }

    function toBytes(string memory str) internal returns (bytes memory) {
        return bytes(str);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {vm} from "devkit/utils/ForgeHelper.sol";

/**=====================\
|   🔀 Type Converter   |
\======================*/
library TypeConverter {
    function toString(address addr) internal pure returns(string memory) {
        return vm.toString(addr);
    }
}

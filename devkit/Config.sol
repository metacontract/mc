// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**===============\
|   📝 Config     |
\================*/
library Config {
    bool constant DEBUG_MODE = false;

    function SCAN_RANGE() internal pure returns(uint start, uint end) {
        return (1, 5);
    }
}

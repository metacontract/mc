// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**===============\
|   📝 Config     |
\================*/
library Config {
    function SCAN_RANGE() internal  returns(uint start, uint end) {
        return (1, 5);
    }
}

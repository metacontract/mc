// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Config} from "devkit/system/Config.sol";

/**===============\
|   💻 System     |
\================*/
library System {

    function config() internal pure returns(Config storage ref) {
        assembly { ref.slot := 0x43faf0b0e69b78a7870a9a7da6e0bf9d6f14028444e1b48699a33401cb840400 }
    }


}

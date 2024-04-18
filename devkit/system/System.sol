// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ConfigState} from "devkit/system/Config.sol";
import {Debugger} from "devkit/system/debug/Debugger.sol";
import {Logger} from "devkit/system/debug/Logger.sol";
import {Formatter} from "devkit/types/Formatter.sol";


/**===============\
|   💻 System     |
\================*/
library System {
    function Config() internal pure returns(ConfigState storage ref) {
        assembly { ref.slot := 0x43faf0b0e69b78a7870a9a7da6e0bf9d6f14028444e1b48699a33401cb840400 }
    }
    function Debug() internal pure returns(Debugger storage ref) {
        assembly { ref.slot := 0x03d3692c02b7cdcaf0187e8ede4101c401cc53a33aa7e03ef4682fcca8a55300 }
    }

    function Exit(string memory errorTitle, string memory errorMessage) internal {
        Logger.logException(Formatter.formatLog(errorTitle, errorMessage));
        revert(errorTitle);
    }

}

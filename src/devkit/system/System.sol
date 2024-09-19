// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {ConfigState} from "@mc-devkit/system/Config.sol";
import {Trace} from "@mc-devkit/system/Tracer.sol";
import {Logger} from "@mc-devkit/system/Logger.sol";
import {Formatter} from "@mc-devkit/types/Formatter.sol";


/**===============\
|   💻 System     |
\================*/
library System {
    function Config() internal pure returns(ConfigState storage ref) {
        assembly { ref.slot := 0x43faf0b0e69b78a7870a9a7da6e0bf9d6f14028444e1b48699a33401cb840400 }
    }
    function Tracer() internal pure returns(Trace storage ref) {
        assembly { ref.slot := 0xa49160886909e5e0f01c27589d50ba63eab65b778730b187d2804aa2e50cc900 }
    }

    function Exit(string memory errorHead, string memory errorDetail) internal view {
        Logger.logException(errorHead, errorDetail);
        revert(errorHead);
    }

}

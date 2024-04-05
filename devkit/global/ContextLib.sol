// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKit} from "devkit/MCDevKit.sol";

using ContextLib for MCDevKit;
library ContextLib {
    string constant LIB_NAME = "MCContext";

    /**-----------------------------
        ♻️ Reset Current Context
    -------------------------------*/
    function reset(MCDevKit storage mc) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("reset");
        mc.dictionary.reset();
        mc.functions.reset();
        mc.proxy.reset();
        return mc.recordExecFinish(pid);
    }

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKit} from "devkit/MCDevKit.sol";

/***********************************************
    🎭 Context
        ♻️ Reset Current Context
************************************************/
library MCContextLib {
    string constant LIB_NAME = "MCContextLib";


    /**-----------------------------
        ♻️ Reset Current Context
    -------------------------------*/
    function reset(MCDevKit storage mc) internal returns(MCDevKit storage) {
        uint pid = mc.startProcess("reset");
        mc.dictionary.current.reset();
        mc.functions.current.reset();
        // mc.proxy.current.reset();
        return mc.finishProcess(pid);
    }

}

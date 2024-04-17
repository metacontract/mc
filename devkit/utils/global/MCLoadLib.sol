// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKit} from "devkit/MCDevKit.sol";


/***********************************************
    💽 MC Load
************************************************/
library MCLoadLib {

    function load(MCDevKit storage mc, address dictionary) internal returns(MCDevKit storage) {
        uint pid = mc.startProcess("load");
        // mc.dictionary.register(dictionary);
        return mc.finishProcess(pid);
    }

}

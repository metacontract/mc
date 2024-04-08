// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Debug} from "devkit/debug/Debug.sol";
// Types
import {Function} from "devkit/core/functions/Function.sol";

library ProcessLib {
    function startProcess(Function storage, string memory name, string memory params) internal returns(uint) {
        return Debug.recordExecStart("FunctionLib", name, params);
    }
    function startProcess(Function storage func, string memory name) internal returns(uint) {
        return func.startProcess(name, "");
    }
    function finishProcess(Function storage func, uint pid) internal returns(Function storage) {
        Debug.recordExecFinish(pid);
        return func;
    }

}

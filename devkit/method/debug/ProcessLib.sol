// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Debug} from "devkit/debug/Debug.sol";
// Types
import {Function} from "devkit/core/Function.sol";
import {StdFunctions} from "devkit/core/StdFunctions.sol";

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


    /**--------------------------
        🏛 Standard Functions
    ----------------------------*/
    function startProcess(StdFunctions storage, string memory name, string memory params) internal returns(uint) {
        return Debug.recordExecStart("StdFunctionsLib", name, params);
    }
    function startProcess(StdFunctions storage std, string memory name) internal returns(uint) {
        return std.startProcess(name, "");
    }
    function finishProcess(StdFunctions storage std, uint pid) internal returns(StdFunctions storage) {
        Debug.recordExecFinish(pid);
        return std;
    }

}

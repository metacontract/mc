// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ForgeHelper, console2, StdStyle, vm} from "DevKit/common/ForgeHelper.sol";
import {ERC7546Utils} from "@ucs-contracts/src/proxy/ERC7546Utils.sol";
import "./Errors.sol";

//============================================
//  🐞 Debugger Utils
//      🔢 Utils for Primitives
//      📊 Utils for Logging
//      🚨 Utils for Errors & Assertions
library Debug {
    using DevUtils for *;
    using StdStyle for string;

    function debug() internal returns(DebuggerStorage storage ref) {
        assembly { ref.slot := DEBUGGER }
    }
    bytes32 constant DEBUGGER = 0x03d3692c02b7cdcaf0187e8ede4101c401cc53a33aa7e03ef4682fcca8a55300;
    /// @custom:storage-location erc7201:mc.devkit.debugger
    struct DebuggerStorage {
        bool emitLog;
        string[] errorLocationStack;
    }

    /**-------------------------
        📊 Utils for Logging
    ---------------------------*/
    function startLog() internal {
        debug().emitLog = true;
    }
    function stopLog() internal {
        debug().emitLog = false;
    }
    function shouldLog() internal returns(bool) {
        return debug().emitLog;
    }
    function log(string memory message) internal {
        if (shouldLog()) {
            console2.log(message);
        }
    }
    function logProcess(string memory message) internal {
        log(message.underline());
    }
    function logProcessStart(string memory message) internal {
        log((message.isNotEmpty() ? message : "Start Process").underline());
    }
    function logProcessFinish(string memory message) internal {
        log((message.isNotEmpty() ? message : "(Process Finished)").dim());
    }
}

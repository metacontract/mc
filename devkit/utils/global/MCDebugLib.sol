// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.24;

// import {MCDevKit} from "devkit/MCDevKit.sol";
// import {System} from "devkit/system/System.sol";
// // Debug
// import {ProcessManager} from "devkit/system/debug/Process.sol";
// import {Logger} from "devkit/system/debug/Logger.sol";


// /***********************************************
//     🐞 Debug
//         ▶️ Start
//         🛑 Stop
//         📩 Insert Log
//         🔽 Record Start
//         🔼 Record Finish
// ************************************************/
// library MCDebugLib {

//     /**---------------
//         ▶️ Start
//     -----------------*/
//     function startDebug(MCDevKit storage mc) internal returns(MCDevKit storage) {
//         uint pid = mc.startProcess("startDebug");
//         // if (System.Config().DEBUG.MODE) System.Debug().startDebug();
//         return mc.finishProcess(pid);
//     }

//     /**-------------
//         🛑 Stop
//     ---------------*/
//     function stopLog(MCDevKit storage mc) internal returns(MCDevKit storage) {
//         // System.Debug().stopLog();
//         return mc;
//     }

//     /**--------------------
//         🔽 Record Start
//     ----------------------*/
//     function startProcess(MCDevKit storage mc, string memory funcName, string memory params) internal returns(uint) {
//         return ProcessManager.startProcess("mc", funcName, params);
//     }
//     function startProcess(MCDevKit storage mc, string memory funcName) internal returns(uint) {
//         return startProcess(mc, funcName, "");
//     }

//     /**---------------------
//         🔼 Record Finish
//     -----------------------*/
//     function finishProcess(MCDevKit storage mc, uint pid) internal returns(MCDevKit storage) {
//         ProcessManager.finishProcess(pid);
//         return mc;
//     }

// }

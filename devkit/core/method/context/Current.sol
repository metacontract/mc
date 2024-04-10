// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {Params} from "devkit/debug/Params.sol";
import {ProcessLib} from "devkit/core/method/debug/ProcessLib.sol";
    using ProcessLib for Current global;

// Validation
import {Require} from "devkit/error/Require.sol";


/**========================
    📸 Current Context
==========================*/
using CurrentLib for Current global;
struct Current {
    string name;
}
library CurrentLib {
    /**-------------------------------
        🔄 Update Current Context
    ---------------------------------*/
    function update(Current storage current, string memory name) internal {
        uint pid = current.startProcess("update", Params.append(name));
        Require.notEmpty(name);
        current.name = name;
        ProcessLib.finishProcess(pid);
    }

    /**------------------------------
        🧹 Reset Current Context
    --------------------------------*/
    function reset(Current storage current) internal {
        uint pid = current.startProcess("reset");
        delete current.name;
        ProcessLib.finishProcess(pid);
    }

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {Tracer, param} from "devkit/system/debug/Tracer.sol";
// Validation
import {Validate} from "devkit/system/Validate.sol";


////////////////////////////////////////////
//  📸 Current Context   ///////////////////
    using CurrentLib for Current global;
    using Tracer for Current global;
////////////////////////////////////////////
struct Current {
    string name;
}
library CurrentLib {

    /**-------------------------------
        🔄 Update Current Context
    ---------------------------------*/
    function update(Current storage current, string memory name) internal {
        uint pid = current.startProcess("update", param(name));
        Validate.MUST_NotEmptyName(name);
        current.name = name;
        current.finishProcess(pid);
    }

    /**------------------------------
        🧹 Reset Current Context
    --------------------------------*/
    function reset(Current storage current) internal {
        uint pid = current.startProcess("reset");
        delete current.name;
        current.finishProcess(pid);
    }

}

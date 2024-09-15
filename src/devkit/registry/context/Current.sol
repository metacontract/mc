// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;
/**---------------------
    Support Methods
-----------------------*/
import {Tracer, param} from "devkit/system/Tracer.sol";
// Validation
import {Validator} from "devkit/system/Validator.sol";


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
        Validator.MUST_NotEmptyName(name);
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

    /**------------------
        🔍 Find Name
    --------------------*/
    function find(Current storage current) internal returns(string memory name) {
        uint pid = current.startProcess("find");
        Validator.MUST_NameFound(current);
        name = current.name;
        current.finishProcess(pid);
    }

}

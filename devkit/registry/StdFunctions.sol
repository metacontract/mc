// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {ProcessLib} from "devkit/system/debug/Process.sol";
    using ProcessLib for StdFunctions global;
import {TypeGuard, TypeStatus} from "devkit/types/TypeGuard.sol";
    using TypeGuard for StdFunctions global;
import {Validate} from "devkit/system/Validate.sol";

// Core Types
import {Function} from "devkit/core/Function.sol";
// MC Std
import {Clone} from "mc-std/functions/Clone.sol";
import {GetDeps} from "mc-std/functions/GetDeps.sol";
import {FeatureToggle} from "mc-std/functions/protected/FeatureToggle.sol";
import {InitSetAdmin} from "mc-std/functions/protected/InitSetAdmin.sol";
import {UpgradeDictionary} from "mc-std/functions/protected/UpgradeDictionary.sol";
import {StdFacade} from "mc-std/interfaces/StdFacade.sol";


/**==========================
    🏰 Standard Functions
============================*/
using StdFunctionsLib for StdFunctions global;
struct StdFunctions {
    Function initSetAdmin;
    Function getDeps;
    Function clone;
    TypeStatus status;
}
library StdFunctionsLib {
    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        🟢 Complete Standard Functions
        📨 Fetch Standard Functions from Env
        🚀 Deploy Standard Functions If Not Exists
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

    /**------------------------------------
        🟢 Complete Standard Functions
    --------------------------------------*/
    function complete(StdFunctions storage stdFunctions) internal returns(StdFunctions storage) {
        uint pid = stdFunctions.startProcess("complete");
        stdFunctions.fetch();
        stdFunctions.deployIfNotExists();
        stdFunctions.finalize();
        return stdFunctions.finishProcess(pid);
    }

    /**-----------------------------------------
        📨 Fetch Standard Functions from Env
    -------------------------------------------*/
    function fetch(StdFunctions storage stdFunctions) internal returns(StdFunctions storage) {
        uint pid = stdFunctions.startProcess("fetch");
        return stdFunctions .fetch_InitSetAdmin()
                            .fetch_GetDeps()
                            .fetch_Clone()
                            .finishProcess(pid);
    }

        /**===== Each Std Function =====*/
        function fetch_InitSetAdmin(StdFunctions storage stdFunctions) internal returns(StdFunctions storage) {
            uint pid = stdFunctions.startProcess("fetch_InitSetAdmin");
            Validate.MUST_NotLocked(stdFunctions.initSetAdmin);
            stdFunctions.initSetAdmin   .fetch("InitSetAdmin")
                                        .assignSelector(InitSetAdmin.initSetAdmin.selector)
                                        .dump();
            return stdFunctions.finishProcess(pid);
        }

        function fetch_GetDeps(StdFunctions storage stdFunctions) internal returns(StdFunctions storage) {
            uint pid = stdFunctions.startProcess("fetch_GetDeps");
            Validate.MUST_NotLocked(stdFunctions.getDeps);
            stdFunctions.getDeps.fetch("GetDeps")
                                .assignSelector(GetDeps.getDeps.selector)
                                .dump();
            return stdFunctions.finishProcess(pid);
        }

        function fetch_Clone(StdFunctions storage stdFunctions) internal returns(StdFunctions storage) {
            uint pid = stdFunctions.startProcess("fetch_Clone");
            Validate.MUST_NotLocked(stdFunctions.clone);
            stdFunctions.clone  .fetch("Clone")
                                .assignSelector(Clone.clone.selector)
                                .dump();
            return stdFunctions.finishProcess(pid);
        }


    /**-----------------------------------------------
        🚀 Deploy Standard Functions If Not Exists
        TODO versioning
    -------------------------------------------------*/
    function deployIfNotExists(StdFunctions storage std) internal returns(StdFunctions storage) {
        uint pid = std.startProcess("deployIfNotExists");
        return std  .deployIfNotExists_InitSetAdmin()
                    .deployIfNotExists_GetDeps()
                    .deployIfNotExists_Clone()
                    .finishProcess(pid);
    }
        /**===== Each Std Function =====*/
        function deployIfNotExists_InitSetAdmin(StdFunctions storage std) internal returns(StdFunctions storage) {
            if (std.initSetAdmin.hasNotContract()) {
                std.initSetAdmin.assignImplementation(address(new InitSetAdmin()));
            }
            return std;
        }

        function deployIfNotExists_GetDeps(StdFunctions storage std) internal returns(StdFunctions storage) {
            if (std.getDeps.hasNotContract()) {
                std.getDeps.assignImplementation(address(new GetDeps()));
            }
            return std;
        }

        function deployIfNotExists_Clone(StdFunctions storage std) internal returns(StdFunctions storage) {
            if (std.clone.hasNotContract()) {
                std.clone.assignImplementation(address(new Clone()));
            }
            return std;
        }

}

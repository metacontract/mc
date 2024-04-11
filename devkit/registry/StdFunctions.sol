// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {ProcessLib} from "devkit/utils/debug/ProcessLib.sol";
    using ProcessLib for StdFunctions global;
import {TypeGuard, TypeStatus} from "devkit/types/TypeGuard.sol";
    using TypeGuard for StdFunctions global;
import {Validate} from "devkit/validate/Validate.sol";

// Core Types
import {Function} from "devkit/core/Function.sol";
// MC Std
import {Clone} from "mc-std/functions/Clone.sol";
import {GetDeps} from "mc-std/functions/GetDeps.sol";
import {FeatureToggle} from "mc-std/functions/protected/FeatureToggle.sol";
import {InitSetAdmin} from "mc-std/functions/protected/InitSetAdmin.sol";
import {UpgradeDictionary} from "mc-std/functions/protected/UpgradeDictionary.sol";
import {StdFacade} from "mc-std/interfaces/StdFacade.sol";
// Utils
import {AddressUtils} from "devkit/utils/primitive/AddressUtils.sol";
    using AddressUtils for address;


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
        stdFunctions.initSetAdmin.build().lock();
        stdFunctions.getDeps.build().lock();
        stdFunctions.clone.build().lock();
        return stdFunctions.build().lock().finishProcess(pid);
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
            Validate.notLocked(stdFunctions.initSetAdmin.status);
            stdFunctions.initSetAdmin   .fetch("InitSetAdmin")
                                        .assignSelector(InitSetAdmin.initSetAdmin.selector)
                                        .dump();
            return stdFunctions.finishProcess(pid);
        }

        function fetch_GetDeps(StdFunctions storage stdFunctions) internal returns(StdFunctions storage) {
            uint pid = stdFunctions.startProcess("fetch_GetDeps");
            Validate.notLocked(stdFunctions.getDeps.status);
            stdFunctions.getDeps.fetch("GetDeps")
                                .assignSelector(GetDeps.getDeps.selector)
                                .dump();
            return stdFunctions.finishProcess(pid);
        }

        function fetch_Clone(StdFunctions storage stdFunctions) internal returns(StdFunctions storage) {
            uint pid = stdFunctions.startProcess("fetch_Clone");
            Validate.notLocked(stdFunctions.clone.status);
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
            if (std.initSetAdmin.notExists()) {
                std.initSetAdmin.assignImplementation(address(new InitSetAdmin()));
            }
            return std;
        }

        function deployIfNotExists_GetDeps(StdFunctions storage std) internal returns(StdFunctions storage) {
            if (std.getDeps.notExists()) {
                std.getDeps.assignImplementation(address(new GetDeps()));
            }
            return std;
        }

        function deployIfNotExists_Clone(StdFunctions storage std) internal returns(StdFunctions storage) {
            if (std.clone.notExists()) {
                std.clone.assignImplementation(address(new Clone()));
            }
            return std;
        }

}

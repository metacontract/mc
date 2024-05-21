// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;
/**---------------------
    Support Methods
-----------------------*/
import {Tracer} from "devkit/system/Tracer.sol";
import {TypeGuard, TypeStatus} from "devkit/types/TypeGuard.sol";
// Validation
import {Validator} from "devkit/system/Validator.sol";
import {Logger} from "devkit/system/Logger.sol";

// Core Types
import {Function} from "devkit/core/Function.sol";
// MC Std
import {Clone} from "mc-std/functions/Clone.sol";
import {GetFunctions} from "mc-std/functions/GetFunctions.sol";
import {FeatureToggle} from "mc-std/functions/protected/FeatureToggle.sol";
import {InitSetAdmin} from "mc-std/functions/protected/InitSetAdmin.sol";
import {UpgradeDictionary} from "mc-std/functions/protected/UpgradeDictionary.sol";
import {StdFacade} from "mc-std/interfaces/StdFacade.sol";


//////////////////////////////////////////////////////
//  🏰 Standard Functions    /////////////////////////
    using StdFunctionsLib for StdFunctions global;
    using Tracer for StdFunctions global;
    using TypeGuard for StdFunctions global;
//////////////////////////////////////////////////////
struct StdFunctions {
    Function initSetAdmin;
    Function getFunctions;
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
    function complete(StdFunctions storage std) internal returns(StdFunctions storage) {
        uint pid = std.startProcess("complete");
        std.fetch();
        std.deployIfNotExists();
        std.lock();
        return std.finishProcess(pid);
    }

    /**-----------------------------------------
        📨 Fetch Standard Functions from Env
    -------------------------------------------*/
    function fetch(StdFunctions storage std) internal returns(StdFunctions storage) {
        uint pid = std.startProcess("fetch");
        std.startBuilding();
        std .fetch_InitSetAdmin()
            .fetch_GetFunctions()
            .fetch_Clone();
        std.finishBuilding();
        return std.finishProcess(pid);
    }

        /**===== Each Std Function =====*/
        function fetch_InitSetAdmin(StdFunctions storage std) internal returns(StdFunctions storage) {
            uint pid = std.startProcess("fetch_InitSetAdmin");
            std.initSetAdmin.fetch("InitSetAdmin")
                            .assignSelector(InitSetAdmin.initSetAdmin.selector);
            Logger.logDebug(std.initSetAdmin.toString());
            return std.finishProcess(pid);
        }

        function fetch_GetFunctions(StdFunctions storage std) internal returns(StdFunctions storage) {
            uint pid = std.startProcess("fetch_GetFunctions");
            std.getFunctions .fetch("GetFunctions")
                        .assignSelector(GetFunctions.getFunctions.selector);
            Logger.logDebug(std.getFunctions.toString());
            return std.finishProcess(pid);
        }

        function fetch_Clone(StdFunctions storage std) internal returns(StdFunctions storage) {
            uint pid = std.startProcess("fetch_Clone");
            std.clone   .fetch("Clone")
                        .assignSelector(Clone.clone.selector);
            Logger.logDebug(std.clone.toString());
            return std.finishProcess(pid);
        }


    /**-----------------------------------------------
        🚀 Deploy Standard Functions If Not Exists
        TODO versioning
    -------------------------------------------------*/
    function deployIfNotExists(StdFunctions storage std) internal returns(StdFunctions storage) {
        uint pid = std.startProcess("deployIfNotExists");
        std.startBuilding();
        std .deployIfNotExists_InitSetAdmin()
            .deployIfNotExists_GetFunctions()
            .deployIfNotExists_Clone();
        std.finishBuilding();
        return std.finishProcess(pid);
    }
        /**===== Each Std Function =====*/
        function deployIfNotExists_InitSetAdmin(StdFunctions storage std) internal returns(StdFunctions storage) {
            uint pid = std.startProcess("deployIfNotExists_InitSetAdmin");
            if (std.initSetAdmin.hasNotContract()) {
                std.initSetAdmin.assignImplementation(address(new InitSetAdmin()));
            }
            return std.finishProcess(pid);
        }

        function deployIfNotExists_GetFunctions(StdFunctions storage std) internal returns(StdFunctions storage) {
            uint pid = std.startProcess("deployIfNotExists_GetFunctions");
            if (std.getFunctions.hasNotContract()) {
                std.getFunctions.assignImplementation(address(new GetFunctions()));
            }
            return std.finishProcess(pid);
        }

        function deployIfNotExists_Clone(StdFunctions storage std) internal returns(StdFunctions storage) {
            uint pid = std.startProcess("deployIfNotExists_Clone");
            if (std.clone.hasNotContract()) {
                std.clone.assignImplementation(address(new Clone()));
            }
            return std.finishProcess(pid);
        }

}

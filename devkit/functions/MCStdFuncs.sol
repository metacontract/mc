// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {console2} from "DevKit/common/ForgeHelper.sol";
import {DevUtils} from "DevKit/common/DevUtils.sol";
import {FuncInfo} from "./FuncInfo.sol";
import {BundleInfo} from "./BundleInfo.sol";

// Ops
import {InitSetAdmin} from "~/std/functions/InitSetAdmin.sol";
import {GetDeps} from "~/std/functions/GetDeps.sol";
import {Clone} from "~/std/functions/Clone.sol";
import {SetImplementation} from "~/std/functions/SetImplementation.sol";
import {AllStdsFacade} from "~/std/interfaces/facades/AllStdsFacade.sol";
import {DefaultsFacade} from "~/std/interfaces/facades/DefaultsFacade.sol";


/*****************************************
    🏛 Meta Contract Standard Functions
******************************************/
using MCStdFuncsUtils for MCStdFuncs global;
struct MCStdFuncs {
    FuncInfo initSetAdmin;
    FuncInfo getDeps;
    FuncInfo clone;
    FuncInfo setImplementation;
    BundleInfo allFunctions;
    BundleInfo defaults;
}

library MCStdFuncsUtils {
    using DevUtils for *;
    modifier logProcess(string memory start, string memory end) {
        DevUtils.logProcessStart(start);
        _;
        DevUtils.logProcessFinish(end);
    }

    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        🔏 Assign and Load Standard Functions
        🐣 Deploy Standard Functions If Not Exists
        🧺 Configure Standard Bundles
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

    /**------------------------------------------
        🔏 Assign and Load Standard Functions
    --------------------------------------------*/
    function assignAndLoad(MCStdFuncs storage std) internal
        logProcess("Loading and Assigning FuncInfos... @ MCStdFuncs", "")
        returns(MCStdFuncs storage)
    {
        return std  .assignAndLoad_InitSetAdmin()
                    .assignAndLoad_GetDeps()
                    .assignAndLoad_Clone()
                    .assignAndLoad_SetImplementation();
    }

        /**===== Each Std Function =====*/
        function assignAndLoad_InitSetAdmin(MCStdFuncs storage std) internal returns(MCStdFuncs storage) {
            std.initSetAdmin.safeAssign("INIT_SET_ADMIN")
                            .safeAssign(InitSetAdmin.initSetAdmin.selector)
                            .loadAndAssignImplFromEnv()
                            .emitLog();
            return std;
        }

        function assignAndLoad_GetDeps(MCStdFuncs storage std) internal returns(MCStdFuncs storage) {
            std.getDeps .safeAssign("GET_DEPS")
                        .safeAssign(GetDeps.getDeps.selector)
                        .loadAndAssignImplFromEnv()
                        .emitLog();
            return std;
        }

        function assignAndLoad_Clone(MCStdFuncs storage std) internal returns(MCStdFuncs storage) {
            std.clone   .safeAssign("CLONE")
                        .safeAssign(Clone.clone.selector)
                        .loadAndAssignImplFromEnv()
                        .emitLog();
            return std;
        }

        function assignAndLoad_SetImplementation(MCStdFuncs storage std) internal returns(MCStdFuncs storage) {
            std.setImplementation   .safeAssign("SET_IMPLEMENTATION")
                                    .safeAssign(SetImplementation.setImplementation.selector)
                                    .loadAndAssignImplFromEnv()
                                    .emitLog();
            return std;
        }


    /**-----------------------------------------------
        🐣 Deploy Standard Functions If Not Exists
        TODO versioning
    -------------------------------------------------*/
    function deployIfNotExists(MCStdFuncs storage std) internal
        logProcess("Deploying MCStdFuncs if not exists...", "")
        returns(MCStdFuncs storage)
    {
        return std  .deployIfNotExists_InitSetAdmin()
                    .deployIfNotExists_GetDeps()
                    .deployIfNotExists_Clone()
                    .deployIfNotExists_SetImplementation();
    }

        /**===== Each Std Function =====*/
        function deployIfNotExists_InitSetAdmin(MCStdFuncs storage std) internal returns(MCStdFuncs storage) {
            if (!std.initSetAdmin.implementation.isContract()) {
                std.initSetAdmin.safeAssign(address(new InitSetAdmin())).emitLog();
            }
            return std;
        }

        function deployIfNotExists_GetDeps(MCStdFuncs storage std) internal returns(MCStdFuncs storage) {
            if (!std.getDeps.implementation.isContract()) {
                std.getDeps.safeAssign(address(new GetDeps())).emitLog();
            }
            return std;
        }

        function deployIfNotExists_Clone(MCStdFuncs storage std) internal returns(MCStdFuncs storage) {
            if (!std.clone.implementation.isContract()) {
                std.clone.safeAssign(address(new Clone())).emitLog();
            }
            return std;
        }

        function deployIfNotExists_SetImplementation(MCStdFuncs storage std) internal returns(MCStdFuncs storage) {
            if (!std.setImplementation.implementation.isContract()) {
                std.setImplementation.safeAssign(address(new SetImplementation())).emitLog();
            }
            return std;
        }


    /**----------------------------------
        🧺 Configure Standard Bundles
    ------------------------------------*/
    function configureStdBundle(MCStdFuncs storage std) internal
        logProcess("Configuring StdBundle...", "")
        returns(MCStdFuncs storage)
    {
        return std  .configureStdBundle_AllFunctions()
                    .configureStdBundle_Defaults();
    }

        /**===== Each Std Bundle =====*/
        function configureStdBundle_AllFunctions(MCStdFuncs storage std) internal returns(MCStdFuncs storage) {
            std.allFunctions.safeAssign("ALL_FUNCTIONS")
                            .safeAdd(std.initSetAdmin)
                            .safeAdd(std.getDeps)
                            .safeAdd(std.clone)
                            .safeAdd(std.setImplementation)
                            .safeAssign(address(new AllStdsFacade()))
                            .emitLog();
            return std;
        }

        function configureStdBundle_Defaults(MCStdFuncs storage std) internal returns(MCStdFuncs storage) {
            std.defaults.safeAssign("DEFAULTS")
                        .safeAdd(std.initSetAdmin)
                        .safeAdd(std.getDeps)
                        .safeAssign(address(new DefaultsFacade()))
                        .emitLog();
            return std;
        }


    /**--------------------------------------------
        🔧 Helper Methods for each Standard Functions
    ----------------------------------------------*/
    // function getAllMCStdFuncsFacade(MCStdFuncs storage std) internal returns(address) {
    //     return std.allMCStdFuncs.facade;
    // }
    // function getDefaultMCStdFuncsFacade(MCStdFuncs storage std) internal returns(address) {
    //     return std.defaultOps.facade;
    // }

}


/****************************************************
    🧩 Std Ops Primitive Utils for Arguments
*****************************************************/
library MCStdFuncsArgs {
    function initSetAdminBytes(address admin) internal view returns(bytes memory) {
        return abi.encodeCall(InitSetAdmin.initSetAdmin, admin);
    }

}

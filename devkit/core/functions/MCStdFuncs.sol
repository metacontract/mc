// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Utils
import {console2} from "../../utils/ForgeHelper.sol";
import {AddressUtils} from "../../utils/AddressUtils.sol";
    using AddressUtils for address;
import {StringUtils} from "../../utils/StringUtils.sol";
    using StringUtils for string;
// Debug
import {Debug} from "../../debug/Debug.sol";
import {Logger} from "../../debug/Logger.sol";
// Core
import {FuncInfo} from "./FuncInfo.sol";
import {BundleInfo} from "./BundleInfo.sol";
// MC Std
import {Clone} from "mc-std/functions/Clone.sol";
import {GetDeps} from "mc-std/functions/GetDeps.sol";
import {FeatureToggle} from "mc-std/functions/protected/FeatureToggle.sol";
import {InitSetAdmin} from "mc-std/functions/protected/InitSetAdmin.sol";
import {UpgradeDictionary} from "mc-std/functions/protected/UpgradeDictionary.sol";
import {StdFacade} from "mc-std/interfaces/StdFacade.sol";


/*****************************************
    🏛 Meta Contract Standard Functions
******************************************/
using MCStdFuncsUtils for MCStdFuncs global;
struct MCStdFuncs {
    FuncInfo initSetAdmin;
    FuncInfo getDeps;
    FuncInfo clone;
    BundleInfo allFunctions;
}

library MCStdFuncsUtils {
    string constant LIB_NAME = "MCStdFuncs";
    function recordExecStart(string memory funcName, string memory params) internal returns(uint) {
        return Debug.recordExecStart(LIB_NAME, funcName, params);
    }
    function recordExecStart(string memory funcName) internal returns(uint) {
        return recordExecStart(funcName, "");
    }
    function recordExecFinish(MCStdFuncs storage std, uint pid) internal returns(MCStdFuncs storage) {
        Debug.recordExecFinish(pid);
        return std;
    }

    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        🔏 Assign and Load Standard Functions
        🐣 Deploy Standard Functions If Not Exists
        🧺 Configure Standard Bundles
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

    /**------------------------------------------
        🔏 Assign and Load Standard Functions
    --------------------------------------------*/
    function assignAndLoad(MCStdFuncs storage std) internal returns(MCStdFuncs storage) {
        uint pid = recordExecStart("assignAndLoad");
        return std  .assignAndLoad_InitSetAdmin()
                    .assignAndLoad_GetDeps()
                    .assignAndLoad_Clone()
                    .recordExecFinish(pid);
    }

        /**===== Each Std Function =====*/
        function assignAndLoad_InitSetAdmin(MCStdFuncs storage std) internal returns(MCStdFuncs storage) {
            uint pid = recordExecStart("assignAndLoad_InitSetAdmin");
            std.initSetAdmin.safeAssign("InitSetAdmin")
                            .safeAssign(InitSetAdmin.initSetAdmin.selector)
                            .loadAndAssignFromEnv()
                            .parseAndLog();
            return std.recordExecFinish(pid);
        }

        function assignAndLoad_GetDeps(MCStdFuncs storage std) internal returns(MCStdFuncs storage) {
            uint pid = recordExecStart("assignAndLoad_GetDeps");
            std.getDeps .safeAssign("GetDeps")
                        .safeAssign(GetDeps.getDeps.selector)
                        .loadAndAssignFromEnv()
                        .parseAndLog();
            return std.recordExecFinish(pid);
        }

        function assignAndLoad_Clone(MCStdFuncs storage std) internal returns(MCStdFuncs storage) {
            uint pid = recordExecStart("assignAndLoad_Clone");
            std.clone   .safeAssign("Clone")
                        .safeAssign(Clone.clone.selector)
                        .loadAndAssignFromEnv()
                        .parseAndLog();
            return std.recordExecFinish(pid);
        }


    /**-----------------------------------------------
        🐣 Deploy Standard Functions If Not Exists
        TODO versioning
    -------------------------------------------------*/
    function deployIfNotExists(MCStdFuncs storage std) internal returns(MCStdFuncs storage) {
        uint pid = recordExecStart("deployIfNotExists");
        return std  .deployIfNotExists_InitSetAdmin()
                    .deployIfNotExists_GetDeps()
                    .deployIfNotExists_Clone()
                    .recordExecFinish(pid);
    }

        /**===== Each Std Function =====*/
        function deployIfNotExists_InitSetAdmin(MCStdFuncs storage std) internal returns(MCStdFuncs storage) {
            uint pid = recordExecStart("deployIfNotExists_InitSetAdmin");
            if (std.initSetAdmin.implementation.isNotContract()) {
                std.initSetAdmin.safeAssign(address(new InitSetAdmin()));
            }
            return std.recordExecFinish(pid);
        }

        function deployIfNotExists_GetDeps(MCStdFuncs storage std) internal returns(MCStdFuncs storage) {
            uint pid = recordExecStart("deployIfNotExists_GetDeps");
            if (!std.getDeps.implementation.isContract()) {
                std.getDeps.safeAssign(address(new GetDeps()));
            }
            return std.recordExecFinish(pid);
        }

        function deployIfNotExists_Clone(MCStdFuncs storage std) internal returns(MCStdFuncs storage) {
            uint pid = recordExecStart("deployIfNotExists_Clone");
            if (!std.clone.implementation.isContract()) {
                std.clone.safeAssign(address(new Clone()));
            }
            return std.recordExecFinish(pid);
        }


    /**----------------------------------
        🧺 Configure Standard Bundles
    ------------------------------------*/
    function configureStdBundle(MCStdFuncs storage std) internal returns(MCStdFuncs storage) {
        uint pid = recordExecStart("configureStdBundle");
        return std  .configureStdBundle_AllFunctions()
                    .recordExecFinish(pid);
    }

        /**===== Each Std Bundle =====*/
        function configureStdBundle_AllFunctions(MCStdFuncs storage std) internal returns(MCStdFuncs storage) {
            uint pid = recordExecStart("configureStdBundle_AllFunctions");
            std.allFunctions.safeAssign("ALL_FUNCTIONS")
                            .safeAdd(std.initSetAdmin)
                            .safeAdd(std.getDeps)
                            .safeAdd(std.clone)
                            .safeAssign(address(new StdFacade()));
            return std.recordExecFinish(pid);
        }

}


/****************************************************
    🧩 Std Ops Primitive Utils for Arguments
*****************************************************/
library MCStdFuncsArgs {
    function initSetAdminBytes(address admin) internal view returns(bytes memory) {
        return abi.encodeCall(InitSetAdmin.initSetAdmin, admin);
    }

}

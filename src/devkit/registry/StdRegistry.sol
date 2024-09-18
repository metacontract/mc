// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;
/**---------------------
    Support Methods
-----------------------*/
import {Tracer} from "devkit/system/Tracer.sol";
import {TypeGuard, TypeStatus} from "devkit/types/TypeGuard.sol";
// Validation
import {Validator} from "devkit/system/Validator.sol";

// Core Types
import {Function} from "devkit/core/Function.sol";
import {Bundle} from "devkit/core/Bundle.sol";
import {StdFunctions} from "devkit/registry/StdFunctions.sol";
// MC Std
import {Clone} from "mc-std/functions/Clone.sol";
import {GetFunctions} from "mc-std/functions/GetFunctions.sol";
import {FeatureToggle} from "mc-std/functions/protected/FeatureToggle.sol";
import {InitSetAdmin} from "mc-std/functions/protected/InitSetAdmin.sol";
import {UpgradeDictionary} from "mc-std/functions/protected/UpgradeDictionary.sol";
import {StdFacade} from "mc-std/interfaces/StdFacade.sol";


////////////////////////////////////////////////////
//  🏛 Standard Registry    ////////////////////////
    using StdRegistryLib for StdRegistry global;
    using Tracer for StdRegistry global;
    using TypeGuard for StdRegistry global;
////////////////////////////////////////////////////
struct StdRegistry {
    StdFunctions functions;
    Bundle all;
    TypeStatus status;
}
library StdRegistryLib {

    /**----------------------------------
        🟢 Complete Standard Registry
    ------------------------------------*/
    function complete(StdRegistry storage registry) internal returns(StdRegistry storage) {
        uint pid = registry.startProcess("complete");
        registry.functions.complete();
        registry.configureStdBundle();
        registry.lock();
        return registry.finishProcess(pid);
    }

    /**----------------------------------
        🔧 Configure Standard Bundles
    ------------------------------------*/
    function configureStdBundle(StdRegistry storage registry) internal returns(StdRegistry storage) {
        uint pid = registry.startProcess("configureStdBundle");
        registry.startBuilding();
        registry.configureStdBundle_All();
        registry.finishBuilding();
        return registry.finishProcess(pid);
    }
        /**===== Each Std Bundle =====*/
        function configureStdBundle_All(StdRegistry storage registry) internal returns(StdRegistry storage) {
            uint pid = registry.startProcess("configureStdBundle_All");
            registry.all.assignName("ALL_STD_FUNCTIONS")
                        .pushFunction(registry.functions.initSetAdmin)
                        .pushFunction(registry.functions.getFunctions)
                        .pushFunction(registry.functions.clone)
                        .assignFacade(address(new StdFacade()));
            return registry.finishProcess(pid);
        }

}


/****************************************************
    🧩 Std Ops Primitive Utils for Arguments
*****************************************************/
library StdFunctionsArgs {
    function initSetAdminBytes(address admin) internal pure returns(bytes memory) {
        return abi.encodeCall(InitSetAdmin.initSetAdmin, admin);
    }

}

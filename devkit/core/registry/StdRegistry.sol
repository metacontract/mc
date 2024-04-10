// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core Types
import {Function} from "devkit/core/types/Function.sol";
import {Bundle} from "devkit/core/types/Bundle.sol";
// Support Method
import {ProcessLib} from "devkit/core/method/debug/ProcessLib.sol";
    using ProcessLib for StdRegistry global;
import {TypeGuard, TypeStatus} from "devkit/core/types/TypeGuard.sol";
    using TypeGuard for StdRegistry global;
// MC Std
import {Clone} from "mc-std/functions/Clone.sol";
import {GetDeps} from "mc-std/functions/GetDeps.sol";
import {FeatureToggle} from "mc-std/functions/protected/FeatureToggle.sol";
import {InitSetAdmin} from "mc-std/functions/protected/InitSetAdmin.sol";
import {UpgradeDictionary} from "mc-std/functions/protected/UpgradeDictionary.sol";
import {StdFacade} from "mc-std/interfaces/StdFacade.sol";
// Loader
import {loadAddressFrom} from "devkit/utils/ForgeHelper.sol";
// Utils
import {AddressUtils} from "devkit/utils/AddressUtils.sol";
    using AddressUtils for address;

import {StdFunctions} from "devkit/core/registry/StdFunctions.sol";
import {StdBundle} from "devkit/core/registry/StdBundle.sol";


/**==========================
    🏛 Standard Registry
============================*/
using StdRegistryLib for StdRegistry global;
struct StdRegistry {
    StdFunctions functions;
    StdBundle bundle;
}
library StdRegistryLib {
    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        🔏 Assign and Load Standard Functions
        🐣 Deploy Standard Functions If Not Exists
        🧺 Configure Standard Bundles
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
    function complete(StdRegistry storage registry) internal returns(StdRegistry storage) {
        uint pid = registry.startProcess("complete");
        registry.functions.complete();
        registry.configureStdBundle();
        return registry.finishProcess(pid);
    }

    /**----------------------------------
        🧺 Configure Standard Bundles
    ------------------------------------*/
    function configureStdBundle(StdRegistry storage registry) internal returns(StdRegistry storage) {
        uint pid = registry.startProcess("configureStdBundle");
        return registry  .configureStdBundle_AllFunctions()
                    .finishProcess(pid);
    }

        /**===== Each Std Bundle =====*/
        function configureStdBundle_AllFunctions(StdRegistry storage registry) internal returns(StdRegistry storage) {
            uint pid = registry.startProcess("configureStdBundle_AllFunctions");
            registry.bundle.all .assignName("ALL_FUNCTIONS")
                    .pushFunction(registry.functions.initSetAdmin)
                    .pushFunction(registry.functions.getDeps)
                    .pushFunction(registry.functions.clone)
                    .assignFacade(address(new StdFacade()))
                    .build();
            return registry.finishProcess(pid);
        }

}


/****************************************************
    🧩 Std Ops Primitive Utils for Arguments
*****************************************************/
library StdFunctionsArgs {
    function initSetAdminBytes(address admin) internal view returns(bytes memory) {
        return abi.encodeCall(InitSetAdmin.initSetAdmin, admin);
    }

}

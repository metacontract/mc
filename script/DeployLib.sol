// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {MCDevKit} from "@mc-devkit/Flattened.sol";
import {StdFacade} from "@mc-std/interfaces/StdFacade.sol";
import {InitSetAdmin} from "@mc-std/functions/protected/InitSetAdmin.sol";

library DeployLib {
    using DeployLib for MCDevKit;

    string internal constant BUNDLE_NAME = "Std";

    function deployStd(MCDevKit storage mc, address admin) internal returns (address) {
        for (uint256 i; i < mc.std.all.functions.length; ++i) {
            mc.use(mc.std.all.functions[i]);
        }
        mc.useFacade(address(new StdFacade()));
        bytes memory initData = abi.encodeCall(InitSetAdmin.initSetAdmin, admin);
        return mc.deploy(initData).toProxyAddress();
    }

    function deployStdFunctions(MCDevKit storage mc) internal returns (MCDevKit storage) {
        mc.std.functions.deployIfNotExists();
        return mc;
    }

    function deployStdDictionary(MCDevKit storage mc) internal returns (MCDevKit storage) {
        mc.std.complete();
        mc.deployDictionary(mc.std.all);
        return mc;
    }
}

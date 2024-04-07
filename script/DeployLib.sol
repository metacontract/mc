// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKit} from "devkit/MCDevKit.sol";
import {StdFunctions} from "devkit/core/functions/StdFunctions.sol";

library DeployLib {
    using DeployLib for MCDevKit;
    string internal constant BUNDLE_NAME = "Std";

    function deployStdFunctions(MCDevKit storage mc) internal returns(MCDevKit storage) {
        mc.functions.std.deployIfNotExists();
        return mc;
    }

    function deployStdDictionary(MCDevKit storage mc) internal returns(MCDevKit storage) {
        mc.deployStdFunctions();
        mc.deployDictionary(mc.functions.std.all);
        return mc;
    }
}

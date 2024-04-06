// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKit} from "devkit/global/MCDevKit.sol";
import {StdFunctions} from "devkit/ucs/functions/StdFunctions.sol";


using DeployLib for MCDevKit;
library DeployLib {
    string internal constant BUNDLE_NAME = "Std";

    function deployStdIfNotExists(MCDevKit storage mc) internal {
        mc.functions.std.deployIfNotExists();
    }

    function deployStdDictionary(MCDevKit storage mc) internal returns(MCDevKit storage) {
        mc.deployStdIfNotExists();
        mc.deployDictionary(mc.functions.std.all);
        return mc;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKit} from "devkit/MCDevKit.sol";

using DeployLib for MCDevKit;
library DeployLib {
    // function bundleName() internal returns(string memory) {
    //     return "Std";
    // }

    function deployStd(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return mc.setupStdFuncs();
    }

    function deployStdDictionary(MCDevKit storage mc) internal returns(MCDevKit storage) {
        mc.deployStd();
        mc.deployDictionary(mc.functions.std.all);
        return mc;
    }
}

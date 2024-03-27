// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {MCDevKit} from "devkit/MCDevKit.sol";

library DeployLib {
    // function bundleName() internal returns(string memory) {
    //     return "Std";
    // }

    function deployStd(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return mc.setupMCStdFuncs();
    }

    function deployStdDictionary(MCDevKit storage mc) internal returns(MCDevKit storage) {
        mc.functions.std.assignAndLoad();
        mc.functions.std.deployIfNotExists();
        mc.functions.std.configureStdBundle();
        mc.deployDictionary();
        mc.set(mc.functions.std.allFunctions);
        mc.upgradeFacade();
        return mc;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKitTest} from "test/devkit/MCDevKitTest.sol";

import {FuncInfo} from "devkit/core/functions/FuncInfo.sol";
import {TestHelper} from "test/utils/TestHelper.sol";
    using TestHelper for FuncInfo;

contract DevKitTest_MCSetup is MCDevKitTest {

    function test_Success_setupStdFuncs() public {
        mc.setupStdFuncs();

        assertTrue(mc.functions.std.initSetAdmin.isInitSetAdmin());
        assertTrue(mc.functions.std.getDeps.isGetDeps());
        assertTrue(mc.functions.std.clone.isClone());

        assertTrue(mc.functions.std.all.functionInfos.length == 3);
        assertTrue(mc.functions.std.all.functionInfos[0].isInitSetAdmin());
        assertTrue(mc.functions.std.all.functionInfos[1].isGetDeps());
        assertTrue(mc.functions.std.all.functionInfos[2].isClone());
    }

}
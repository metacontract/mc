// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKitTest} from "devkit/MCTest.sol";

import {Function} from "devkit/core/Function.sol";
import {TestHelper} from "test/utils/TestHelper.sol";
    using TestHelper for Function;

contract DevKitTest_MCSetup is MCDevKitTest {

    /**----------------------------
        🧩 Setup Standard Funcs
    ------------------------------*/
    function test_Success_setupStdFuncs() public {
        mc.setupStdFunctions();

        assertTrue(mc.std.initSetAdmin.isInitSetAdmin());
        assertTrue(mc.std.getDeps.isGetDeps());
        assertTrue(mc.std.clone.isClone());

        assertTrue(mc.std.all.functions.length == 3);
        assertTrue(mc.std.all.functions[0].isInitSetAdmin());
        assertTrue(mc.std.all.functions[1].isGetDeps());
        assertTrue(mc.std.all.functions[2].isClone());
    }

}

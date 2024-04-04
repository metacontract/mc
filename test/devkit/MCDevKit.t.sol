// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console2} from "forge-std/Test.sol";
import {MCDevKit, FuncInfo} from "devkit/MCDevKit.sol";

import {TestHelper} from "../utils/TestHelper.sol";
    using TestHelper for FuncInfo;

contract MCDevKitTest is Test {
    MCDevKit internal mc;

    function test_Success_setupStdFuncs() public {
        mc.setupStdFuncs();

        assertTrue(mc.functions.std.initSetAdmin.isInitSetAdmin());
        assertTrue(mc.functions.std.getDeps.isGetDeps());
        assertTrue(mc.functions.std.clone.isClone());

        assertTrue(mc.functions.std.allFunctions.functionInfos.length == 3);
        assertTrue(mc.functions.std.allFunctions.functionInfos[0].isInitSetAdmin());
        assertTrue(mc.functions.std.allFunctions.functionInfos[1].isGetDeps());
        assertTrue(mc.functions.std.allFunctions.functionInfos[2].isClone());
    }
}

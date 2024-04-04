// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console2} from "forge-std/Test.sol";
import {MCDevKit} from "devkit/MCDevKit.sol";
import {FuncInfo} from "devkit/core/functions/FuncInfo.sol";

import {TestHelper} from "../utils/TestHelper.sol";
    using TestHelper for FuncInfo;
import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;

contract MCDevKitTest is Test {
    MCDevKit internal mc;
    function setUp() public {
        mc.stopLog();
    }

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

    function test_Success_init_withName() public {
        string memory name = "TestBundleName";
        mc.init(name);

        assertTrue(mc.functions.bundles[name.safeCalcHash()].name.isEqual(name));
        assertTrue(mc.functions.currentBundleName.isEqual(name));
    }
}

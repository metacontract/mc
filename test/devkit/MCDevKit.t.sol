// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console2} from "forge-std/Test.sol";
import {MCDevKit} from "devkit/MCDevKit.sol";
import {Function} from "devkit/core/types/Function.sol";

import {TestHelper} from "../utils/TestHelper.sol";
    using TestHelper for Function;
import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;

contract MCDevKitTest is Test {
    MCDevKit internal mc;
    function setUp() public {
        mc.stopLog();
    }

    function test_Success_setupStdFunctions() public {
        mc.setupStdFunctions();

        assertTrue(mc.std.initSetAdmin.isInitSetAdmin());
        assertTrue(mc.std.getDeps.isGetDeps());
        assertTrue(mc.std.clone.isClone());

        assertTrue(mc.std.all.functions.length == 3);
        assertTrue(mc.std.all.functions[0].isInitSetAdmin());
        assertTrue(mc.std.all.functions[1].isGetDeps());
        assertTrue(mc.std.all.functions[2].isClone());
    }

    function test_Success_init_withName() public {
        string memory name = "TestBundleName";
        mc.init(name);

        assertTrue(mc.bundle.bundles[name].name.isEqual(name));
        assertTrue(mc.bundle.current.name.isEqual(name));
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKitTest} from "devkit/MCTest.sol";

import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;
import {Config} from "devkit/config/Config.sol";

contract DevKitTest_MCBundle is MCDevKitTest {
    /**---------------------------
        🌱 Init Custom Bundle
    -----------------------------*/
    function test_Success_init_withName() public {
        string memory name = "TestBundleName";
        mc.init(name);

        assertTrue(mc.functions.bundles[name.safeCalcHash()].name.isEqual(name));
        assertTrue(mc.functions.currentBundleName.isEqual(name));
    }

    // verify genUniqueBundleName
    // function test_Success_init_withoutName() public {}

    function test_Success_ensureInit_beforeInit() public {
        string memory name = mc.functions.genUniqueBundleName();

        mc.ensureInit();

        assertTrue(mc.functions.bundles[name.safeCalcHash()].name.isEqual(name));
        assertTrue(mc.functions.currentBundleName.isEqual(name));
    }

    function test_Success_ensureInit_afterInit() public {
        string memory name = mc.functions.genUniqueBundleName();

        mc.init();

        assertTrue(mc.functions.bundles[name.safeCalcHash()].name.isEqual(name));
        assertTrue(mc.functions.currentBundleName.isEqual(name));

        string memory name2 = mc.functions.genUniqueBundleName();
        mc.ensureInit();

        assertTrue(mc.functions.bundles[name2.safeCalcHash()].name.isEmpty());
        assertTrue(mc.functions.currentBundleName.isEqual(name));
    }


    /**---------------------
        🔗 Use Function
    -----------------------*/
    /**------------------
        🪟 Use Facade
    --------------------*/
}

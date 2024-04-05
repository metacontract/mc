// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKitTest} from "test/devkit/MCDevKitTest.sol";

import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;

contract DevKitTest_MCBundle is MCDevKitTest {

    function test_Success_init_withName() public {
        string memory name = "TestBundleName";
        mc.init(name);

        assertTrue(mc.functions.bundles[name.safeCalcHash()].name.isEqual(name));
        assertTrue(mc.functions.currentBundleName.isEqual(name));
    }

}

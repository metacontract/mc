// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCTestBase} from "devkit/MCBase.sol";

import {Inspector} from "devkit/types/Inspector.sol";
    using Inspector for string;

import {MessageHead as HEAD} from "devkit/system/message/MessageHead.sol";

contract MCHelpersTest is MCTestBase {
    /**-----------------------------
        ♻️ Reset Current Context
    -------------------------------*/
    function test_reset_Success() public {
        mc.functions.current.name = "Current Function";
        mc.bundle.current.name = "Current Bundle";
        mc.dictionary.current.name = "Current Dictionary";
        mc.proxy.current.name = "Current Proxy";

        mc.reset();

        assertTrue(mc.functions.current.name.isEmpty());
        assertTrue(mc.bundle.current.name.isEmpty());
        assertTrue(mc.dictionary.current.name.isEmpty());
        assertTrue(mc.proxy.current.name.isEmpty());
    }

}

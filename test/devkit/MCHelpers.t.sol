// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {
    MCTestBase,
    MessageHead as HEAD,
    Inspector
} from "devkit/Flattened.sol";

contract MCHelpersTest is MCTestBase {
    using Inspector for string;

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

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {
    MCTestBase,
    MessageHead as HEAD,
    Inspector,
    Bundle,
    Function,
    DummyFunction,
    DummyFacade
} from "devkit/Flattened.sol";

contract MCMockLibTest is MCTestBase {
    using Inspector for string;

    function setUp() public {
        mc.setupStdFunctions();
    }

    /**-----------------------------
        🌞 Mocking Meta Contract
    -------------------------------*/

    /**---------------------
        🏠 Mocking Proxy
    -----------------------*/
    function test_createMockProxy_Success() public {
        string memory name = mc.proxy.genUniqueMockName(mc.std.all.name);

        address proxy = mc.createMockProxy(mc.std.all).addr;

        assertTrue(mc.proxy.find(name).isComplete());
        assertEq(mc.proxy.findCurrent().addr, proxy);
    }

    /**-------------------------
        📚 Mocking Dictionary
    ---------------------------*/
    function test_createMockDictionary_Success() public {
        string memory name = mc.dictionary.genUniqueMockName(mc.std.all.name);

        address dictionary = mc.createMockDictionary(mc.std.all).addr;

        assertTrue(mc.dictionary.find(name).isVerifiable());
        assertTrue(mc.dictionary.find(name).isComplete());
        assertEq(mc.dictionary.findCurrent().addr, dictionary);
    }

}

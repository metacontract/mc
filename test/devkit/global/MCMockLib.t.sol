// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCTestBase} from "devkit/MCBase.sol";

import {Inspector} from "devkit/types/Inspector.sol";
    using Inspector for string;

import {Formatter} from "devkit/types/Formatter.sol";
    using Formatter for string;
import {MessageHead as HEAD} from "devkit/system/message/MessageHead.sol";

import {Bundle} from "devkit/core/Bundle.sol";
import {Function} from "devkit/core/Function.sol";
import {DummyFunction} from "devkit/test/dummy/DummyFunction.sol";
import {DummyFacade} from "devkit/test/dummy/DummyFacade.sol";

contract MCMockLibTest is MCTestBase {
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

        // (bool success, bytes memory ret) = dictionary.call(abi.encodeWithSignature("getImplementation(bytes4)", selector));
        // assertTrue(success);
        // assertEq(address(uint160(uint256(bytes32(ret)))), impl);
        // string memory name = "TestBundleName";
        // mc.init(name);
        // mc.use(DummyFunction.dummy.selector, address(new DummyFunction()));
        // mc.useFacade(address(new DummyFacade()));

        // address proxy = mc.deploy().toProxyAddress();

        // assertTrue(mc.dictionary.find(name).isVerifiable());
        // assertTrue(mc.dictionary.find(name).isComplete());
        // assertTrue(mc.proxy.find(name).isComplete());

        // (bool success,) = proxy.call(abi.encodeWithSelector(DummyFunction.dummy.selector));
        // assertTrue(success);
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

        // (bool success, bytes memory ret) = dictionary.call(abi.encodeWithSignature("getImplementation(bytes4)", selector));
        // assertTrue(success);
        // assertEq(address(uint160(uint256(bytes32(ret)))), impl);
        // string memory name = "TestBundleName";
        // mc.init(name);
        // mc.use(DummyFunction.dummy.selector, address(new DummyFunction()));
        // mc.useFacade(address(new DummyFacade()));

        // address proxy = mc.deploy().toProxyAddress();

        // assertTrue(mc.dictionary.find(name).isVerifiable());
        // assertTrue(mc.dictionary.find(name).isComplete());
        // assertTrue(mc.proxy.find(name).isComplete());

        // (bool success,) = proxy.call(abi.encodeWithSelector(DummyFunction.dummy.selector));
        // assertTrue(success);
    }

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKitTest} from "devkit/MCTest.sol";

import {Inspector} from "devkit/types/Inspector.sol";
    using Inspector for string;

import {Formatter} from "devkit/types/Formatter.sol";
    using Formatter for string;
import {MessageHead as HEAD} from "devkit/system/message/MessageHead.sol";

import {Bundle} from "devkit/core/Bundle.sol";
import {Function} from "devkit/core/Function.sol";
import {DummyFunction} from "test/utils/DummyFunction.sol";
import {DummyFacade} from "test/utils/DummyFacade.sol";

contract DevKitTest_MCDeploy is MCDevKitTest {
    /**-----------------------------
        🌞 Deploy Meta Contract
    -------------------------------*/
    function test_deploy_Success() public {
        string memory name = "TestBundleName";
        mc.init(name);
        mc.use(DummyFunction.dummy.selector, address(new DummyFunction()));
        mc.useFacade(address(new DummyFacade()));

        address proxy = mc.deploy().toProxyAddress();

        assertTrue(mc.dictionary.find(name).isVerifiable());
        assertTrue(mc.dictionary.find(name).isComplete());
        assertTrue(mc.proxy.find(name).isComplete());

        (bool success,) = proxy.call(abi.encodeWithSelector(DummyFunction.dummy.selector));
        assertTrue(success);
    }

    /**---------------------
        🏠 Deploy Proxy
    -----------------------*/
    function test_deployProxy_Success() public {
        string memory name = "TestBundleName";
        mc.init(name);
        mc.use(DummyFunction.dummy.selector, address(new DummyFunction()));
        mc.useFacade(address(new DummyFacade()));
        mc.deployDictionary();

        address proxy = mc.deployProxy().addr;

        assertTrue(mc.proxy.find(name).isComplete());

        (bool success,) = proxy.call(abi.encodeWithSelector(DummyFunction.dummy.selector));
        assertTrue(success);
    }

    /**-------------------------
        📚 Deploy Dictionary
    ---------------------------*/
    function test_deployDictionary_Success() public {
        string memory name = "TestBundleName";
        bytes4 selector = DummyFunction.dummy.selector;
        address impl = address(new DummyFunction());
        mc.init(name);
        mc.use(selector, impl);
        mc.useFacade(address(new DummyFacade()));

        address dictionary = mc.deployDictionary().addr;

        assertTrue(mc.dictionary.find(name).isVerifiable());
        assertTrue(mc.dictionary.find(name).isComplete());
        assertEq(mc.dictionary.findCurrent().addr, dictionary);

        (bool success, bytes memory ret) = dictionary.call(abi.encodeWithSignature("getImplementation(bytes4)", selector));
        assertTrue(success);
        assertEq(address(uint160(uint256(bytes32(ret)))), impl);
    }

    /**----------------------------
        🔂 Duplicate Dictionary
    ------------------------------*/
    function test_duplicateDictionary_Success() public {
        string memory name = "TestBundleName";
        bytes4 selector = DummyFunction.dummy.selector;
        address impl = address(new DummyFunction());
        mc.init(name);
        mc.use(selector, impl);
        mc.useFacade(address(new DummyFacade()));
        mc.deployDictionary().addr;
        string memory duplicatedDictionaryName = mc.dictionary.genUniqueName(name);

        address dictionary = mc.duplicateDictionary().addr;

        assertTrue(mc.dictionary.find(duplicatedDictionaryName).isVerifiable());
        assertTrue(mc.dictionary.find(duplicatedDictionaryName).isComplete());
        assertEq(mc.dictionary.findCurrent().addr, dictionary);

        (bool success, bytes memory ret) = dictionary.call(abi.encodeWithSignature("getImplementation(bytes4)", selector));
        assertTrue(success);
        assertEq(address(uint160(uint256(bytes32(ret)))), impl);
    }

    /**------------------------
        💽 Load Dictionary
    --------------------------*/
    function test_loadDictionary_Success() public {
        string memory name = "TestBundleName";
        bytes4 selector = DummyFunction.dummy.selector;
        address impl = address(new DummyFunction());
        mc.init(name);
        mc.use(selector, impl);
        mc.useFacade(address(new DummyFacade()));
        address mockDictionary = mc.createMockDictionary().addr;

        address dictionary = mc.loadDictionary("LoadedDictionary", mockDictionary).addr;

        assertTrue(mc.dictionary.find("LoadedDictionary").isVerifiable());
        assertTrue(mc.dictionary.find("LoadedDictionary").isComplete());
        assertEq(mc.dictionary.findCurrent().addr, dictionary);

        (bool success, bytes memory ret) = dictionary.call(abi.encodeWithSignature("getImplementation(bytes4)", selector));
        assertTrue(success);
        assertEq(address(uint160(uint256(bytes32(ret)))), impl);
    }

}

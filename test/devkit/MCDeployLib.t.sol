// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {MCTestBase, Dummy} from "devkit/Flattened.sol";

contract MCDeployLibTest is MCTestBase {
    /**-----------------------------
        🌞 Deploy Meta Contract
    -------------------------------*/
    function test_deploy_Success() public {
        string memory name = Dummy.bundleName();
        bytes4 selector = Dummy.functionSelector();
        mc.init(name);
        mc.use(selector, Dummy.functionAddress());
        mc.useFacade(Dummy.facadeAddress());

        address proxy = mc.deploy().toProxyAddress();

        assertTrue(mc.dictionary.find(name).isVerifiable());
        assertTrue(mc.dictionary.find(name).isComplete());
        assertTrue(mc.proxy.find(name).isComplete());

        (bool success,) = proxy.call(abi.encodeWithSelector(selector));
        assertTrue(success);
    }

    /**---------------------
        🏠 Deploy Proxy
    -----------------------*/
    function test_deployProxy_Success() public {
        string memory name = Dummy.bundleName();
        bytes4 selector = Dummy.functionSelector();
        mc.init(name);
        mc.use(selector, Dummy.functionAddress());
        mc.useFacade(Dummy.facadeAddress());
        mc.deployDictionary();

        address proxy = mc.deployProxy().addr;

        assertTrue(mc.proxy.find(name).isComplete());

        (bool success,) = proxy.call(abi.encodeWithSelector(selector));
        assertTrue(success);
    }

    /**-------------------------
        📚 Deploy Dictionary
    ---------------------------*/
    function test_deployDictionary_Success() public {
        string memory name = Dummy.bundleName();
        bytes4 selector = Dummy.functionSelector();
        address impl = Dummy.functionAddress();
        mc.init(name);
        mc.use(selector, impl);
        mc.useFacade(Dummy.facadeAddress());

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
        string memory name = Dummy.bundleName();
        bytes4 selector = Dummy.functionSelector();
        address impl = Dummy.functionAddress();
        mc.init(name);
        mc.use(selector, impl);
        mc.useFacade(Dummy.facadeAddress());
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
        string memory name = Dummy.bundleName();
        bytes4 selector = Dummy.functionSelector();
        address impl = Dummy.functionAddress();
        mc.init(name);
        mc.use(selector, impl);
        mc.useFacade(Dummy.facadeAddress());
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

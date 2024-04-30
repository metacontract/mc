// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
// Validation
import {Validator} from "devkit/system/Validator.sol";

import {MCDevKit} from "devkit/MCDevKit.sol";
import {System} from "devkit/system/System.sol";
// Utils
import {param} from "devkit/system/Tracer.sol";
import {ForgeHelper} from "devkit/utils/ForgeHelper.sol";
// Core
//  functions
import {Bundle} from "devkit/core/Bundle.sol";
import {Function} from "devkit/core/Function.sol";
//  proxy
import {Proxy, ProxyLib} from "devkit/core/Proxy.sol";
//  dictionary
import {Dictionary, DictionaryLib} from "devkit/core/Dictionary.sol";


/******************************************
    🧪 Test
        🌞 Mocking Meta Contract
        🏠 Mocking Proxy
        📚 Mocking Dictionary
        🤲 Set Storage Reader
*******************************************/
library MCTestLib {
    /**-----------------------------
        🌞 Mocking Meta Contract
    -------------------------------*/
    function createMock(MCDevKit storage mc, Bundle storage bundle) internal returns(MCDevKit storage) {
        uint pid = mc.startProcess("createMock", param(bundle));
        createProxySimpleMock(mc, bundle);
        return mc.finishProcess(pid);
    }
    function createMock(MCDevKit storage mc, Function storage func) internal returns(MCDevKit storage) {
        uint pid = mc.startProcess("createMock", param(func));
        Function[] memory funcs = new Function[](1);
        funcs[0] = func;
        createProxySimpleMock(mc, funcs);
        return mc.finishProcess(pid);
    }


    /**---------------------
        🏠 Mocking Proxy
    -----------------------*/
    /**
        @notice Creates a SimpleMockProxy as a MockProxy
        @param name The name of the MockProxy, used as a key in the `mc.test.mockProxies` mapping and as a label name in the Forge test runner. If not provided, sequential default names from `MockProxy0` to `MockProxy4` will be used.
        @param functions The function contract infos to be registered with the SimpleMockProxy. A bundle can also be specified. Note that the SimpleMockProxy cannot have its functions changed later. If no functions are provided, defaultBundle will be used.
    */
    function createProxySimpleMock(MCDevKit storage mc, string memory name, Function[] memory functions) internal returns(MCDevKit storage) {
        uint pid = mc.startProcess("createProxySimpleMock", param(name, functions));
        Validator.MUST_NotEmptyName(name);
        // TODO Check Functions?
        Proxy memory proxyMock = ProxyLib.createSimpleMock(functions);
        mc.proxy.register(name, proxyMock);
        return mc.finishProcess(pid);
    }
    function createProxySimpleMock(MCDevKit storage mc, string memory name, Bundle storage bundle) internal returns(MCDevKit storage) {
        return createProxySimpleMock(mc, name, bundle.functions);
    }
    function createProxySimpleMock(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        return createProxySimpleMock(mc, name, mc.std.all);
    }
    function createProxySimpleMock(MCDevKit storage mc, Function[] memory functions) internal returns(MCDevKit storage) {
        return createProxySimpleMock(mc, mc.proxy.genUniqueMockName(), functions);
    }
    function createProxySimpleMock(MCDevKit storage mc, Bundle memory bundle) internal returns(MCDevKit storage) {
        return createProxySimpleMock(mc, mc.proxy.genUniqueMockName(), bundle.functions);
    }
    function createProxySimpleMock(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return createProxySimpleMock(mc, mc.proxy.genUniqueMockName(), mc.std.all);
    }


    /**-------------------------
        📚 Mocking Dictionary
    ---------------------------*/
    function createMockDictionary(MCDevKit storage mc, Bundle storage bundle, address owner) internal returns(Dictionary storage mockDictionary) {
        uint pid = mc.startProcess("createMockDictionary", param(bundle, owner));
        Validator.MUST_Completed(bundle);
        Validator.SHOULD_OwnerIsNotZeroAddress(owner);
        Dictionary memory _mockDictionary = DictionaryLib
                                                .createMock(bundle, owner)
                                                .assignName(mc.dictionary.genUniqueMockName(bundle.name));
        mockDictionary = mc.dictionary.register(_mockDictionary);
        mc.finishProcess(pid);
    }
    // With Default Value
    function createMockDictionary(MCDevKit storage mc) internal returns(Dictionary storage mockDictionary) {
        uint pid = mc.startProcess("createMockDictionary");
        mockDictionary = mc.createMockDictionary(mc.bundle.findCurrent(), ForgeHelper.msgSender());
        mc.finishProcess(pid);
    }
    function createMockDictionary(MCDevKit storage mc, Bundle storage bundle) internal returns(Dictionary storage mockDictionary) {
        uint pid = mc.startProcess("createMockDictionary", param(bundle));
        mockDictionary = mc.createMockDictionary(bundle, ForgeHelper.msgSender());
        mc.finishProcess(pid);
    }
    function createMockDictionary(MCDevKit storage mc, address owner) internal returns(Dictionary storage mockDictionary) {
        uint pid = mc.startProcess("createMockDictionary", param(owner));
        mockDictionary = mc.createMockDictionary(mc.bundle.findCurrent(), owner);
        mc.finishProcess(pid);
    }


    /**--------------------------
        🤲 Set Storage Reader
    ----------------------------*/
    function setStorageReader(MCDevKit storage mc, Dictionary memory dictionary, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
        uint pid = mc.startProcess("setStorageReader", param(dictionary, selector, implementation));
        dictionary.set(selector, implementation);
        return mc.finishProcess(pid);
    }
    function setStorageReader(MCDevKit storage mc, string memory bundleName, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
        return mc.setStorageReader(mc.dictionary.find(bundleName), selector, implementation);
    }
    function setStorageReader(MCDevKit storage mc, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
        return mc.setStorageReader(mc.dictionary.findCurrent(), selector, implementation);
    }

}

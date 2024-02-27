// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {UCSTestEnv, Proxy, MockProxy, MockDictionary, Op} from "dev-env/UCSDevEnv.sol";
// import {MockProxy, MockProxyUtils} from "dev-env/test/MockUtils.sol";
// import {MockProxy as MockProxyContract} from "dev-env/test/mocks/MockProxy.sol";
import {ForgeHelper, vm, console2} from "dev-env/common/ForgeHelper.sol";
import {DevUtils} from "dev-env/common/DevUtils.sol";
import {MockProxyUtils} from "dev-env/proxy/MockProxyUtils.sol";
import {MockDictionaryUtils} from "dev-env/dictionary/MockDictionaryUtils.sol";

import {ERC7546Utils} from "@ucs-contracts/src/proxy/ERC7546Utils.sol";

/******************************************
    🧪 Test Environment Utils
        🏠 for Mock Proxy
        📚 for Mock Dictionary

*******************************************/
library UCSTestEnvUtils {
    /**----------------------
        🏠 for Mock Proxy
    ------------------------*/
    function createAndSetSimpleMockProxy(UCSTestEnv storage test, string memory name, Op[] memory ops) internal returns(UCSTestEnv storage) {
        MockProxy simpleMockProxy = MockProxyUtils.createSimpleMockProxy(ops);
        test.setMockProxy(name, simpleMockProxy);
        return test;
    }

    function setMockProxy(UCSTestEnv storage test, string memory name, MockProxy mockProxy) internal returns(UCSTestEnv storage) {
        if (!mockProxy.exists()) DevUtils.revertWithDevEnvError("SetMockProxy_EmptyProxy");
        test.mockProxies[DevUtils.getHash(name)] = mockProxy.assignLabel(name);
        return test;
    }

    function getMockProxyBy(UCSTestEnv storage test, string memory name) internal returns(MockProxy) {
        MockProxy mockProxy = test.mockProxies[DevUtils.getHash(name)];
        if (!mockProxy.exists()) DevUtils.revertWithDevEnvError("GetMockProxy_NotFound");
        return mockProxy;
    }

    function existsMockProxy(UCSTestEnv storage test, string memory name) internal returns(bool) {
        return test.mockProxies[DevUtils.getHash(name)].exists();
    }

    function findUnusedMockProxyName(UCSTestEnv storage test) internal returns(string memory) {
        return test.findUnusedName(existsMockProxy, "MockProxy");
    }


    /**---------------------------
        📚 for Mock Dictionary
    -----------------------------*/
    function createAndSetMockDictionary(UCSTestEnv storage test, string memory name, address owner, Op[] memory ops) internal returns(UCSTestEnv storage) {
        MockDictionary mockDictionary = MockDictionaryUtils.createMockDictionary(owner, ops);
        test.setMockDictionary(name, mockDictionary);
        return test;
    }

    function setMockDictionary(UCSTestEnv storage test, string memory name, MockDictionary mockDictionary) internal returns(UCSTestEnv storage) {
        if (!mockDictionary.exists()) DevUtils.revertWithDevEnvError("SetMockDictionary_EmptyDictionary");
        test.mockDictionaries[DevUtils.getHash(name)] = mockDictionary.assignLabel(name);
        return test;
    }

    function getMockDictionaryBy(UCSTestEnv storage test, string memory name) internal returns(MockDictionary) {
        MockDictionary mockDictionary = test.mockDictionaries[DevUtils.getHash(name)];
        if (!mockDictionary.exists()) DevUtils.revertWithDevEnvError("GetMockDictionary_NotFound");
        return mockDictionary;
    }

    function existsMockDictionary(UCSTestEnv storage test, string memory name) internal returns(bool) {
        return test.mockDictionaries[DevUtils.getHash(name)].exists();
    }

    function findUnusedMockDictionaryName(UCSTestEnv storage test) internal returns(string memory) {
        return test.findUnusedName(existsMockDictionary, "MockDictionary");
    }


    /**-----------------------
        🔧 Helper Methods
    -------------------------*/
    function findUnusedName(
        UCSTestEnv storage test,
        function(UCSTestEnv storage, string memory) returns(bool) existsFunc,
        string memory baseName
    ) internal returns(string memory name) {
        (uint start, uint end) = DevUtils.getScanRange();

        for (uint i = start; i <= end; ++i) {
            name = ForgeHelper.appendNumberToNameIfNotOne(baseName, i);
            if (!existsFunc(test, name)) return name;
        }

        DevUtils.revertUnusedNameNotFound();
    }

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {UCSTestEnv, Proxy, MockProxy, Op} from "dev-env/UCSDevEnv.sol";
// import {MockProxy, MockProxyUtils} from "dev-env/test/MockUtils.sol";
// import {MockProxy as MockProxyContract} from "dev-env/test/mocks/MockProxy.sol";
import {ForgeHelper, vm, console2} from "dev-env/common/ForgeHelper.sol";
import {DevUtils} from "dev-env/common/DevUtils.sol";
import {MockUtils} from "./MockUtils.sol";

import {ERC7546Utils} from "@ucs-contracts/src/proxy/ERC7546Utils.sol";

library UCSTestEnvUtils {
    /**-------------------
        🏠 Mock Proxy
    ---------------------*/
    function setMockProxy(UCSTestEnv storage test, string memory name, MockProxy mockProxy) internal returns(UCSTestEnv storage) {
        if (!mockProxy.exists()) DevUtils.revertWithDevEnvError("SetMockProxy_EmptyProxy");
        bytes32 nameHash = DevUtils.getHash(name);
        test.mockProxies[nameHash] = mockProxy.assignLabel(name);
        return test;
    }

    function createAndSetSimpleMockProxy(UCSTestEnv storage test, string memory name, Op[] memory ops) internal returns(UCSTestEnv storage) {
        MockProxy simpleMockProxy = MockUtils.createSimpleMockProxy(ops);
        test.setMockProxy(name, simpleMockProxy);
        return test;
    }


    function getMockProxy(UCSTestEnv storage test, string memory name) internal returns(MockProxy) {
        bytes32 nameHash = DevUtils.getHash(name);
        MockProxy mockProxy = test.mockProxies[nameHash];
        if (!mockProxy.exists()) DevUtils.revertWithDevEnvError("GetMockProxy_NotFound");
        return mockProxy;
    }

    function getDefaultMockProxyName(UCSTestEnv storage test) internal returns(string memory) {
        string memory baseName = "MockProxy";
        string memory name;

        for (uint i = 0; i < 5; ++i) {
            name =  i == 0 ?
                    baseName:
                    ForgeHelper.concatWithUint(name, i);
            bytes32 nameHash = DevUtils.getHash(name);
            if (!test.mockProxies[nameHash].exists()) {
                return name;
            }
        }

        DevUtils.revertWithDevEnvError(
            "Default names are automatically set up to 4. Please manually assign names beyond that."
        );

    }

}

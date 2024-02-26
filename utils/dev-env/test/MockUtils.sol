// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ForgeHelper, vm, console2} from "dev-env/common/ForgeHelper.sol";

// import {Op} from "utils/common/UCSTypes.sol";

import {DevUtils} from "dev-env/common/DevUtils.sol";
import {UCSDevEnv, Op, MockProxy, MockDictionary} from "dev-env/UCSDevEnv.sol";

// import "dev-env/UCSDevEnv.sol";

import {SimpleMockProxy, SimpleMockProxyUtils} from "dev-env/test/mocks/SimpleMockProxy.sol";
import {IDictionary} from "@ucs-contracts/src/dictionary/IDictionary.sol";

library MockUtils {
    using {MockUtils.asMockProxy} for address;
    using {MockUtils.asMockDictionary} for address;
    using {DevUtils.exists} for address;

    /**
        🤖 Mock Proxy
     */
    error MockProxyIndexNotFound();

    function createSimpleMockProxy(Op[] memory ops) internal returns(MockProxy) {
        return address(new SimpleMockProxy(ops)).asMockProxy();
    }

    /**
        MockProxy
     */
    // function set(MockProxy mockProxy, Op memory op) internal returns(MockProxy) {
    //     address _mockProxy = mockProxy.toAddress();
    //     bytes32 _opAddressLocation = SimpleMockProxyUtils.getOpAddressLocation(op.selector);
    //     vm.store(_mockProxy, _opAddressLocation, bytes32(uint256(uint160(op.implementation))));
    //     return mockProxy;
    // }

    function toAddress(MockProxy proxy) internal pure returns(address) {
        return MockProxy.unwrap(proxy);
    }

    function asMockProxy(address addr) internal pure returns(MockProxy) {
        return MockProxy.wrap(addr);
    }

    function assignLabel(MockProxy mockProxy, string memory name) internal returns(MockProxy) {
        ForgeHelper.assignLabel(mockProxy.toAddress(), name);
        return mockProxy;
    }

    function exists(MockProxy mockProxy) internal returns(bool) {
        return mockProxy.toAddress().exists();
    }


    /**
        🤖 Mock Dictionary
     */
    function createMockDictionary(UCSDevEnv storage ucs) internal returns(MockDictionary) {
        // TODO
    }

    function set(MockDictionary mockDictionary, Op memory op) internal returns(MockDictionary) {
        address _mockDictionary = mockDictionary.toAddress();
        IDictionary(_mockDictionary).setImplementation({
            functionSelector: op.selector,
            implementation: op.implementation
        });
        return mockDictionary;
    }

    function toAddress(MockDictionary proxy) internal pure returns(address) {
        return MockDictionary.unwrap(proxy);
    }

    function asMockDictionary(address addr) internal pure returns(MockDictionary) {
        return MockDictionary.wrap(addr);
    }

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ForgeHelper, vm, console2} from "dev-env/common/ForgeHelper.sol";

// import {Op} from "utils/common/UCSTypes.sol";

import {DevUtils} from "dev-env/common/DevUtils.sol";
import {UCSDevEnv, Op, MockProxy, MockDictionary} from "dev-env/UCSDevEnv.sol";

// import "dev-env/UCSDevEnv.sol";

import {MockProxy as MockProxyContract, MockProxyContractUtils} from "dev-env/test/mocks/MockProxy.sol";
import {IDictionary} from "@ucs-contracts/src/dictionary/IDictionary.sol";

using {MockUtils.asMockProxy} for address;
using {MockUtils.asMockDictionary} for address;

library MockUtils {
    /**
        🤖 Mock Proxy
     */
    error MockProxyIndexNotFound();

    /**
        Global
     */
    function createMockProxy(UCSDevEnv storage ucs) internal returns(MockProxy) {
        Op[] memory ops;
        MockProxy _newMockProxy = address(new MockProxyContract(ops)).asMockProxy();
        // ucs.test.mockProxies.push(_newMockProxy);
        return _newMockProxy;
    }

    function createMockProxy(UCSDevEnv storage ucs, string memory name) internal returns(MockProxy) {
        MockProxy _newMockProxy = ucs.createMockProxy();
        bytes32 _nameHash = DevUtils.getHash(name);
        // uint256 _mockProxyIndexPlusOne = ucs.test.mockProxies.length;
        // ucs.test.namedMockProxyIndicesPlusOne[_nameHash] = _mockProxyIndexPlusOne;
        ForgeHelper.assignLabel(_newMockProxy.toAddress(), name);
        return _newMockProxy;
    }

    function findMockProxyBy(UCSDevEnv storage ucs, string memory name) internal view returns(MockProxy) {
        // bytes32 _nameHash = DevUtils.getNameHash(name);
        // uint256 _mockProxyIndexPlusOne = ucs.test.namedMockProxyIndicesPlusOne[_nameHash];
        // if (_mockProxyIndexPlusOne == 0) revert MockProxyIndexNotFound();
        // MockProxy _namedMockProxy = ucs.test.mockProxies[_mockProxyIndexPlusOne - 1];
        // console2.log(_namedMockProxy.toAddress());
        // return _namedMockProxy;
    }

    /**
        MockProxy
     */
    function set(MockProxy mockProxy, Op memory op) internal returns(MockProxy) {
        address _mockProxy = mockProxy.toAddress();
        bytes32 _opAddressLocation = MockProxyContractUtils.getOpAddressLocation(op.selector);
        vm.store(_mockProxy, _opAddressLocation, bytes32(uint256(uint160(op.implementation))));
        return mockProxy;
    }

    function toAddress(MockProxy proxy) internal pure returns(address) {
        return MockProxy.unwrap(proxy);
    }

    function asMockProxy(address addr) internal pure returns(MockProxy) {
        return MockProxy.wrap(addr);
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

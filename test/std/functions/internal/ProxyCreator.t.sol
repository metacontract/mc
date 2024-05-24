// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {MCTest, ForgeHelper, Dummy} from "devkit/Flattened.sol";

import {ProxyCreator} from "mc-std/functions/internal/ProxyCreator.sol";

contract ProxyCreatorTest is MCTest {

    function test_create_Success() public {
        address dictionary = Dummy.contractAddr();

        vm.expectEmit(true, false, false, false, address(this));
        emit ProxyCreator.ProxyCreated(dictionary, makeAddr("Proxy"));
        address proxy = ProxyCreator.create(dictionary, "");

        assertEq(ForgeHelper.getDictionaryAddress(proxy), dictionary);
    }

}

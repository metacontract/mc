// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {MCStateFuzzingTest} from "devkit/MCTest.sol";

import {Dummy} from "test/utils/Dummy.sol";
import {ProxyCreator} from "mc-std/functions/internal/ProxyCreator.sol";
import {ForgeHelper} from "devkit/utils/ForgeHelper.sol";

contract ProxyCreatorTest is MCStateFuzzingTest {

    function test_create_Success() public {
        address dictionary = Dummy.contractAddr();

        vm.expectEmit(true, false, false, false, address(this));
        emit ProxyCreator.ProxyCreated(dictionary, makeAddr("Proxy"));
        address proxy = ProxyCreator.create(dictionary, "");

        assertEq(ForgeHelper.getDictionaryAddress(proxy), dictionary);
    }

}

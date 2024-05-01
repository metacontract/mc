// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {console2} from "forge-std/console2.sol";
import {MCStateFuzzingTest} from "devkit/MCTest.sol";
import {ProxyUtils} from "@ucs.mc/proxy/ProxyUtils.sol";

import {Create} from "mc-std/functions/Create.sol";
import {ProxyCreator} from "mc-std/functions/internal/ProxyCreator.sol";
import {ForgeHelper} from "devkit/utils/ForgeHelper.sol";
import {Dummy} from "test/utils/Dummy.sol";

contract CreateTest is MCStateFuzzingTest {
    address cloneFunc = address(new Create());
    address dictionary;

    function setUp() public {
        Dummy.setBundle(mc);
        dictionary = mc.createMockDictionary().addr;
        setDictionary(dictionary);
        implementations[Create.create.selector] = cloneFunc;
    }

    function test_Clone_Success_WithoutInitData() public {
        vm.expectEmit(true, false, false, false, address(target));
        emit ProxyCreator.ProxyCreated(dictionary, address(0));
        address cloned = Create(target).create(dictionary, "");
        assertEq(
            ForgeHelper.getDictionaryAddress(cloned),
            dictionary
        );
    }

}

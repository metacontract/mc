// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {console2} from "forge-std/console2.sol";
import {MCStateFuzzingTest} from "devkit/MCTest.sol";
import {ProxyUtils} from "@ucs.mc/proxy/ProxyUtils.sol";

import {Clone} from "mc-std/functions/Clone.sol";
import {ProxyCreator} from "mc-std/functions/internal/ProxyCreator.sol";
import {ForgeHelper} from "devkit/utils/ForgeHelper.sol";
import {Dummy} from "test/utils/Dummy.sol";

contract CloneTest is MCStateFuzzingTest {
    Clone clone = Clone(address(this));
    address cloneFunc = address(new Clone());
    address dictionary;

    function setUp() public {
        Dummy.setBundle(mc);
        dictionary = mc.createMockDictionary().addr;
        setDictionary(dictionary);
        implementations[Clone.clone.selector] = cloneFunc;
    }

    function test_Clone_Success_WithoutInitData() public {
        vm.expectEmit(true, false, false, false, address(clone));
        emit ProxyCreator.ProxyCreated(dictionary, address(0));
        address cloned = clone.clone("");
        assertEq(
            ForgeHelper.getDictionaryAddress(address(this)),
            ForgeHelper.getDictionaryAddress(cloned)
        );
    }

}

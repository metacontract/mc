// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {
    MCTest,
    console2,
    ForgeHelper,
    Dummy
} from "devkit/Flattened.sol";

import {Create} from "mc-std/functions/Create.sol";
import {ProxyCreator} from "mc-std/functions/internal/ProxyCreator.sol";

contract CreateTest is MCTest {
    function setUp() public {
        _use(Create.create.selector, address(new Create()));
        _setDictionary(Dummy.dictionary(mc));
    }

    function test_Create_Success_WithoutInitData() public {
        vm.expectEmit(true, false, false, false, address(target));
        emit ProxyCreator.ProxyCreated(dictionary, address(0));
        address cloned = Create(target).create(dictionary, "");
        assertEq(
            ForgeHelper.getDictionaryAddress(cloned),
            dictionary
        );
    }

}

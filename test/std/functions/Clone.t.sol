// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {console2} from "forge-std/console2.sol";
import {MCTest} from "devkit/MCTest.sol";
import {ProxyUtils} from "@ucs.mc/proxy/ProxyUtils.sol";

import {Clone} from "mc-std/functions/Clone.sol";
import {ProxyCreator} from "mc-std/functions/internal/ProxyCreator.sol";
import {ForgeHelper} from "devkit/utils/ForgeHelper.sol";
import {Dummy} from "test/utils/Dummy.sol";

contract CloneTest is MCTest {
    function setUp() public {
        _use(Clone.clone.selector, address(new Clone()));
        _setDictionary(Dummy.dictionary(mc));
    }

    function test_Clone_Success_WithoutInitData() public {
        vm.expectEmit(true, false, false, false, target);
        emit ProxyCreator.ProxyCreated(dictionary, address(0));
        address cloned = Clone(target).clone("");
        assertEq(
            ForgeHelper.getDictionaryAddress(address(this)),
            ForgeHelper.getDictionaryAddress(cloned)
        );
    }

}

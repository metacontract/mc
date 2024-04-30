// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKitTest} from "devkit/MCTest.sol";

import {Inspector} from "devkit/types/Inspector.sol";
    using Inspector for string;

import {Formatter} from "devkit/types/Formatter.sol";
    using Formatter for string;
import {MessageHead as HEAD} from "devkit/system/message/MessageHead.sol";

import {Bundle} from "devkit/core/Bundle.sol";
import {Function} from "devkit/core/Function.sol";
import {DummyFunction} from "test/utils/DummyFunction.sol";
import {DummyFacade} from "test/utils/DummyFacade.sol";

contract DevKitTest_MCDeploy is MCDevKitTest {
    /**-----------------------------
        🌞 Deploy Meta Contract
    -------------------------------*/
    function test_deploy_Success() public {
        string memory name = "TestBundleName";
        mc.init(name);
        mc.use(DummyFunction.dummy.selector, address(new DummyFunction()));
        mc.useFacade(address(new DummyFacade()));

        address proxy = mc.deploy().toProxyAddress();

        assertTrue(mc.dictionary.find(name).isVerifiable());
        assertTrue(mc.dictionary.find(name).isComplete());
        assertTrue(mc.proxy.find(name).isComplete());

        (bool success,) = proxy.call(abi.encodeWithSelector(DummyFunction.dummy.selector));
        assertTrue(success);
    }

}

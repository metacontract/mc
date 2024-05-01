// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {console2} from "forge-std/console2.sol";
import {MCStateFuzzingTest} from "devkit/MCTest.sol";
import {ProxyUtils} from "@ucs.mc/proxy/ProxyUtils.sol";
import {Function as MCFunc} from "devkit/core/Function.sol";

import {GetFunctions} from "mc-std/functions/GetFunctions.sol";
import {ProxyCreator} from "mc-std/functions/internal/ProxyCreator.sol";
import {ForgeHelper} from "devkit/utils/ForgeHelper.sol";
import {Dummy} from "test/utils/Dummy.sol";
import {DummyFunction} from "test/utils/DummyFunction.sol";
import {DummyFacade} from "test/utils/DummyFacade.sol";

contract GetFunctionsTest is MCStateFuzzingTest {
    function setUp() public {
        _use(GetFunctions.getFunctions.selector, address(new GetFunctions()));
        _use(DummyFunction.dummy.selector, address(new DummyFunction()));
        _use(DummyFunction.dummy2.selector, address(new DummyFunction()));
        _setDictionary(Dummy.dictionary(mc, functions));
    }

    function test_GetFunctions_Success() public {
        GetFunctions.Function[] memory funcs = GetFunctions(target).getFunctions();
        for (uint i; i < funcs.length; ++i) {
            assertEq(funcs[i].selector, functions[i].selector);
            assertEq(funcs[i].implementation, functions[i].implementation);
        }
    }

}

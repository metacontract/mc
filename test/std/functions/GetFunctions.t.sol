// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {console2} from "forge-std/console2.sol";
import {MCStateFuzzingTest} from "devkit/MCTest.sol";
import {ProxyUtils} from "@ucs.mc/proxy/ProxyUtils.sol";
import {Function} from "devkit/core/Function.sol";

import {GetFunctions} from "mc-std/functions/GetFunctions.sol";
import {ProxyCreator} from "mc-std/functions/internal/ProxyCreator.sol";
import {ForgeHelper} from "devkit/utils/ForgeHelper.sol";
import {Dummy} from "test/utils/Dummy.sol";
import {DummyFunction} from "test/utils/DummyFunction.sol";
import {DummyFacade} from "test/utils/DummyFacade.sol";

contract GetFunctionsTest is MCStateFuzzingTest {
    bytes4 selector = GetFunctions.getFunctions.selector;
    address impl = address(new GetFunctions());
    address dictionary;

    function setUp() public {
        mc.init("DummyBundle");
        mc.use(DummyFunction.dummy.selector, address(new DummyFunction()));
        mc.use(DummyFunction.dummy2.selector, address(new DummyFunction()));
        mc.useFacade(address(new DummyFacade()));
        dictionary = mc.createMockDictionary().addr;
        setDictionary(dictionary);
        implementations[selector] = impl;
    }

    function test_GetFunctions_Success() public {
        GetFunctions.Function[] memory functions = GetFunctions(target).getFunctions();
        Function[] memory funcs = mc.bundle.findCurrent().functions;
        assertEq(functions[0].selector, funcs[0].selector);
        assertEq(functions[0].implementation, funcs[0].implementation);
        assertEq(functions[1].selector, funcs[1].selector);
        assertEq(functions[1].implementation, funcs[1].implementation);
    }

}

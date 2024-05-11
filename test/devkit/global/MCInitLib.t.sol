// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCTestBase} from "devkit/MCBase.sol";
import {MessageHead as HEAD} from "devkit/system/message/MessageHead.sol";

import {Inspector} from "devkit/types/Inspector.sol";
    using Inspector for string;

import {Bundle} from "devkit/core/Bundle.sol";
import {Function} from "devkit/core/Function.sol";
import {DummyFunction} from "devkit/test/dummy/DummyFunction.sol";
import {DummyFacade} from "devkit/test/dummy/DummyFacade.sol";

contract MCInitLibTest is MCTestBase {

    /**--------------------
        🌱 Init Bundle
    ----------------------*/
    function test_init_Success_withName() public {
        string memory name = "TestBundleName";
        mc.init(name);

        assertTrue(mc.bundle.bundles[name].name.isEqual(name));
        assertTrue(mc.bundle.current.name.isEqual(name));
    }


    /**---------------------
        🔗 Use Function
    -----------------------*/
    function assertFunctionAdded(string memory bundleName, uint256 functionsIndex, string memory functionName, bytes4 selector, address impl) internal view {
        Bundle memory bundle = mc.bundle.bundles[bundleName];
        assertEq(bundle.name, bundleName);
        assertEq(bundle.facade, address(0));
        Function memory func = mc.functions.functions[functionName];
        assertEq(func.name, functionName);
        assertEq(func.selector, selector);
        assertEq(func.implementation, impl);
        assertTrue(bundle.functions[functionsIndex].isEqual(func));
        assertEq(mc.functions.current.name, functionName);
    }

    function test_use_Success() public {
        string memory bundleName = mc.bundle.genUniqueName();

        string memory functionName = "DummyFunction";
        bytes4 selector = DummyFunction.dummy.selector;
        address impl =  address(new DummyFunction());

        mc.use(functionName, selector, impl);

        assertFunctionAdded(bundleName, 0, functionName, selector, impl);
    }

    function test_use_Success_WithDifferentSelector() public {
        string memory bundleName = mc.bundle.genUniqueName();

        string memory functionName = "DummyFunction";
        bytes4 selector = DummyFunction.dummy.selector;
        bytes4 selector2 = DummyFunction.dummy2.selector;
        address impl =  address(new DummyFunction());

        mc.use(functionName, selector, impl);
        mc.use(functionName, selector2, impl);

        assertFunctionAdded(bundleName, 1, functionName, selector2, impl);
    }

    function test_use_Revert_WithSameSelector() public {
        string memory functionName = "DummyFunction";
        bytes4 selector = DummyFunction.dummy.selector;
        address impl =  address(new DummyFunction());

        mc.use(functionName, selector, impl);

        mc.expectRevert(HEAD.BUNDLE_CONTAINS_SAME_SELECTOR);
        mc.use(functionName, selector, impl);
    }

    function test_use_Revert_EmptyName() public {
        string memory functionName = "";
        bytes4 selector = DummyFunction.dummy.selector;
        address impl =  address(new DummyFunction());

        mc.expectRevert(HEAD.NAME_REQUIRED);
        mc.use(functionName, selector, impl);
    }

    function test_use_Revert_NotContract() public {
        string memory functionName = "DummyFunction";
        bytes4 selector = DummyFunction.dummy.selector;
        address impl =  makeAddr("EOA");

        mc.expectRevert(HEAD.ADDRESS_NOT_CONTRACT);
        mc.use(functionName, selector, impl);
    }


    /**------------------
        🪟 Use Facade
    --------------------*/
    function test_Success_useFacade() public {
        address facade = address(new DummyFacade());
        mc.init();
        mc.useFacade(facade);
    }


    /**--------------------------------
        🏰 Setup Standard Functions
    ----------------------------------*/


}

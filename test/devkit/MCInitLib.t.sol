// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {
    MCTestBase,
    MessageHead as HEAD,
    Function,
    Inspector,
    Bundle,
    DummyFunction,
    DummyFacade
} from "devkit/Flattened.sol";

import {InitSetAdmin} from "mc-std/functions/protected/InitSetAdmin.sol";
import {GetFunctions} from "mc-std/functions/GetFunctions.sol";
import {Clone} from "mc-std/functions/Clone.sol";

contract MCInitLibTest is MCTestBase {
    using Inspector for string;
    using Inspector for address;

    function _isInitSetAdmin(Function memory func) internal returns(bool) {
        return
            func.name.isEqual("InitSetAdmin") &&
            func.selector == InitSetAdmin.initSetAdmin.selector &&
            func.implementation.isContract();
    }

    function _isGetFunctions(Function memory func) internal returns(bool) {
        return
            func.name.isEqual("GetFunctions") &&
            func.selector == GetFunctions.getFunctions.selector &&
            func.implementation.isContract();
    }

    function _isClone(Function memory func) internal returns(bool) {
        return
            func.name.isEqual("Clone") &&
            func.selector == Clone.clone.selector &&
            func.implementation.isContract();
    }


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
    function test_useFacade_Success() public {
        address facade = address(new DummyFacade());
        mc.init();
        mc.useFacade(facade);
    }


    /**--------------------------------
        🏰 Setup Standard Functions
    ----------------------------------*/
    function test_setupStdFuncs_Success() public {
        mc.setupStdFunctions();

        assertTrue(_isInitSetAdmin(mc.std.functions.initSetAdmin));
        assertTrue(_isGetFunctions(mc.std.functions.getFunctions));
        assertTrue(_isClone(mc.std.functions.clone));

        assertTrue(mc.std.all.functions.length == 3);
        assertTrue(_isInitSetAdmin(mc.std.all.functions[0]));
        assertTrue(_isGetFunctions(mc.std.all.functions[1]));
        assertTrue(_isClone(mc.std.all.functions[2]));
    }

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKitTest} from "devkit/MCTest.sol";

import {Inspector} from "devkit/types/Inspector.sol";
    using Inspector for string;

import {TypeConverter} from "devkit/types/TypeConverter.sol";
    using TypeConverter for string;
import {ERR} from "devkit/system/message/ERR.sol";

import {Bundle} from "devkit/core/Bundle.sol";
import {Function} from "devkit/core/Function.sol";
import {DummyFunction} from "test/utils/DummyFunction.sol";
import {DummyFacade} from "test/utils/DummyFacade.sol";

contract DevKitTest_MCBundle is MCDevKitTest {
    /**---------------------------
        🌱 Init Custom Bundle
    -----------------------------*/
    function test_Success_init_withName() public {
        string memory name = "TestBundleName";
        mc.init(name);

        assertTrue(mc.bundle.bundles[name].name.isEqual(name));
        assertTrue(mc.bundle.current.name.isEqual(name));
    }

    // verify genUniqueBundleName
    // function test_Success_init_withoutName() public {}

    function test_Success_ensureInit_beforeInit() public {
        string memory name = mc.bundle.genUniqueName();

        mc.ensureInit();

        assertTrue(mc.bundle.bundles[name].name.isEqual(name));
        assertTrue(mc.bundle.current.name.isEqual(name));
    }

    function test_Success_ensureInit_afterInit() public {
        string memory name = mc.bundle.genUniqueName();

        mc.init();

        assertTrue(mc.bundle.bundles[name].name.isEqual(name));
        assertTrue(mc.bundle.current.name.isEqual(name));

        string memory name2 = mc.bundle.genUniqueName();
        mc.ensureInit();

        assertTrue(mc.bundle.bundles[name2].name.isEmpty());
        assertTrue(mc.bundle.current.name.isEqual(name));
    }


    /**---------------------
        🔗 Use Function
    -----------------------*/
    function assertFunctionAdded(string memory bundleName, uint256 functionsIndex, string memory functionName, bytes4 selector, address impl) internal {
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

    function test_Success_use() public {
        string memory bundleName = mc.bundle.genUniqueName();
        string memory functionName = "DummyFunction";
        bytes4 selector = DummyFunction.dummy.selector;
        address impl =  address(new DummyFunction());

        mc.use(functionName, selector, impl);

        assertFunctionAdded(bundleName, 0, functionName, selector, impl);
    }

    function test_Revert_use_withSameName() public {
        string memory bundleName = mc.bundle.genUniqueName();
        string memory functionName = "DummyFunction";
        bytes4 selector = DummyFunction.dummy.selector;
        address impl =  address(new DummyFunction());

        mc.use(functionName, selector, impl);

        vm.expectRevert(ERR.message("Locaked Object").toBytes()); // TODO
        mc.use(functionName, selector, impl);
    }

    function test_Success_use_withDifferentName() public {
        string memory bundleName = mc.bundle.genUniqueName();

        string memory functionName = "DummyFunction";
        string memory functionName2 = "DummyFunction2";
        bytes4 selector = DummyFunction.dummy.selector;
        address impl =  address(new DummyFunction());

        mc.use(functionName, selector, impl);
        mc.use(functionName2, selector, impl);

        assertFunctionAdded(bundleName, 1, functionName2, selector, impl);
    }


    /**------------------
        🪟 Use Facade
    --------------------*/
    function test_Success_useFacade() public {
        address facade = address(new DummyFacade());
        mc.init();
        mc.useFacade(facade);
    }

    function test_Revert_useFacade_withoutInit() public {
        address facade = address(new DummyFacade());
        vm.expectRevert(ERR.message("Current Not Exist").toBytes());
        mc.useFacade(facade);
    }
}

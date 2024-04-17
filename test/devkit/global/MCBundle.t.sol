// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKitTest} from "devkit/MCTest.sol";

import {Inspector} from "devkit/types/Inspector.sol";
    using Inspector for string;

import {Formatter} from "devkit/types/Formatter.sol";
    using Formatter for string;
import {ERR} from "devkit/system/message/ERR.sol";

import {Bundle} from "devkit/core/Bundle.sol";
import {Function} from "devkit/core/Function.sol";
import {DummyFunction} from "test/utils/DummyFunction.sol";
import {DummyFacade} from "test/utils/DummyFacade.sol";

contract DevKitTest_MCBundle is MCDevKitTest {
    /**---------------------------
        🌱 Init Custom Bundle
    -----------------------------*/
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

    function test_use_Revert_WithSameName() public {
        string memory bundleName = mc.bundle.genUniqueName();
        string memory functionName = "DummyFunction";
        bytes4 selector = DummyFunction.dummy.selector;
        address impl =  address(new DummyFunction());

        mc.use(functionName, selector, impl);

        vm.expectRevert(ERR.message("Bundle has same Function").toBytes()); // TODO
        mc.use(functionName, selector, impl);
    }

    function test_use_Success_WithDifferentName() public {
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

    // function test_Revert_useFacade_withoutInit() public {
    //     address facade = address(new DummyFacade());
    //     vm.expectRevert(ERR.message(ERR.EMPTY_CURRENT_BUNDLE).toBytes());
    //     mc.useFacade(facade);
    // }
}

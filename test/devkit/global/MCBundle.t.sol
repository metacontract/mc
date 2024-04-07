// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKitTest} from "devkit/MCTest.sol";

import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;
import {Config} from "devkit/config/Config.sol";
import {ERR} from "devkit/error/Error.sol";

import {Bundle} from "devkit/ucs/functions/Bundle.sol";
import {Function} from "devkit/ucs/functions/Function.sol";
import {DummyFunction} from "test/utils/DummyFunction.sol";

contract DevKitTest_MCBundle is MCDevKitTest {
    /**---------------------------
        🌱 Init Custom Bundle
    -----------------------------*/
    function test_Success_init_withName() public {
        string memory name = "TestBundleName";
        mc.init(name);

        assertTrue(mc.functions.bundles[name.safeCalcHash()].name.isEqual(name));
        assertTrue(mc.functions.currentBundleName.isEqual(name));
    }

    // verify genUniqueBundleName
    // function test_Success_init_withoutName() public {}

    function test_Success_ensureInit_beforeInit() public {
        string memory name = mc.functions.genUniqueBundleName();

        mc.ensureInit();

        assertTrue(mc.functions.bundles[name.safeCalcHash()].name.isEqual(name));
        assertTrue(mc.functions.currentBundleName.isEqual(name));
    }

    function test_Success_ensureInit_afterInit() public {
        string memory name = mc.functions.genUniqueBundleName();

        mc.init();

        assertTrue(mc.functions.bundles[name.safeCalcHash()].name.isEqual(name));
        assertTrue(mc.functions.currentBundleName.isEqual(name));

        string memory name2 = mc.functions.genUniqueBundleName();
        mc.ensureInit();

        assertTrue(mc.functions.bundles[name2.safeCalcHash()].name.isEmpty());
        assertTrue(mc.functions.currentBundleName.isEqual(name));
    }


    /**---------------------
        🔗 Use Function
    -----------------------*/
    function assertFunctionAdded(string memory bundleName, uint256 functionsIndex, string memory functionName, bytes4 selector, address impl) internal {
        Bundle memory bundle = mc.functions.bundles[bundleName.safeCalcHash()];
        assertEq(bundle.name, bundleName);
        assertEq(bundle.facade, address(0));
        Function memory func = mc.functions.customs[functionName.safeCalcHash()];
        assertEq(func.name, functionName);
        assertEq(func.selector, selector);
        assertEq(func.implementation, impl);
        assertTrue(bundle.functionInfos[functionsIndex].isEqual(func));
        assertEq(mc.functions.currentFunctionName, functionName);
    }

    function test_Success_use() public {
        string memory bundleName = mc.functions.genUniqueBundleName();
        string memory functionName = "DummyFunction";
        bytes4 selector = DummyFunction.dummy.selector;
        address impl =  address(new DummyFunction());

        mc.use(functionName, selector, impl);

        assertFunctionAdded(bundleName, 0, functionName, selector, impl);
    }

    function test_Revert_use_withSameName() public {
        string memory bundleName = mc.functions.genUniqueBundleName();
        string memory functionName = "DummyFunction";
        bytes4 selector = DummyFunction.dummy.selector;
        address impl =  address(new DummyFunction());

        mc.use(functionName, selector, impl);

        vm.expectRevert(ERR.message("Name Already Exist").toBytes());
        mc.use(functionName, selector, impl);
    }

    function test_Success_use_withDifferentName() public {
        string memory bundleName = mc.functions.genUniqueBundleName();

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
}

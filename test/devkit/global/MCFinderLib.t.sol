// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCTestBase} from "devkit/MCBase.sol";
import {MessageHead as HEAD} from "devkit/system/message/MessageHead.sol";
import {Formatter} from "devkit/types/Formatter.sol";
    using Formatter for string;
import {DummyFunction} from "../../utils/DummyFunction.sol";
import {DummyFacade} from "../../utils/DummyFacade.sol";

contract MCFinderLibTest is MCTestBase {

    /**----------------------------------
        🏠 Find Current Proxy Address
    ------------------------------------*/
    function test_toProxyAddress_Success() public {
        mc.init();
        mc.use(DummyFunction.dummy.selector, address(new DummyFunction()));
        mc.useFacade(address(new DummyFacade()));
        mc.deploy();

        address proxy = mc.toProxyAddress();

        (bool success,) = proxy.call(abi.encodeWithSelector(DummyFunction.dummy.selector));
        assertTrue(success);
    }
    function test_toProxyAddress_Revert_NoCurrentProxy() public {
        vm.expectRevert(HEAD.CURRENT_PROXY_NOT_EXIST.toBytes());
        mc.toProxyAddress();
    }

    /**----------------------------------------
        📚 Find Current Dictionary Address
    ------------------------------------------*/
    function test_toDictionaryAddress_Success() public {
        bytes4 selector = DummyFunction.dummy.selector;
        address impl = address(new DummyFunction());
        mc.init();
        mc.use(selector, impl);
        mc.useFacade(address(new DummyFacade()));
        mc.deploy();

        address dictionary = mc.toDictionaryAddress();

        (bool success, bytes memory ret) = dictionary.call(abi.encodeWithSignature("getImplementation(bytes4)", selector));
        assertTrue(success);
        assertEq(address(uint160(uint256(bytes32(ret)))), impl);
    }
    function test_toDictionaryAddress_Revert_NoCurrentProxy() public {
        vm.expectRevert(HEAD.CURRENT_DICTIONARY_NOT_EXIST.toBytes());
        mc.toDictionaryAddress();
    }

}

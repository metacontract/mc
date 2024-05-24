// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {
    MCTestBase,
    MessageHead as REASON,
    Dummy
} from "devkit/Flattened.sol";

contract MCFinderLibTest is MCTestBase {

    /**----------------------------------
        🏠 Find Current Proxy Address
    ------------------------------------*/
    function test_toProxyAddress_Success() public {
        bytes4 selector = Dummy.functionSelector();
        mc.use(selector, Dummy.functionAddress());
        mc.useFacade(Dummy.facadeAddress());
        mc.deploy();

        address proxy = mc.toProxyAddress();

        (bool success,) = proxy.call(abi.encodeWithSelector(selector));
        assertTrue(success);
    }
    function test_toProxyAddress_Revert_NoCurrentProxy() public {
        mc.expectRevert(REASON.CURRENT_PROXY_NOT_EXIST);
        mc.toProxyAddress();
    }

    /**----------------------------------------
        📚 Find Current Dictionary Address
    ------------------------------------------*/
    function test_toDictionaryAddress_Success() public {
        bytes4 selector = Dummy.functionSelector();
        address impl = Dummy.functionAddress();
        mc.use(selector, impl);
        mc.useFacade(Dummy.facadeAddress());
        mc.deploy();

        address dictionary = mc.toDictionaryAddress();

        (bool success, bytes memory ret) = dictionary.call(abi.encodeWithSignature("getImplementation(bytes4)", selector));
        assertTrue(success);
        assertEq(address(uint160(uint256(bytes32(ret)))), impl);
    }
    function test_toDictionaryAddress_Revert_NoCurrentProxy() public {
        mc.expectRevert(REASON.CURRENT_DICTIONARY_NOT_EXIST);
        mc.toDictionaryAddress();
    }

}

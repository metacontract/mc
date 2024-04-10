// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {MCTest} from "devkit/MCTest.sol";
import {Clone} from "mc-std/functions/Clone.sol";

contract CloneOpSpecMCTest is MCTest {
    address cloneOp;
    address proxy;

    function setUp() public {
        // proxy = mc.createSimpleMockProxy("MyProxy")
        //             // .set(mc.functions.stdOps.clone.toOp())
        //             // .set(mc.functions.stdOps.initSetAdmin.toOp())
        //             .toProxyAddress();
        // mc.getCurrentDictionary();
        // mc.getCurrentProxy();
// CloneOp(proxy).clone("");
        // address proxy2 = mc.findMockProxyBy("MyProxy").toAddress();

        // mc.test.mock.setOp(findOp(MCStdFuncs.Clone)).deployProxy();

        // startPrankWith("DEPLOYER");
        // proxy = createMockProxy(cloneOpName);
        // cloneOp = ops[OpName.Clone].implementation;
    }

    function test_Clone_Success(address dictionary, bytes memory runtimeBytecode) public
        assumeAddressIsNotReserved(dictionary)
    {
        // injectCode(dictionary, runtimeBytecode);
        // injectDictionary(cloneOp, dictionary);

        // CloneOp(cloneOp).clone("");
    }

    function test_Clone_Success_mock(address dictionary, bytes memory runtimeBytecode) public
        assumeAddressIsNotReserved(dictionary)
    {
        // injectCode(dictionary, runtimeBytecode);
        // injectDictionary(proxy, dictionary);

        // CloneOp(proxy).clone("");
    }

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {MCDevKit} from "devkit/MCDevKit.sol";
import {DummyFunction} from "./DummyFunction.sol";
import {DummyFacade} from "./DummyFacade.sol";
import {DummyContract} from "devkit/test/dummy/DummyContract.sol";
import {MCTest} from "devkit/MCTest.sol";

library Dummy {
    function bundleName() internal returns(string memory) {
        return "DummyBundleName";
    }

    function functionSelector() internal returns(bytes4) {
        return DummyFunction.dummy.selector;
    }

    function functionAddress() internal returns(address) {
        return address(new DummyFunction());
    }

    function facadeAddress() internal returns(address) {
        return address(new DummyFacade());
    }

    function setBundle(MCDevKit storage mc) internal {
        mc.init("DummyBundle");
        mc.use(DummyFunction.dummy.selector, address(new DummyFunction()));
        mc.useFacade(address(new DummyFacade()));
    }

    function dictionary(MCDevKit storage mc) internal returns(address) {
        setBundle(mc);
        return mc.createMockDictionary().addr;
    }

    function dictionary(MCDevKit storage mc, MCTest.Function[] memory functions) internal returns(address) {
        mc.init("DummyBundle");
        for (uint i; i < functions.length; ++i) {
            mc.use(functions[i].selector, functions[i].implementation);
        }
        mc.useFacade(address(new DummyFacade()));
        return mc.createMockDictionary().addr;
    }

    function contractAddr() internal returns(address) {
        return address(new DummyContract());
    }

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKit} from "devkit/MCDevKit.sol";
import {DummyFunction} from "./DummyFunction.sol";
import {DummyFacade} from "./DummyFacade.sol";
import {DummyContract} from "test/utils/DummyContract.sol";
import {Function} from "devkit/MCTest.sol";

library Dummy {
    function setBundle(MCDevKit storage mc) internal {
        mc.init("DummyBundle");
        mc.use(DummyFunction.dummy.selector, address(new DummyFunction()));
        mc.useFacade(address(new DummyFacade()));
    }

    function dictionary(MCDevKit storage mc) internal returns(address) {
        setBundle(mc);
        return mc.createMockDictionary().addr;
    }

    function dictionary(MCDevKit storage mc, Function[] memory functions) internal returns(address) {
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

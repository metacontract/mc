// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKit} from "devkit/MCDevKit.sol";
import {DummyFunction} from "./DummyFunction.sol";
import {DummyFacade} from "./DummyFacade.sol";

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

}

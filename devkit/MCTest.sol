// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Proxy as OZProxy} from "@oz.ucs/proxy/Proxy.sol";

import {System} from "devkit/system/System.sol";
import {Receive} from "mc-std/functions/Receive.sol";
import {Formatter} from "devkit/types/Formatter.sol";
import {ProxyUtils} from "@ucs.mc/proxy/ProxyUtils.sol";
import {Dummy} from "test/utils/Dummy.sol";

// 💬 ABOUT
// Meta Contract's default Test based on Forge Std Test

// 📦 BOILERPLATE
import {MCTestBase} from "./MCBase.sol";

// ⭐️ MC TEST
abstract contract MCTest is MCTestBase {
    constructor() {
        System.Config().load();
        if (System.Config().SETUP.STD_FUNCS) mc.setupStdFunctions();
    }
}

// 🌟 MC State Fuzzing Test
abstract contract MCStateFuzzingTest is MCTestBase, OZProxy { // solhint-disable-line payable-fallback
    struct Function {
        bytes4 selector;
        address implementation;
    }

    mapping(bytes4 selector => address) implementations;
    address target = address(this);
    Function[] internal functions;
    address dictionary;

    constructor() {
        System.Config().load();
        implementations[bytes4(0)] = address(new Receive());
    }

    function _use(bytes4 selector_, address impl_) internal {
        functions.push(Function(selector_, impl_));
        implementations[selector_] = impl_;
    }

    function _setDictionary(address dictionary_) internal {
        dictionary = dictionary_;
        vm.store(address(this), ProxyUtils.DICTIONARY_SLOT, Formatter.toBytes32(dictionary_));
    }

    function _implementation() internal view override returns (address) {
        return implementations[msg.sig];
    }

}

// 🌟 MC TEST for DevKit
abstract contract MCDevKitTest is MCTestBase {
    constructor() {
        System.Config().load();
    }
}

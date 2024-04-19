// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {System} from "devkit/system/System.sol";
import {DecodeErrorString} from "devkit/system/message/DecodeErrorString.sol";

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
abstract contract MCStateFuzzingTest is MCTestBase {
    mapping(bytes4 => address) implementations; // selector => impl

    // function setUp() public {
    //     // implementations TODO
    // }

    function setImplementation(bytes4 selector, address impl) internal {
        implementations[selector] = impl;
    }

    fallback(bytes calldata) external payable returns (bytes memory){
        address opAddress = implementations[msg.sig];
        require(opAddress != address(0), "Called implementation is not registered.");
        (bool success, bytes memory data) = opAddress.delegatecall(msg.data);
        if (success) {
            return data;
        } else {
            // vm.expectRevert needs this.
            revert(DecodeErrorString.decodeRevertReasonAndPanicCode(data));
        }
    }
}

// 🌟 MC TEST for DevKit
abstract contract MCDevKitTest is MCTestBase {
    constructor() {
        System.Config().load();
    }
}

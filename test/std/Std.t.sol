// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {MCTest, MCDevKit} from "devkit/Flattened.sol";
import {DeployLib} from "script/DeployLib.sol";

import {IStd} from "mc-std/interfaces/IStd.sol";
import {Initialization} from "mc-std/functions/protected/protection/Initialization.sol";

contract StdTest is MCTest {
    using DeployLib for MCDevKit;
    IStd std;

    function setUp() public  {
        mc.setupStdFunctions();
        std = IStd(mc.deployStd(address(this)));
    }

    function test_clone_Success() public {
        std.clone("");
    }

    function test_getFunctions_Success() public {
        std.getFunctions();
    }

    function test_initSetAdmin_Success() public {
        IStd uninitializedStd = IStd(std.clone(""));
        uninitializedStd.initSetAdmin(makeAddr("ADMIN"));
    }

    function test_initSetAdmin_RevertIf_AlreadyInitialized() public {
        vm.expectRevert(Initialization.InvalidInitialization.selector);
        std.initSetAdmin(makeAddr("ADMIN"));
    }

}

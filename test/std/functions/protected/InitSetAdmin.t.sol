// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {MCTest} from "devkit/Flattened.sol";

import {InitSetAdmin} from "mc-std/functions/protected/InitSetAdmin.sol";
import {Initialization} from "mc-std/functions/protected/protection/Initialization.sol";
import {Storage} from "mc-std/storage/Storage.sol";

contract InitSetAdminTest is MCTest {
    function setUp() public {
        _use(InitSetAdmin.initSetAdmin.selector, address(new InitSetAdmin()));
    }

    function test_InitSetAdmin_Success() public {
        address admin = makeAddr("Admin");

        vm.expectEmit(target);
        emit InitSetAdmin.AdminSet(admin);
        emit Initialization.Initialized(1);
        InitSetAdmin(target).initSetAdmin(admin);

        assertEq(Storage.Admin().admin, admin);
    }

}

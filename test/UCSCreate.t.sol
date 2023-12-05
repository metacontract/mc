// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Test} from "forge-std/Test.sol";

import {UCS} from "../src/UCS.sol";
import {DictionaryUpgradeable} from "@ucs-contracts/dictionary/DictionaryUpgradeable.sol";

import {Dictionary} from "@ucs-contracts/dictionary/Dictionary.sol";
import {InitSetAdminOp} from "../src/ops/InitSetAdminOp.sol";

contract UCSTest is Test {
    address public deployer = makeAddr("DEPLOYER");

    DictionaryUpgradeable public dictionaryImpl;
    UCS public ucs;
    InitSetAdminOp public initSetAdminOp;

    function setUp() public {
        vm.startPrank(deployer);

        dictionaryImpl = new DictionaryUpgradeable();
        initSetAdminOp = new InitSetAdminOp();
        ucs = new UCS(address(dictionaryImpl), address(initSetAdminOp));

        // vm.stopPrank();
    }

    function test_create() public {
        UCS.OpsType[] memory _opsTypes = new UCS.OpsType[](1);
        _opsTypes[0] = UCS.OpsType.CloneOps;

        ucs.create(_opsTypes, deployer);
    }

    // function testFuzz_ProposeOp(Proposal calldata _fuzz_proposal) public {
    //     // vm.assume(_fuzz_proposal.bodies.length == 1);
    //     // vm.assume(_fuzz_proposal.bodies[0].ops.length < 10);
    //     // ProposeOp(proxy).propose(_fuzz_proposal);
    // }
}

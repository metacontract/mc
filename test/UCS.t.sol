// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Test} from "forge-std/Test.sol";

import {UCS} from "../src/UCS.sol";
import {DictionaryUpgradeable} from "@ucs-contracts/dictionary/DictionaryUpgradeable.sol";

import {Dictionary} from "@ucs-contracts/dictionary/Dictionary.sol";
import {InitSetAdminOp} from "../src/ops/InitSetAdminOp.sol";
import {CloneOp} from "../src/ops/CloneOp.sol";

contract UCSTest is Test {
    address public deployer = makeAddr("DEPLOYER");

    DictionaryUpgradeable public dictionaryImpl;
    UCS public ucs;
    InitSetAdminOp public initSetAdminOp;
    CloneOp public cloneOp;
    address public proxy;

    function setUp() public {
        vm.startPrank(deployer);

        dictionaryImpl = new DictionaryUpgradeable();
        initSetAdminOp = new InitSetAdminOp();
        cloneOp = new CloneOp();
        ucs = new UCS(address(dictionaryImpl), address(initSetAdminOp));

        UCS.SetOpsArgs[] memory _setOpsArgsList = new UCS.SetOpsArgs[](1);
        _setOpsArgsList[0] = UCS.SetOpsArgs({
            opsType: UCS.OpsType.CloneOps,
            selector: CloneOp.clone.selector,
            implementation: address(cloneOp)
        });
        ucs.setOps(_setOpsArgsList);
        // vm.stopPrank();
    }

    function test_create() public {
        UCS.OpsType[] memory _opsTypes = new UCS.OpsType[](1);
        _opsTypes[0] = UCS.OpsType.CloneOps;

        (,proxy) = ucs.create(_opsTypes, deployer);
    }

    function test_clone() public {
        test_create();

        address _clonedProxy = CloneOp(proxy).clone("");
        CloneOp(_clonedProxy).clone("");
    }

    // function testFuzz_ProposeOp(Proposal calldata _fuzz_proposal) public {
    //     // vm.assume(_fuzz_proposal.bodies.length == 1);
    //     // vm.assume(_fuzz_proposal.bodies[0].ops.length < 10);
    //     // ProposeOp(proxy).propose(_fuzz_proposal);
    // }
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Test} from "forge-std/Test.sol";

import {ERC7546Proxy} from "@ucs-contracts/src/proxy/ERC7546Proxy.sol";
import {Dictionary} from "@ucs-contracts/src/dictionary/Dictionary.sol";
import {ProposeOp} from "../src/ops/ProposeOp.sol";
import {SetAdminOp} from "../src/ops/SetAdminOp.sol";
import {Proposal} from "../src/StorageLib.sol";

contract OperationsTest is Test {
    address public deployer = makeAddr("DEPLOYER");
    Dictionary public dictionary;
    ProposeOp public proposeOp;
    SetAdminOp public setAdminOp;
    address public proxy;

    function setUp() public {
        vm.startPrank(deployer);
        proposeOp = new ProposeOp();
        setAdminOp = new SetAdminOp();
        dictionary = new Dictionary(deployer);
        Dictionary(dictionary).setImplementation(ProposeOp.propose.selector, address(proposeOp));
        Dictionary(dictionary).setImplementation(SetAdminOp.setAdmin.selector, address(setAdminOp));
        proxy = address(new ERC7546Proxy(address(dictionary), abi.encodeWithSelector(SetAdminOp.setAdmin.selector, deployer)));
        // vm.stopPrank();
    }

    // function testFuzz_ProposeOp(Proposal calldata _fuzz_proposal) public {
    //     // vm.assume(_fuzz_proposal.bodies.length == 1);
    //     // vm.assume(_fuzz_proposal.bodies[0].ops.length < 10);
    //     // ProposeOp(proxy).propose(_fuzz_proposal);
    // }
}

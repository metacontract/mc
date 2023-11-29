// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Test} from "forge-std/Test.sol";

import {ERC7546Proxy} from "ucs/proxy/ERC7546Proxy.sol";
import {Dictionary} from "ucs/dictionary/Dictionary.sol";
import {ProposeOp} from "../src/ops/consensus/ProposeOp.sol";
import {InitializeOp} from "../src/ops/initialize/InitializeOp.sol";

contract OperationsTest is Test {
    address public deployer = makeAddr("DEPLOYER");
    Dictionary public dictionary;
    ProposeOp public proposeOp;
    InitializeOp public initializeOp;
    address public proxy;

    function setUp() public {
        vm.startPrank(deployer);
        proposeOp = new ProposeOp();
        initializeOp = new InitializeOp();
        dictionary = new Dictionary(deployer);
        Dictionary(dictionary).setImplementation(ProposeOp.propose.selector, address(proposeOp));
        Dictionary(dictionary).setImplementation(InitializeOp.initialize.selector, address(initializeOp));
        proxy = address(new ERC7546Proxy(address(dictionary), abi.encodeWithSelector(InitializeOp.initialize.selector, deployer)));
        // vm.stopPrank();
    }

    function test_ProposeOp() public {
        ProposeOp(proxy).propose();
    }
}

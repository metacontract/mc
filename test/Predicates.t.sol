// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Test} from "forge-std/Test.sol";

import {ERC7546Proxy} from "ucs/proxy/ERC7546Proxy.sol";
import {Dictionary} from "ucs/dictionary/Dictionary.sol";
import {SetOwner} from "./mocks/SetOwner.sol";
import {GetOwner} from "./mocks/GetOwner.sol";
import {Initialize} from "./mocks/Initialize.sol";

contract PredicatesTest is Test {
    address public deployer = makeAddr("DEPLOYER");
    Dictionary public dictionary;
    SetOwner public setOwner;
    GetOwner public getOwner;
    Initialize public initialize;
    address public proxy;

    function setUp() public {
        vm.startPrank(deployer);
        setOwner = new SetOwner();
        getOwner = new GetOwner();
        initialize = new Initialize();
        dictionary = new Dictionary(deployer);
        Dictionary(dictionary).setImplementation(SetOwner.setOwner.selector, address(setOwner));
        Dictionary(dictionary).setImplementation(GetOwner.getOwner.selector, address(getOwner));
        Dictionary(dictionary).setImplementation(Initialize.initialize.selector, address(initialize));
        proxy = address(new ERC7546Proxy(address(dictionary), abi.encodeWithSelector(Initialize.initialize.selector, deployer)));
        // vm.stopPrank();
    }

    function testFuzz_SetOwner(address newOwner) public {
        GetOwner(proxy).getOwner();
        SetOwner(proxy).setOwner(newOwner);
        assertEq(GetOwner(proxy).getOwner(), newOwner);
    }
}

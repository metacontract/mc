// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {UCSDeployBase} from "./UCSDeployBase.sol";
import {ERC7546Utils} from "@ucs-contracts/src/proxy/ERC7546Utils.sol";

import {Proxy} from "@openzeppelin/contracts/proxy/Proxy.sol";

abstract contract UCSTestBase is UCSDeployBase, Test {
    modifier startPrankWithDeployer() {
        deployer = getAddressOr("DEPLOYER_ADDR", makeAddr("DEPLOYER"));
        vm.startPrank(deployer);
        _;
    }

    modifier ensureAddressIsNotPrecompile(address addr) {
        vm.assume(
            addr != address(1) &&
            addr != address(2) &&
            addr != address(3) &&
            addr != address(4) &&
            addr != address(5) &&
            addr != address(6) &&
            addr != address(7) &&
            addr != address(8) &&
            addr != address(9) &&
            addr != 0x4e59b44847b379578588920cA78FbF26c0B4956C &&
            addr != 0x7109709ECfa91a80626fF3989D68f67F5b1DD12D &&
            addr != 0x000000000000000000636F6e736F6c652e6c6f67
        );
        _;
    }

    function startPrankWith(string memory keyword) internal {
        tester = getAddressOr(keyword, makeAddr(keyword));
    }

    function createMockProxy(OpName[] memory opNames) public returns(address) {
        for (uint i; i < opNames.length; ++i) {
            availableOps.push(ops[opNames[i]]);
        }
        return address(new MockProxy(availableOps));
    }

    function injectCode(address target, bytes memory runtimeBytecode) public {
        vm.assume(runtimeBytecode.length > 0);
        vm.etch(target, newRuntimeBytecode);
        setDictionary(cloneOp, dictionary);
    }

    function injectDictionary(address target, address dictionary) public {
        injectAddressToStorage(target, ERC7546Utils.DICTIONARY_SLOT, dictionary);
    }

    function injectAddressToStorage(address target, bytes32 slot, address addr) public {
        vm.store(target, slot, bytes32(uint256(uint160(addr))));
    }
}

contract MockProxy is Proxy {
    bytes32 internal constant STORAGE_LOCATION = 0x64a9f0903a8f864d59bc40808555c0090d6ada027fd81884feeb2af9acdbc200;
    /// @custom:storage-location erc7021:ucs.mock.proxy
    struct Ops {
        mapping(bytes4 selector => address) ops;
    }
    function $Storage() internal pure returns(Ops storage $) { assembly { $.slot := STORAGE_LOCATION } }

    constructor (UCSDeployBase.Op[] memory ops) {
        for (uint i; i < ops.length; ++i) {
            $Storage().ops[ops[i].selector] = ops[i].implementation;
        }
    }

    function _implementation() internal view override returns(address) {
        return $Storage().ops[msg.sig];
    }
}

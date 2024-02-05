// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {UCSTestBase} from "../../../utils/UCSTestBase.sol";

import {CloneOp} from "../../../src/ops/CloneOp.sol";

contract CloneOpSpecTest is UCSTestBase {
    address cloneOp;

    function setUp() public startPrankWithDeployer {
        cloneOp = ops[OpName.Clone].implementation;
    }

    function test_Clone_Success(address dictionary, bytes memory newRuntimeBytecode) public {
        // Setup Stub Dictionary
        ignorePrecompiles(dictionary);
        vm.assume(newRuntimeBytecode.length > 0);
        vm.etch(dictionary, newRuntimeBytecode);
        setDictionary(cloneOp, dictionary);

        CloneOp(cloneOp).clone("");
    }

}

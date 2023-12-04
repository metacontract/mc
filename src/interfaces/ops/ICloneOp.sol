// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

interface ICloneOp {
    function clone(bytes calldata initData) external returns (address);
}

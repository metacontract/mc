// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

interface IClone {
    event ProxyCloned(address proxy);
    function clone(bytes calldata initData) external returns (address);
}

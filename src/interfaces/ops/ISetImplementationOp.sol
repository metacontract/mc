// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

interface ISetImplementationOp {
    event ImplementationSet(bytes4 selector, address implementation);
    function setImplementation(bytes4 selector, address implementation) external;
}

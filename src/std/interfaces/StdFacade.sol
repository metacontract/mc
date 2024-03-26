// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {IStd} from "./IStd.sol";

contract StdFacade is IStd {
    function initSetAdmin(address admin) external {}
    function getDeps() external view returns(Op[] memory ops) {}
    function clone(bytes calldata initData) external returns (address) {}
    function setImplementation(bytes4 selector, address implementation) external {}
}

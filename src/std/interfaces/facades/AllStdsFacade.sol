// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {IAllStds} from "../IAllStds.sol";

contract AllStdsFacade is IAllStds {
    function initSetAdmin(address admin) external {}
    function getDeps() external view returns(Op[] memory ops) {}
    function clone(bytes calldata initData) external returns (address) {}
    function setImplementation(bytes4 selector, address implementation) external {}
}

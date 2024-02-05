// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {IDefaultOps} from "../IDefaultOps.sol";

contract DefaultOpsFacade is IDefaultOps {
    function getDeps() external view returns(Op[] memory ops) {}
    function initSetAdmin(address admin) external {}
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {IDefaults} from "../IDefaults.sol";

contract DefaultsFacade is IDefaults {
    function getDeps() external view returns(Op[] memory ops) {}
    function initSetAdmin(address admin) external {}
}

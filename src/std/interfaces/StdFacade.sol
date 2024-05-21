// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {IStd} from "./IStd.sol";
import {GetFunctions} from "mc-std/functions/GetFunctions.sol";

contract StdFacade is IStd {
    function clone(bytes calldata initData) external returns (address proxy) {}
    function getFunctions() external view returns(GetFunctions.Function[] memory) {}
    function featureToggle(bytes4 selector) external {}
    function initSetAdmin(address admin) external {}
    function upgradeDictionary(address newDictionary) external {}
}

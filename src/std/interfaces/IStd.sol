// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IProxy} from "@ucs.mc/proxy/IProxy.sol";
import {Dep} from "../storage/Schema.sol";

interface IStd is IProxy {
    function clone(bytes calldata initData) external returns (address proxy);
    function getDeps() external view returns(Dep[] memory);
    function featureToggle(bytes4 selector) external;
    function initSetAdmin(address admin) external;
    function upgradeDictionary(address newDictionary) external;
}

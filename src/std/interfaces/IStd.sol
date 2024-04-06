// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC7546ProxyEvents} from "@ucs.mc/proxy/ERC7546ProxyEvents.sol";
import {Dep} from "../storage/Schema.sol";

interface IStd is ERC7546ProxyEvents {
    function clone(bytes calldata initData) external returns (address proxy);
    function getDeps() external view returns(Dep[] memory);
    function featureToggle(bytes4 selector) external;
    function initSetAdmin(address admin) external;
    function upgradeDictionary(address newDictionary) external;
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// import {IStd} from "./IStd.sol";
import {Schema, Dep} from "../storage/Schema.sol";
import {ERC7546ProxyEvents} from "@ucs-contracts/src/proxy/ERC7546ProxyEvents.sol";

contract StdFacade is ERC7546ProxyEvents {
    function clone(bytes calldata initData) external returns (address proxy) {}
    function getDeps() external view returns(Dep[] memory) {}
    function initSetAdmin(address admin) external {}
    function setImplementation(bytes4 selector, address implementation) external {}
}

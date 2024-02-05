// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {IGetDepsOp} from "./ops/IGetDepsOp.sol";
import {IInitSetAdminOp} from "./ops/IInitSetAdminOp.sol";
import {ERC7546ProxyEvents} from "@ucs-contracts/src/proxy/ERC7546ProxyEvents.sol";

interface IDefaultOps is
    IGetDepsOp,
    IInitSetAdminOp,
    ERC7546ProxyEvents
{}

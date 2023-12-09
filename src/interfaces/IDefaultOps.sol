// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {ICloneOp} from "./ops/ICloneOp.sol";
import {IInitSetAdminOp} from "./ops/IInitSetAdminOp.sol";
import {ISetImplementationOp} from "./ops/ISetImplementationOp.sol";
import {ERC7546ProxyEvents} from "@ucs-contracts/src/proxy/ERC7546ProxyEvents.sol";

interface IDefaultOps is
    ICloneOp,
    IInitSetAdminOp,
    ISetImplementationOp,
    ERC7546ProxyEvents
{}

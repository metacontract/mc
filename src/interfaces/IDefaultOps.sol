// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {ICloneOp} from "./ops/ICloneOp.sol";
import {IInitSetAdminOp} from "./ops/IInitSetAdminOp.sol";
import {ISetImplementationOp} from "./ops/ISetImplementationOp.sol";

interface IDefaultOps is
    ICloneOp,
    IInitSetAdminOp,
    ISetImplementationOp
{}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {ICloneOp} from "./ops/ICloneOp.sol";
import {ISetAdminOp} from "./ops/ISetAdminOp.sol";
import {ISetImplementationOp} from "./ops/ISetImplementationOp.sol";

interface IDAO is
    ICloneOp,
    ISetAdminOp,
    ISetImplementationOp
{}

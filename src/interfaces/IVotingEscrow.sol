// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {IProposeOp} from "./ops/IProposeOp.sol";
import {IVoteOp} from "./ops/IVoteOp.sol";

interface IVotingEscrow is
    IProposeOp,
    IVoteOp
{}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {Proposal} from "../../StorageLib.sol";

interface IProposeOp {
    function propose(Proposal calldata proposal) external;
}

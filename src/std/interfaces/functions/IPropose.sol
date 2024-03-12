// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {StorageSchema} from "../../storages/StorageSchema.sol";

interface IPropose {
    function propose() external;
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

// storage
import {StorageLib} from "../../StorageLib.sol";

contract InitializeOp {
    /// DO NOT USE STORAGE DIRECTLY !!!

    function initialize(address owner) public {
        StorageLib.$Member().members.push(owner);

    }
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {StorageLib} from "../StorageLib.sol";

library MsgSender {
    error NotOwner();
    function shouldBeOwner() external view {
        if (msg.sender != StorageLib.$Owner().owner) revert NotOwner();
    }
}

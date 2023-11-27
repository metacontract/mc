// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

// import {console2} from "forge-std/console2.sol";
import {StorageLib} from "../StorageLib.sol";

library MsgSender {
    error NotOwner();
    function shouldBeOwner() external view {
        if (msg.sender != StorageLib.getOwnerStorage().owner) revert NotOwner();
    }
}

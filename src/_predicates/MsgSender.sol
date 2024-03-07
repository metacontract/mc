// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {StorageRef} from "../std/storages/StorageRef.sol";
import {console2} from "forge-std/console2.sol";

library MsgSender {
    error NotAdmin();
    function shouldBeAdmin() internal view {
        console2.log(msg.sender);
        console2.log(StorageRef.Admin().admin);
        if (msg.sender != StorageRef.Admin().admin) revert NotAdmin();
    }

    error NotMember();
    function shouldBeMember() internal view {
        bool _isMember;
        address[] memory _members = StorageRef.Member().members;
        for (uint i; i < _members.length; ++i) {
            if (msg.sender == _members[i]) {
                _isMember = true;
                break;
            }
        }
        if (!_isMember) revert NotMember();
    }
}

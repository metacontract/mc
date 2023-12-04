// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {StorageLib} from "../StorageLib.sol";

library MsgSender {
    error NotAdmin();
    function shouldBeAdmin() internal view {
        if (msg.sender != StorageLib.$Admin().admin) revert NotAdmin();
    }

    error NotMember();
    function shouldBeMember() internal view {
        bool _isMember;
        address[] memory _members = StorageLib.$Member().members;
        for (uint i; i < _members.length; ++i) {
            if (msg.sender == _members[i]) {
                _isMember = true;
                break;
            }
        }
        if (!_isMember) revert NotMember();
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Storage} from "../../../storage/Storage.sol";
import {console} from "forge-std/console.sol";

library MsgSender {
    error NotAdmin();

    function shouldBeAdmin() internal view {
        console.log(msg.sender);
        console.log(Storage.Admin().admin);
        if (msg.sender != Storage.Admin().admin) revert NotAdmin();
    }

    error NotMember();

    function shouldBeMember() internal view {
        bool _isMember;
        address[] memory _members = Storage.Member().members;
        for (uint256 i; i < _members.length; ++i) {
            if (msg.sender == _members[i]) {
                _isMember = true;
                break;
            }
        }
        if (!_isMember) revert NotMember();
    }
}

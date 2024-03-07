// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// storage
import {IChangeDictionary} from "../interfaces/functions/IChangeDictionary.sol";
import {ERC7546Utils} from "@ucs-contracts/src/proxy/ERC7546Utils.sol";

// predicates
import {MsgSender} from "../../_predicates/MsgSender.sol";

contract ChangeDictionary is IChangeDictionary {
    /// DO NOT USE STORAGE DIRECTLY !!!

    modifier requires() {
        MsgSender.shouldBeAdmin();
        _;
    }

    modifier intents() {
        _;
    }

    function changeDictionary(address newDictionary) external requires intents {
        ERC7546Utils.upgradeDictionaryToAndCall({
            newDictionary: newDictionary,
            data: ""
        });
    }
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// storage
import {IChangeDictionaryOp} from "../interfaces/ops/IChangeDictionary.sol";
import {ERC7546Utils} from "@ucs-contracts/src/proxy/ERC7546Utils.sol";

// predicates
import {MsgSender} from "../predicates/MsgSender.sol";

contract ChangeDictionaryOp is IChangeDictionaryOp {
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

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

// storage
import {Storage} from "../storage/Storage.sol";
import {ISetImplementation} from "../interfaces/functions/ISetImplementation.sol";
import {IDictionary} from "@ucs-contracts/src/dictionary/IDictionary.sol";
import {ERC7546Utils} from "@ucs-contracts/src/proxy/ERC7546Utils.sol";

// predicates
import {MsgSender} from "../../_predicates/MsgSender.sol";

contract SetImplementation is ISetImplementation {
    /// DO NOT USE STORAGE DIRECTLY !!!

    modifier requires() {
        MsgSender.shouldBeAdmin();
        _;
    }

    modifier intents() {
        _;
    }

    function setImplementation(bytes4 selector, address implementation) external requires intents {
        IDictionary(ERC7546Utils.getDictionary()).setImplementation(selector, implementation);
        emit ImplementationSet(selector, implementation);
    }
}

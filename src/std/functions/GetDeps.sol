// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

// storage
// import {Storage} from "../storage/Storage.sol";
import {IGetDeps} from "../interfaces/functions/IGetDeps.sol";
import {ERC7546Utils} from "@ucs-contracts/src/proxy/ERC7546Utils.sol";
import {DictionaryBase} from "@ucs-contracts/src/dictionary/DictionaryBase.sol";

// predicates
// import {MsgSender} from "../predicates/MsgSender.sol";

contract GetDeps is IGetDeps {
    /// DO NOT USE STORAGE DIRECTLY !!!

    modifier requires() {
        _;
    }

    modifier intents() {
        _;
    }

    function getDeps() external view requires intents returns(Op[] memory ops) {
        DictionaryBase dictionary = DictionaryBase(ERC7546Utils.getDictionary());
        bytes4[] memory selectors = dictionary.supportsInterfaces();
        ops = new Op[](selectors.length);
        for (uint i; i < selectors.length; ++i) {
            ops[i].selector = selectors[i];
            ops[i].implementation = dictionary.getImplementation(selectors[i]);
        }
    }
}

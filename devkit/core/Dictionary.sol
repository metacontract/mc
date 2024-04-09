// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Methods
import {DictionaryLib} from "devkit/method/core/DictionaryLib.sol";
import {DictionaryKindLib} from "devkit/method/core/DictionaryKindLib.sol";
import {ProcessLib} from "devkit/method/debug/ProcessLib.sol";
import {Inspector} from "devkit/method/inspector/Inspector.sol";


/**====================
    📚 Dictionary
======================*/
struct Dictionary {
    address addr;
    DictionaryKind kind;
}
using DictionaryLib for Dictionary global;
//  Support Methods
using ProcessLib for Dictionary global;
using Inspector for Dictionary global;


    /**--------------------
        Dictionary Kind
    ----------------------*/
    enum DictionaryKind {
        undefined,
        Verifiable,
        Mock
    }
    using DictionaryKindLib for DictionaryKind global;

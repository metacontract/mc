// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Methods
import {DictionaryLib} from "devkit/method/core/DictionaryLib.sol";
import {DictionaryKindLib} from "devkit/method/core/DictionaryKindLib.sol";
import {ProcessLib} from "devkit/method/debug/ProcessLib.sol";


/**====================
    📚 Dictionary
======================*/
struct Dictionary {
    address addr;
    DictionaryKind kind;
}
using DictionaryLib for Dictionary global;
using ProcessLib for Dictionary global;

    enum DictionaryKind {
        undefined,
        Verifiable,
        Mock
    }
    using DictionaryKindLib for DictionaryKind global;

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Validation
import {check} from "devkit/error/Validation.sol";
import {Params} from "devkit/debug/Params.sol";
// Utils
import {AddressUtils} from "devkit/utils/AddressUtils.sol";
    using AddressUtils for address;
import {BoolUtils} from "devkit/utils/BoolUtils.sol";
    using BoolUtils for bool;
import {Bytes4Utils} from "devkit/utils/Bytes4Utils.sol";
    using Bytes4Utils for bytes4;
import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;
import {ForgeHelper} from "devkit/utils/ForgeHelper.sol";
// Debug
import {Debug} from "devkit/debug/Debug.sol";
// Core
import {Function} from "devkit/core/Function.sol";
import {Bundle} from "devkit/core/Bundle.sol";
// Test
import {MockDictionary} from "devkit/test/MockDictionary.sol";
// External Libs
import {DictionaryEtherscan} from "@ucs.mc/dictionary/DictionaryEtherscan.sol";
import {IDictionary} from "@ucs.mc/dictionary/IDictionary.sol";
import {IBeacon} from "@oz.mc/proxy/beacon/IBeacon.sol";
import {ERC1967Utils} from "@oz.mc/proxy/ERC1967/ERC1967Utils.sol";

import {DictionaryLib} from "devkit/method/core/DictionaryLib.sol";
import {DictionaryKindLib} from "devkit/method/core/DictionaryKindLib.sol";
import {ProcessLib} from "devkit/method/debug/ProcessLib.sol";

/**------------------------
    📚 UCS Dictionary
--------------------------*/
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

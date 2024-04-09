// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Error & Debug
import {ERR, throwError} from "devkit/error/Error.sol";
import {check} from "devkit/error/validation/Validation.sol";
import {Debug} from "devkit/debug/Debug.sol";
// Config
import {Config, ScanRange} from "devkit/config/Config.sol";
// Utils
import {AddressUtils} from "devkit/utils/AddressUtils.sol";
    using AddressUtils for address;
import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;
import {BoolUtils} from "devkit/utils/BoolUtils.sol";
    using BoolUtils for bool;
// Core
import {Dictionary} from "devkit/core/Dictionary.sol";

import {DictionaryRegistry} from "devkit/core/DictionaryRegistry.sol";


/**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    📘 Dictionary Registry
        📥 Add Dictionary
        🔼 Update Current Context Dictionary
        ♻️ Reset Current Context Dictionary
        🔍 Find Dictionary
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
library DictionaryRegistryLib {
    /**------------------------
        📥 Add Dictionary
    --------------------------*/
    function add(DictionaryRegistry storage dictionaries, string memory name, Dictionary memory dictionary) internal returns(DictionaryRegistry storage) {
        uint pid = dictionaries.startProcess("add");
        dictionaries.deployed[name] = dictionary;
        return dictionaries.finishProcess(pid);
    }

    function safeAdd(DictionaryRegistry storage dictionaries, string memory name, Dictionary memory dictionary) internal returns(DictionaryRegistry storage) {
        uint pid = dictionaries.startProcess("safeAdd");
        return dictionaries .add(name.assertNotEmpty(), dictionary.assertNotEmpty())
                            .finishProcess(pid);
    }


    /**-----------------------------------------
        🔼 Update Current Context Dictionary
    -------------------------------------------*/
    function safeUpdate(DictionaryRegistry storage dictionaries, Dictionary memory dictionary) internal returns(DictionaryRegistry storage) {
        uint pid = dictionaries.startProcess("safeUpdate");
        return dictionaries .update(dictionary.assertNotEmpty()).finishProcess(pid);
    }
    function update(DictionaryRegistry storage dictionaries, Dictionary memory dictionary) internal returns(DictionaryRegistry storage) {
        uint pid = dictionaries.startProcess("update");
        dictionaries.currentDictionary = dictionary;
        return dictionaries.finishProcess(pid);
    }


    /**----------------------------------------
        ♻️ Reset Current Context Dictionary
    ------------------------------------------*/
    function reset(DictionaryRegistry storage dictionaries) internal returns(DictionaryRegistry storage) {
        uint pid = dictionaries.startProcess("reset");
        delete dictionaries.currentDictionary;
        return dictionaries.finishProcess(pid);
    }


    /**------------------------
        🔍 Find Dictionary
    --------------------------*/
    function find(DictionaryRegistry storage dictionaries, string memory name) internal returns(Dictionary storage) {
        uint pid = dictionaries.startProcess("find");
        return dictionaries.deployed[name]
                            .assertExists()
                            .finishProcessInStorage(pid);
    }
    function findCurrentDictionary(DictionaryRegistry storage dictionaries) internal returns(Dictionary storage) {
        uint pid = dictionaries.startProcess("findCurrentDictionary");
        return dictionaries.currentDictionary.assertExists().finishProcessInStorage(pid);
    }

}

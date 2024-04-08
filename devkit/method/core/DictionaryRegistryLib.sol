// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Error & Debug
import {ERR, throwError} from "devkit/error/Error.sol";
import {check} from "devkit/error/Validation.sol";
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

/******************************
    📚 Dictionary Registry
*******************************/
/**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    << Primary >>
        📥 Add Dictionary
        🔼 Update Current Context Dictionary
        ♻️ Reset Current Context Dictionary
        🔍 Find Dictionary
        🏷 Generate Unique Name
    << Helper >>
        🧐 Inspectors & Assertions
        🐞 Debug
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
library DictionaryRegistryLib {


    /**------------------------
        📥 Add Dictionary
    --------------------------*/
    function add(DictionaryRegistry storage dictionaries, string memory name, Dictionary memory dictionary) internal returns(DictionaryRegistry storage) {
        uint pid = dictionaries.startProcess("add");
        bytes32 nameHash = name.calcHash();
        if (dictionary.isNotMock()) {
            dictionaries.deployed[nameHash] = dictionary;
        }
        if (dictionary.isMock()) {
            dictionaries.mocks[nameHash] = dictionary;
        }
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
        return dictionaries.deployed[name.safeCalcHash()]
                            .assertExists()
                            .finishProcessInStorage(pid);
    }
    function findCurrentDictionary(DictionaryRegistry storage dictionaries) internal returns(Dictionary storage) {
        uint pid = dictionaries.startProcess("findCurrentDictionary");
        return dictionaries.currentDictionary.assertExists().finishProcessInStorage(pid);
    }
    function findMockDictionary(DictionaryRegistry storage dictionaries, string memory name) internal returns(Dictionary storage) {
        uint pid = dictionaries.startProcess("findMockDictionary");
        return dictionaries.mocks[name.safeCalcHash()].assertExists().finishProcessInStorage(pid);
    }


    /**-----------------------------
        🏷 Generate Unique Name
    -------------------------------*/
    function genUniqueName(DictionaryRegistry storage dictionaries, string memory baseName) internal returns(string memory name) {
        uint pid = dictionaries.startProcess("genUniqueName");
        ScanRange memory range = Config().SCAN_RANGE;
        for (uint i = range.START; i <= range.END; ++i) {
            name = baseName.toSequential(i);
            if (dictionaries.existsInDeployed(name).isFalse()) return name.recordExecFinish(pid);
        }
        throwError(ERR.FIND_NAME_OVER_RANGE);
    }
    function genUniqueName(DictionaryRegistry storage dictionaries) internal returns(string memory name) {
        return dictionaries.genUniqueName(Config().DEFAULT_DICTIONARY_NAME);
    }
    function genUniqueDuplicatedName(DictionaryRegistry storage dictionaries) internal returns(string memory name) {
        return dictionaries.genUniqueName(Config().DEFAULT_DICTIONARY_DUPLICATED_NAME);
    }

    function genUniqueMockName(DictionaryRegistry storage dictionaries) internal returns(string memory name) {
        uint pid = dictionaries.startProcess("genUniqueName");
        ScanRange memory range = Config().SCAN_RANGE;
        for (uint i = range.START; i <= range.END; ++i) {
            name = Config().DEFAULT_DICTIONARY_MOCK_NAME.toSequential(i);
            if (dictionaries.existsInMocks(name).isFalse()) return name.recordExecFinish(pid);
        }
        throwError(ERR.FIND_NAME_OVER_RANGE);
    }



    /**-------------------------------
        🧐 Inspectors & Assertions
    ---------------------------------*/
    function existsInDeployed(DictionaryRegistry storage dictionaries, string memory name) internal returns(bool) {
        return dictionaries.deployed[name.safeCalcHash()].exists();
    }
    function existsInMocks(DictionaryRegistry storage dictionaries, string memory name) internal returns(bool) {
        return dictionaries.mocks[name.safeCalcHash()].exists();
    }

}

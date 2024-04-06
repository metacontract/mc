// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Error & Debug
import {ERR, throwError} from "devkit/error/Error.sol";
import {check} from "devkit/error/Validation.sol";
import {Debug} from "devkit/debug/Debug.sol";
// Config
import {Config, ScanRange} from "devkit/config/Config.sol";
// Utils
import {AddressUtils} from "../../utils/AddressUtils.sol";
    using AddressUtils for address;
import {StringUtils} from "../../utils/StringUtils.sol";
    using StringUtils for string;
import {BoolUtils} from "../../utils/BoolUtils.sol";
    using BoolUtils for bool;
// Core
import {Dictionary} from "./Dictionary.sol";


/**-------------------------------
    📚 UCS Dictionary Registry
---------------------------------*/
using DictionaryRegistryLib for DictionaryRegistry global;
struct DictionaryRegistry {
    mapping(bytes32 nameHash => Dictionary) deployed;
    mapping(bytes32 nameHash => Dictionary) mocks;
    Dictionary currentDictionary;
}

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
    string constant LIB_NAME = "DictionaryRegistryLib";


    /**------------------------
        📥 Add Dictionary
    --------------------------*/
    function add(DictionaryRegistry storage dictionaries, string memory name, Dictionary memory dictionary) internal returns(DictionaryRegistry storage) {
        uint pid = dictionaries.recordExecStart("add");
        bytes32 nameHash = name.calcHash();
        if (dictionary.isNotMock()) {
            dictionaries.deployed[nameHash] = dictionary;
        }
        if (dictionary.isMock()) {
            dictionaries.mocks[nameHash] = dictionary;
        }
        return dictionaries.recordExecFinish(pid);
    }

    function safeAdd(DictionaryRegistry storage dictionaries, string memory name, Dictionary memory dictionary) internal returns(DictionaryRegistry storage) {
        uint pid = dictionaries.recordExecStart("safeAdd");
        return dictionaries .add(name.assertNotEmpty(), dictionary.assertNotEmpty())
                            .recordExecFinish(pid);
    }


    /**-----------------------------------------
        🔼 Update Current Context Dictionary
    -------------------------------------------*/
    function safeUpdate(DictionaryRegistry storage dictionaries, Dictionary memory dictionary) internal returns(DictionaryRegistry storage) {
        uint pid = dictionaries.recordExecStart("safeUpdate");
        return dictionaries .update(dictionary.assertNotEmpty()).recordExecFinish(pid);
    }
    function update(DictionaryRegistry storage dictionaries, Dictionary memory dictionary) internal returns(DictionaryRegistry storage) {
        uint pid = dictionaries.recordExecStart("update");
        dictionaries.currentDictionary = dictionary;
        return dictionaries.recordExecFinish(pid);
    }


    /**----------------------------------------
        ♻️ Reset Current Context Dictionary
    ------------------------------------------*/
    function reset(DictionaryRegistry storage dictionaries) internal returns(DictionaryRegistry storage) {
        uint pid = dictionaries.recordExecStart("reset");
        delete dictionaries.currentDictionary;
        return dictionaries.recordExecFinish(pid);
    }


    /**------------------------
        🔍 Find Dictionary
    --------------------------*/
    function find(DictionaryRegistry storage dictionaries, string memory name) internal returns(Dictionary storage) {
        uint pid = dictionaries.recordExecStart("find");
        return dictionaries.deployed[name.safeCalcHash()]
                            .assertExists()
                            .recordExecFinishInStorage(pid);
    }
    function findCurrentDictionary(DictionaryRegistry storage dictionaries) internal returns(Dictionary storage) {
        uint pid = dictionaries.recordExecStart("findCurrentDictionary");
        return dictionaries.currentDictionary.assertExists().recordExecFinishInStorage(pid);
    }
    function findMockDictionary(DictionaryRegistry storage dictionaries, string memory name) internal returns(Dictionary storage) {
        uint pid = dictionaries.recordExecStart("findMockDictionary");
        return dictionaries.mocks[name.safeCalcHash()].assertExists().recordExecFinishInStorage(pid);
    }


    /**-----------------------------
        🏷 Generate Unique Name
    -------------------------------*/
    function genUniqueName(DictionaryRegistry storage dictionaries, string memory baseName) internal returns(string memory name) {
        uint pid = dictionaries.recordExecStart("genUniqueName");
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
        uint pid = dictionaries.recordExecStart("genUniqueName");
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


    /**----------------
        🐞 Debug
    ------------------*/
    /**
        Record Start
     */
    function recordExecStart(DictionaryRegistry storage, string memory funcName, string memory params) internal returns(uint) {
        return Debug.recordExecStart(LIB_NAME, funcName, params);
    }
    function recordExecStart(DictionaryRegistry storage dictionaries, string memory funcName) internal returns(uint) {
        return dictionaries.recordExecStart(funcName, "");
    }

    /**
        Record Finish
     */
    function recordExecFinish(DictionaryRegistry storage dictionaries, uint pid) internal returns(DictionaryRegistry storage) {
        Debug.recordExecFinish(pid);
        return dictionaries;
    }

}

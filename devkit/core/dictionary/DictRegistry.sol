// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Global Methods
import "../../utils/GlobalMethods.sol";
// Config
import {Config} from "../../Config.sol";
// Errors
import {Errors} from "../../errors/Errors.sol";
// Utils
import {AddressUtils} from "../../utils/AddressUtils.sol";
    using AddressUtils for address;
import {StringUtils} from "../../utils/StringUtils.sol";
    using StringUtils for string;
import {BoolUtils} from "../../utils/BoolUtils.sol";
    using BoolUtils for bool;
// Core
import {Dictionary} from "./Dictionary.sol";


/*************************
    📚 UCS Dictionary
**************************/
using DictRegistryUtils for DictRegistry global;
struct DictRegistry {
    mapping(bytes32 nameHash => Dictionary) deployed;
    mapping(bytes32 nameHash => Dictionary) mocks;
    Dictionary currentDictionary;
}

library DictRegistryUtils {
    string constant LIB_NAME = "DictionaryRegistry";

    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    << Primary >>
        📥 Add Dictionary
        🔼 Update Current Context Dictionary
        🔍 Find Dictionary
        🏷 Generate Unique Name
    << Helper >>
        🧐 Inspectors & Assertions
        🐞 Debug
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/


    /**------------------------
        📥 Add Dictionary
    --------------------------*/
    function add(DictRegistry storage dictionaries, string memory name, Dictionary memory dictionary) internal returns(DictRegistry storage) {
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

    function safeAdd(DictRegistry storage dictionaries, string memory name, Dictionary memory dictionary) internal returns(DictRegistry storage) {
        uint pid = dictionaries.recordExecStart("safeAdd");
        return dictionaries .add(name.assertNotEmpty(), dictionary.assertNotEmpty())
                            .recordExecFinish(pid);
    }


    /**-----------------------------------------
        🔼 Update Current Context Dictionary
    -------------------------------------------*/
    function safeUpdate(DictRegistry storage dictionaries, Dictionary memory dictionary) internal returns(DictRegistry storage) {
        uint pid = dictionaries.recordExecStart("safeUpdate");
        return dictionaries .update(dictionary.assertNotEmpty()).recordExecFinish(pid);
    }
    function update(DictRegistry storage dictionaries, Dictionary memory dictionary) internal returns(DictRegistry storage) {
        uint pid = dictionaries.recordExecStart("update");
        dictionaries.currentDictionary = dictionary;
        return dictionaries.recordExecFinish(pid);
    }


    /**----------------------------------------
        ♻️ Reset Current Context Dictionary
    ------------------------------------------*/
    function reset(DictRegistry storage dictionaries) internal returns(DictRegistry storage) {
        uint pid = dictionaries.recordExecStart("reset");
        delete dictionaries.currentDictionary;
        return dictionaries.recordExecFinish(pid);
    }


    /**------------------------
        🔍 Find Dictionary
    --------------------------*/
    function find(DictRegistry storage dictionaries, string memory name) internal returns(Dictionary storage) {
        uint pid = dictionaries.recordExecStart("find");
        return dictionaries.deployed[name.safeCalcHash()]
                            .assertExists()
                            .recordExecFinishInStorage(pid);
    }
    function findCurrentDictionary(DictRegistry storage dictionaries) internal returns(Dictionary storage) {
        uint pid = dictionaries.recordExecStart("findCurrentDictionary");
        return dictionaries.currentDictionary.assertExists().recordExecFinishInStorage(pid);
    }
    function findMockDictionary(DictRegistry storage dictionaries, string memory name) internal returns(Dictionary storage) {
        uint pid = dictionaries.recordExecStart("findMockDictionary");
        return dictionaries.mocks[name.safeCalcHash()].assertExists().recordExecFinishInStorage(pid);
    }


    /**-----------------------------
        🏷 Generate Unique Name
    -------------------------------*/
    function genUniqueName(DictRegistry storage dictionaries, string memory baseName) internal returns(string memory name) {
        uint pid = dictionaries.recordExecStart("genUniqueName");
        Config.ScanRange memory range = Config.SCAN_RANGE();
        for (uint i = range.start; i <= range.end; ++i) {
            name = baseName.toSequential(i);
            if (dictionaries.existsInDeployed(name).isFalse()) return name.recordExecFinish(pid);
        }
        throwError(Errors.FIND_NAME_OVER_RANGE);
    }
    function genUniqueName(DictRegistry storage dictionaries) internal returns(string memory name) {
        return dictionaries.genUniqueName(Config.DEFAULT_DICTIONARY_NAME);
    }
    function genUniqueDuplicatedName(DictRegistry storage dictionaries) internal returns(string memory name) {
        return dictionaries.genUniqueName(Config.DEFAULT_DICTIONARY_DUPLICATED_NAME);
    }

    function genUniqueMockName(DictRegistry storage dictionaries) internal returns(string memory name) {
        uint pid = dictionaries.recordExecStart("genUniqueName");
        Config.ScanRange memory range = Config.SCAN_RANGE();
        for (uint i = range.start; i <= range.end; ++i) {
            name = Config.DEFAULT_DICTIONARY_MOCK_NAME.toSequential(i);
            if (dictionaries.existsInMocks(name).isFalse()) return name.recordExecFinish(pid);
        }
        throwError(Errors.FIND_NAME_OVER_RANGE);
    }



    /**-------------------------------
        🧐 Inspectors & Assertions
    ---------------------------------*/
    function existsInDeployed(DictRegistry storage dictionaries, string memory name) internal returns(bool) {
        return dictionaries.deployed[name.safeCalcHash()].exists();
    }
    function existsInMocks(DictRegistry storage dictionaries, string memory name) internal returns(bool) {
        return dictionaries.mocks[name.safeCalcHash()].exists();
    }


    /**----------------
        🐞 Debug
    ------------------*/
    /**
        Record Start
     */
    function recordExecStart(DictRegistry storage, string memory funcName, string memory params) internal returns(uint) {
        return Debug.recordExecStart(LIB_NAME, funcName, params);
    }
    function recordExecStart(DictRegistry storage dictionaries, string memory funcName) internal returns(uint) {
        return dictionaries.recordExecStart(funcName, "");
    }

    /**
        Record Finish
     */
    function recordExecFinish(DictRegistry storage dictionaries, uint pid) internal returns(DictRegistry storage) {
        Debug.recordExecFinish(pid);
        return dictionaries;
    }

}

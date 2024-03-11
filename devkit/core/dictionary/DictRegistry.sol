// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Global Methods
import "@devkit/utils/GlobalMethods.sol";
// Config
import {Config} from "@devkit/Config.sol";
// Errors
import {ERR_FIND_NAME_OVER_RANGE} from "@devkit/errors/Errors.sol";
// Utils
import {AddressUtils} from "@devkit/utils/AddressUtils.sol";
    using AddressUtils for address;
import {StringUtils} from "@devkit/utils/StringUtils.sol";
    using StringUtils for string;
import {ForgeHelper} from "@devkit/utils/ForgeHelper.sol";
// Core
import {Dictionary} from "@devkit/core/dictionary/Dictionary.sol";
// Test
import {MockDictionary} from "@devkit/test/MockDictionary.sol";

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
    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~
        📥 Safe Add Dictionary
        🔍 Find Dictionary
        🔧 Helper Methods
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/


    /**---------------------------
        📥 Safe Add Dictionary
    -----------------------------*/
    string constant safeAdd_ = "Safe Add Dictionary to DevKitEnv";
    function safeAdd(DictRegistry storage dictionaries, string memory name, Dictionary memory dictionary) internal returns(DictRegistry storage) {
        return dictionaries.add(name.assertNotEmpty(), dictionary.assertNotEmpty());
    }
    function add(DictRegistry storage dictionaries, string memory name, Dictionary memory dictionary) internal returns(DictRegistry storage) {
        bytes32 nameHash = name.calcHash();
        if (dictionary.isNotMock()) {
            dictionaries.deployed[nameHash] = dictionary;
        }
        if (dictionary.isMock()) {
            dictionaries.mocks[nameHash] = dictionary;
        }
        return dictionaries;
    }


    /**------------------------
        🔍 Find Dictionary
    --------------------------*/
    string constant find_ = "Find Dictionary";
    function find(DictRegistry storage dictionaries, string memory name) internal returns(Dictionary storage) {
        return dictionaries.deployed[name.safeCalcHash()]
                            .assertExists();
    }
    string constant findCurrentDictionary_ = "Find Current Dictionary";
    function findCurrentDictionary(DictRegistry storage dictionaries) internal returns(Dictionary storage) {
        return dictionaries.currentDictionary.assertExists();
    }
    string constant findMockDictionary_ = "Find Mock Dictionary";
    function findMockDictionary(DictRegistry storage dictionaries, string memory name) internal returns(Dictionary storage) {
        return dictionaries.mocks[name.safeCalcHash()].assertExists();
    }


    /**-----------------------
        🔧 Helper Methods
    -------------------------*/
    function exists(DictRegistry storage dictionaries, string memory name) internal returns(bool) {
        return dictionaries.deployed[name.safeCalcHash()].exists();
    }

    function findUnusedName(
        DictRegistry storage dictionaries,
        string memory baseName
    ) internal returns(string memory name) {
        (uint start, uint end) = Config.SCAN_RANGE();

        for (uint i = start; i <= end; ++i) {
            name = ForgeHelper.appendNumberToNameIfNotOne(baseName, i);
            if (!dictionaries.exists(name)) return name;
        }

        throwError(ERR_FIND_NAME_OVER_RANGE);
    }

    function findUnusedDictionaryName(DictRegistry storage dictionaries) internal returns(string memory name) {
        return dictionaries.findUnusedName("Dictionary");
    }

    function findUnusedDuplicatedDictionaryName(DictRegistry storage dictionaries) internal returns(string memory name) {
        return dictionaries.findUnusedName("DuplicatedDictionary");
    }

    /**----------------------
        🔼 Update Context
    ------------------------*/
    string constant safeUpdate_ = "Safe Update DevKit Context";

    /**----- 📚 Dictionary -------*/
    function safeUpdate(DictRegistry storage dictionaries, Dictionary memory dictionary) internal returns(DictRegistry storage) {
        return dictionaries.update(dictionary.assertNotEmpty());
    }
    function update(DictRegistry storage dictionaries, Dictionary memory dictionary) internal returns(DictRegistry storage) {
        dictionaries.currentDictionary = dictionary;
        return dictionaries;
    }




    /**-----------------------
        🔧 Helper Methods
    -------------------------*/
    function findUnusedName(
        DictRegistry storage dictionaries,
        function(DictRegistry storage, string memory) returns(bool) existsFunc,
        string memory baseName
    ) internal returns(string memory name) {
        (uint start, uint end) = Config.SCAN_RANGE();

        for (uint i = start; i <= end; ++i) {
            name = ForgeHelper.appendNumberToNameIfNotOne(baseName, i);
            if (!existsFunc(dictionaries, name)) return name;
        }

        throwError(ERR_FIND_NAME_OVER_RANGE);
    }

    function findUnusedMockDictionaryName(DictRegistry storage dictionaries) internal returns(string memory) {
        return dictionaries.findUnusedName(existsMockDictionary, "MockDictionary");
    }

    function existsMockDictionary(DictRegistry storage dictionaries, string memory name) internal returns(bool) {
        return dictionaries.mocks[name.safeCalcHash()].exists();
    }

}

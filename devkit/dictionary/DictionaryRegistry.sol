// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "DevKit/common/Errors.sol";

import {DictionaryBase} from "@ucs-contracts/src/dictionary/DictionaryBase.sol";
import {DictionaryEtherscan} from "@ucs-contracts/src/dictionary/DictionaryEtherscan.sol";
import {IDictionary} from "@ucs-contracts/src/dictionary/IDictionary.sol";

import {DevUtils} from "DevKit/common/DevUtils.sol";
import {Dictionary, DictionaryUtils} from "./Dictionary.sol";
import {ForgeHelper} from "DevKit/common/ForgeHelper.sol";
import {MockDictionary} from "./mocks/MockDictionary.sol";
import {FuncInfo} from "../functions/FuncInfo.sol";

/*************************
    📚 UCS Dictionary
**************************/
using DictionaryRegistryUtils for DictionaryRegistry global;
struct DictionaryRegistry {
    mapping(bytes32 nameHash => Dictionary) deployed;
    mapping(bytes32 nameHash => Dictionary) mocks;
    Dictionary currentDictionary;
}

library DictionaryRegistryUtils {
    using DevUtils for address;
    using DevUtils for string;
    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~
        📥 Safe Add Dictionary
        🔍 Find Dictionary
        🔧 Helper Methods
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/


    /**---------------------------
        📥 Safe Add Dictionary
    -----------------------------*/
    string constant safeAdd_ = "Safe Add Dictionary to DevKitEnv";
    function safeAdd(DictionaryRegistry storage dictionaries, string memory name, Dictionary memory dictionary) internal returns(DictionaryRegistry storage) {
        return dictionaries.add(name.assertNotEmptyAt(safeAdd_), dictionary.assertNotEmptyAt(safeAdd_));
    }
    function add(DictionaryRegistry storage dictionaries, string memory name, Dictionary memory dictionary) internal returns(DictionaryRegistry storage) {
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
    function find(DictionaryRegistry storage dictionaries, string memory name) internal returns(Dictionary storage) {
        return dictionaries.deployed[name.safeCalcHashAt(find_)]
                            .assertExistsAt(find_);
    }
    string constant findCurrentDictionary_ = "Find Current Dictionary";
    function findCurrentDictionary(DictionaryRegistry storage dictionaries) internal returns(Dictionary storage) {
        return dictionaries.currentDictionary.assertExistsAt(find_);
    }
    string constant findMockDictionary_ = "Find Mock Dictionary";
    function findMockDictionary(DictionaryRegistry storage dictionaries, string memory name) internal returns(Dictionary storage) {
        return dictionaries.mocks[name.safeCalcHashAt(findMockDictionary_)].assertExistsAt(findMockDictionary_);
    }


    /**-----------------------
        🔧 Helper Methods
    -------------------------*/
    function exists(DictionaryRegistry storage dictionaries, string memory name) internal returns(bool) {
        return dictionaries.deployed[name.safeCalcHashAt("")].exists();
    }

    function findUnusedName(
        DictionaryRegistry storage dictionaries,
        string memory baseName
    ) internal returns(string memory name) {
        (uint start, uint end) = DevUtils.getScanRange();

        for (uint i = start; i <= end; ++i) {
            name = ForgeHelper.appendNumberToNameIfNotOne(baseName, i);
            if (!dictionaries.exists(name)) return name;
        }

        DevUtils.revertUnusedNameNotFound();
    }

    function findUnusedDictionaryName(DictionaryRegistry storage dictionaries) internal returns(string memory name) {
        return dictionaries.findUnusedName("Dictionary");
    }

    function findUnusedDuplicatedDictionaryName(DictionaryRegistry storage dictionaries) internal returns(string memory name) {
        return dictionaries.findUnusedName("DuplicatedDictionary");
    }

    /**----------------------
        🔼 Update Context
    ------------------------*/
    string constant safeUpdate_ = "Safe Update DevKit Context";

    /**----- 📚 Dictionary -------*/
    function safeUpdate(DictionaryRegistry storage dictionaries, Dictionary memory dictionary) internal returns(DictionaryRegistry storage) {
        return dictionaries.update(dictionary.assertNotEmptyAt(safeUpdate_));
    }
    function update(DictionaryRegistry storage dictionaries, Dictionary memory dictionary) internal returns(DictionaryRegistry storage) {
        dictionaries.currentDictionary = dictionary;
        return dictionaries;
    }




    /**-----------------------
        🔧 Helper Methods
    -------------------------*/
    function findUnusedName(
        DictionaryRegistry storage dictionaries,
        function(DictionaryRegistry storage, string memory) returns(bool) existsFunc,
        string memory baseName
    ) internal returns(string memory name) {
        (uint start, uint end) = DevUtils.getScanRange();

        for (uint i = start; i <= end; ++i) {
            name = ForgeHelper.appendNumberToNameIfNotOne(baseName, i);
            if (!existsFunc(dictionaries, name)) return name;
        }

        DevUtils.revertUnusedNameNotFound();
    }

    function findUnusedMockDictionaryName(DictionaryRegistry storage dictionaries) internal returns(string memory) {
        return dictionaries.findUnusedName(existsMockDictionary, "MockDictionary");
    }

    function existsMockDictionary(DictionaryRegistry storage dictionaries, string memory name) internal returns(bool) {
        return dictionaries.mocks[name.safeCalcHashAt("")].exists();
    }

}

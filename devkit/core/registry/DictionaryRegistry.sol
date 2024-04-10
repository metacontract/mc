// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**--------------------------
    Apply Support Methods
----------------------------*/
import {ProcessLib} from "devkit/core/method/debug/ProcessLib.sol";
    using ProcessLib for DictionaryRegistry global;
import {Inspector} from "devkit/core/method/inspector/Inspector.sol";
    using Inspector for DictionaryRegistry global;

// Context
import {Current} from "devkit/core/method/context/Current.sol";
// Core Type
import {Dictionary} from "devkit/core/types/Dictionary.sol";
import {Require} from "devkit/error/Require.sol";


/**============================
    📘 Dictionary Registry
==============================*/
using DictionaryRegistryLib for DictionaryRegistry global;
struct DictionaryRegistry {
    mapping(string name => Dictionary) deployed;
    Current current;
    Dictionary currentDictionary;
}
library DictionaryRegistryLib {
    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        📥 Add Dictionary
        🔍 Find Dictionary
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

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
        Require.notEmpty(name);
        Require.notEmpty(dictionary);
        return dictionaries .add(name, dictionary)
                            .finishProcess(pid);
    }


    /**-----------------------------------------
        🔼 Update Current Context Dictionary
    -------------------------------------------*/
    function safeUpdate(DictionaryRegistry storage dictionaries, Dictionary memory dictionary) internal returns(DictionaryRegistry storage) {
        uint pid = dictionaries.startProcess("safeUpdate");
        Require.notEmpty(dictionary);
        return dictionaries .update(dictionary).finishProcess(pid);
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
        Require.exists(dictionaries.deployed[name]);
        return dictionaries.deployed[name].finishProcessInStorage(pid);
    }
    function findCurrentDictionary(DictionaryRegistry storage dictionaries) internal returns(Dictionary storage) {
        uint pid = dictionaries.startProcess("findCurrentDictionary");
        Require.exists(dictionaries.currentDictionary);
        return dictionaries.currentDictionary.finishProcessInStorage(pid);
    }

}

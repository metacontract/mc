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
    mapping(string name => Dictionary) dictionaries;
    Current current;
    Dictionary currentDictionary;
}
library DictionaryRegistryLib {

    /**---------------------------
        🗳️ Insert Dictionary
    -----------------------------*/
    function insert(DictionaryRegistry storage registry, string memory name, Dictionary memory dictionary) internal returns(DictionaryRegistry storage) {
        uint pid = registry.startProcess("insert");
        Require.notEmpty(name);
        Require.notEmpty(dictionary);
        registry.dictionaries[name] = dictionary;
        return registry.finishProcess(pid);
    }


    /**------------------------
        🔍 Find Dictionary
    --------------------------*/
    function find(DictionaryRegistry storage registry, string memory name) internal returns(Dictionary storage) {
        uint pid = registry.startProcess("find");
        Require.notEmpty(name);
        Dictionary storage dictionary = registry.dictionaries[name];
        Require.exists(dictionary);
        return dictionary.finishProcessInStorage(pid);
    }
    function findCurrent(DictionaryRegistry storage registry) internal returns(Dictionary storage) {
        uint pid = registry.startProcess("findCurrent");
        string memory name = registry.current.name;
        Require.notEmpty(name);
        return registry.find(name).finishProcessInStorage(pid);
    }

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {ProcessLib} from "devkit/core/method/debug/ProcessLib.sol";
    using ProcessLib for DictionaryRegistry global;
import {Inspector} from "devkit/core/method/inspector/Inspector.sol";
    using Inspector for DictionaryRegistry global;

// Context
import {Current} from "devkit/core/method/context/Current.sol";
// Core Type
import {Dictionary, DictionaryLib} from "devkit/core/types/Dictionary.sol";
import {Bundle} from "devkit/core/types/Bundle.sol";
import {Require} from "devkit/error/Require.sol";


/**============================
    📘 Dictionary Registry
==============================*/
using DictionaryRegistryLib for DictionaryRegistry global;
struct DictionaryRegistry {
    mapping(string name => Dictionary) dictionaries;
    Current current;
}
library DictionaryRegistryLib {

    /**---------------------
        🚀 Deploy Proxy
    -----------------------*/
    function deploy(DictionaryRegistry storage registry, string memory name, Bundle storage bundle, address owner) internal returns(Dictionary storage) {
        uint pid = registry.startProcess("deploy");
        // Require.isNotEmpty(dictionary); TODO
        registry.insert(name, DictionaryLib.deploy(owner));
        registry.findCurrent().set(bundle).upgradeFacade(bundle.facade);
        return registry.findCurrent().finishProcessInStorage(pid);
    }


    /**---------------------------
        🗳️ Insert Dictionary
    -----------------------------*/
    function insert(DictionaryRegistry storage registry, string memory name, Dictionary memory dictionary) internal returns(Dictionary storage) {
        uint pid = registry.startProcess("insert");
        Require.notEmpty(name);
        Require.notEmpty(dictionary);
        registry.dictionaries[name] = dictionary;
        registry.current.update(name);
        return registry.findCurrent().finishProcessInStorage(pid);
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

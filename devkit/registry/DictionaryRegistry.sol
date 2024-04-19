// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {ProcessManager} from "devkit/system/debug/Process.sol";
import {Inspector} from "devkit/types/Inspector.sol";
import {NameGenerator} from "devkit/utils/mapping/NameGenerator.sol";
// Validation
import {Validate} from "devkit/system/Validate.sol";

// Context
import {Current} from "devkit/registry/context/Current.sol";
// Core Type
import {Dictionary, DictionaryLib} from "devkit/core/Dictionary.sol";
import {Bundle} from "devkit/core/Bundle.sol";


//////////////////////////////////////////////////////////////////
//  📘 Dictionary Registry    ////////////////////////////////////
    using DictionaryRegistryLib for DictionaryRegistry global;
    using ProcessManager for DictionaryRegistry global;
    using Inspector for DictionaryRegistry global;
//////////////////////////////////////////////////////////////////
struct DictionaryRegistry {
    mapping(string name => Dictionary) dictionaries;
    Current current;
}
library DictionaryRegistryLib {
    using NameGenerator for mapping(string => Dictionary);

    /**-------------------------------------
        🚀 Deploy & Register Dictionary
    ---------------------------------------*/
    function deploy(DictionaryRegistry storage registry, string memory name, Bundle storage bundle, address owner) internal returns(Dictionary storage) {
        uint pid = registry.startProcess("deploy");
        Validate.MUST_NotEmptyName(name);
        Validate.SHOULD_Completed(bundle);
        Validate.MUST_AddressIsNotZero(owner);
        Dictionary memory dictionary = DictionaryLib.deploy(owner)
                                                    .set(bundle)
                                                    .upgradeFacade(bundle.facade);
        registry.register(name, dictionary);
        return registry.findCurrent().finishProcessInStorage(pid);
    }

    /**---------------------------
        🗳️ Register Dictionary
    -----------------------------*/
    function register(DictionaryRegistry storage registry, string memory name, Dictionary memory dictionary) internal returns(Dictionary storage) {
        uint pid = registry.startProcess("register");
        Validate.MUST_NotEmptyName(name);
        Validate.MUST_Completed(dictionary);
        Validate.MUST_NotRegistered(registry, name);
        Dictionary storage dictionaryStorage = registry.dictionaries[name] = dictionary;
        registry.current.update(name);
        return dictionaryStorage.finishProcessInStorage(pid);
    }

    /**------------------------
        🔍 Find Dictionary
    --------------------------*/
    function find(DictionaryRegistry storage registry, string memory name) internal returns(Dictionary storage) {
        uint pid = registry.startProcess("find");
        Validate.MUST_NotEmptyName(name);
        Validate.MUST_Registered(registry, name);
        Dictionary storage dictionary = registry.dictionaries[name];
        Validate.MUST_Completed(dictionary);
        return dictionary.finishProcessInStorage(pid);
    }
    function findCurrent(DictionaryRegistry storage registry) internal returns(Dictionary storage) {
        uint pid = registry.startProcess("findCurrent");
        string memory name = registry.current.name;
        Validate.MUST_NotEmptyName(name);
        return registry.find(name).finishProcessInStorage(pid);
    }

    /**-----------------------------
        🏷 Generate Unique Name
    -------------------------------*/
    function genUniqueName(DictionaryRegistry storage registry) internal returns(string memory name) {
        return registry.dictionaries.genUniqueName();
    }
    function genUniqueMockName(DictionaryRegistry storage registry) internal returns(string memory name) {
        return registry.dictionaries.genUniqueMockName();
    }

}

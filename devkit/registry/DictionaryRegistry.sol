// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {Tracer, param} from "devkit/system/Tracer.sol";
import {Inspector} from "devkit/types/Inspector.sol";
import {NameGenerator} from "devkit/utils/mapping/NameGenerator.sol";
// Validation
import {Validator} from "devkit/system/Validator.sol";

// Context
import {Current} from "devkit/registry/context/Current.sol";
// Core Type
import {Dictionary, DictionaryLib} from "devkit/core/Dictionary.sol";
import {Bundle} from "devkit/core/Bundle.sol";


//////////////////////////////////////////////////////////////////
//  📘 Dictionary Registry    ////////////////////////////////////
    using DictionaryRegistryLib for DictionaryRegistry global;
    using Tracer for DictionaryRegistry global;
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
    function deploy(DictionaryRegistry storage registry, Bundle storage bundle, address owner) internal returns(Dictionary storage dictionary) {
        uint pid = registry.startProcess("deploy", param(bundle, owner));
        Validator.MUST_Completed(bundle);
        Validator.SHOULD_OwnerIsNotZeroAddress(owner);
        Dictionary memory _dictionary = DictionaryLib
                                            .deploy(owner)
                                            .set(bundle)
                                            .upgradeFacade(bundle.facade);
        dictionary = registry.register(bundle.name, _dictionary);
        registry.finishProcess(pid);
    }

    /**---------------------------
        🗳️ Register Dictionary
    -----------------------------*/
    function register(DictionaryRegistry storage registry, string memory name, Dictionary memory _dictionary) internal returns(Dictionary storage dictionary) {
        uint pid = registry.startProcess("register", param(name, _dictionary));
        Validator.MUST_NotEmptyName(name);
        Validator.MUST_Completed(_dictionary);
        string memory uniqueName = registry.genUniqueName(name);
        dictionary = registry.dictionaries[uniqueName] = _dictionary;
        registry.current.update(uniqueName);
        registry.finishProcess(pid);
    }

    /**------------------------
        🔍 Find Dictionary
    --------------------------*/
    function find(DictionaryRegistry storage registry, string memory name) internal returns(Dictionary storage dictionary) {
        uint pid = registry.startProcess("find", param(name));
        Validator.MUST_NotEmptyName(name);
        Validator.MUST_Registered(registry, name);
        dictionary = registry.dictionaries[name];
        Validator.MUST_Completed(dictionary);
        registry.finishProcess(pid);
    }
    function findCurrent(DictionaryRegistry storage registry) internal returns(Dictionary storage dictionary) {
        uint pid = registry.startProcess("findCurrent");
        string memory name = registry.current.name;
        Validator.MUST_NotEmptyName(name);
        dictionary = registry.find(name);
        registry.finishProcess(pid);
    }

    /**-----------------------------
        🏷 Generate Unique Name
    -------------------------------*/
    function genUniqueName(DictionaryRegistry storage registry, string memory baseName) internal returns(string memory name) {
        uint pid = registry.startProcess("genUniqueName", param(baseName));
        name = registry.dictionaries.genUniqueName(baseName);
        registry.finishProcess(pid);
    }
    function genUniqueMockName(DictionaryRegistry storage registry) internal returns(string memory name) {
        uint pid = registry.startProcess("genUniqueMockName");
        name = registry.dictionaries.genUniqueMockName();
        registry.finishProcess(pid);
    }

}

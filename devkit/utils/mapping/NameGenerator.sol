// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Validate} from "devkit/system/Validate.sol";
import {ScanRange} from "devkit/system/Config.sol";
import {System} from "devkit/system/System.sol";
// Core Types
import {Bundle} from "devkit/core/Bundle.sol";
import {Function} from "devkit/core/Function.sol";
import {Dictionary} from "devkit/core/Dictionary.sol";
import {Proxy} from "devkit/core/Proxy.sol";
// Utils
import {Formatter} from "devkit/types/Formatter.sol";
    using Formatter for string;

/**=======================
    🏷️ Name Generator
=========================*/
library NameGenerator {

    /**------------------------
        🗂️ Bundle Mapping
    --------------------------*/
    function genUniqueName(mapping(string => Bundle) storage bundle, string memory baseName) internal returns(string memory name) {
        ScanRange memory range = System.Config().SCAN_RANGE;
        for (uint i = range.START; i <= range.END; ++i) {
            name = baseName.toSequential(i);
            if (bundle[name].hasNotName()) return name; // TODO
        }
        Validate.MUST_FoundInRange();
    }
    function genUniqueName(mapping(string => Bundle) storage bundle) internal returns(string memory name) {
        return genUniqueName(bundle, System.Config().DEFAULT_NAME.BUNDLE);
    }


    /**-------------------------
        🧩 Function Mapping
    ---------------------------*/
    function genUniqueName(mapping(string => Function) storage func, string memory baseName) internal returns(string memory name) {
        ScanRange memory range = System.Config().SCAN_RANGE;
        for (uint i = range.START; i <= range.END; ++i) {
            name = baseName.toSequential(i);
            if (func[name].isUninitialized()) return name;
        }
        Validate.MUST_FoundInRange();
    }
    function genUniqueName(mapping(string => Function) storage func) internal returns(string memory name) {
        return genUniqueName(func, System.Config().DEFAULT_NAME.FUNCTION);
    }


    /**---------------------------
        📚 Dictionary Mapping
    -----------------------------*/
    function genUniqueName(mapping(string => Dictionary) storage dictionary, string memory baseName) internal returns(string memory name) {
        ScanRange memory range = System.Config().SCAN_RANGE;
        for (uint i = range.START; i <= range.END; ++i) {
            name = baseName.toSequential(i);
            if (dictionary[name].isUninitialized()) return name;
        }
        Validate.MUST_FoundInRange();
    }
    /*----- Dictionary -----*/
    function genUniqueName(mapping(string => Dictionary) storage dictionary) internal returns(string memory name) {
        return genUniqueName(dictionary, System.Config().DEFAULT_NAME.DICTIONARY);
    }
    /*----- Dictionary -----*/
    function genUniqueDuplicatedName(mapping(string => Dictionary) storage dictionary) internal returns(string memory name) {
        return genUniqueName(dictionary, System.Config().DEFAULT_NAME.DICTIONARY_DUPLICATED);
    }
    /*----- Mock Dictionary -----*/
    function genUniqueMockName(mapping(string => Dictionary) storage dictionary) internal returns(string memory name) {
        return genUniqueName(dictionary, System.Config().DEFAULT_NAME.DICTIONARY_MOCK);
    }
    // function genUniqueName(DictionaryRegistry storage dictionaries, string memory baseName) internal returns(string memory name) {
    //     uint pid = dictionaries.startProcess("genUniqueName");
    //     ScanRange memory range = System.Config().SCAN_RANGE;
    //     for (uint i = range.START; i <= range.END; ++i) {
    //         name = baseName.toSequential(i);
    //         if (dictionaries.existsInDeployed(name).isFalse()) return name.recordExecFinish(pid);
    //     }
    //     throwError(ERR.FIND_OVER_RANGE);
    // }
    // function genUniqueName(DictionaryRegistry storage dictionaries) internal returns(string memory name) {
    //     return dictionaries.genUniqueName(System.Config().DEFAULT_DICTIONARY);
    // }
    // function genUniqueDuplicatedName(DictionaryRegistry storage dictionaries) internal returns(string memory name) {
    //     return dictionaries.genUniqueName(System.Config().DEFAULT_DICTIONARY_DUPLICATED);
    // }


    /**-----------------------
        🏠 Proxy Mapping
    -------------------------*/
    /*----- Mock Proxy -----*/
    function genUniqueName(mapping(string => Proxy) storage proxy, string memory baseName) internal returns(string memory name) {
        ScanRange memory range = System.Config().SCAN_RANGE;
        for (uint i = range.START; i <= range.END; ++i) {
            name = baseName.toSequential(i);
            if (proxy[name].isUninitialized()) return name;
        }
        Validate.MUST_FoundInRange();
    }
    /*----- Proxy -----*/
    function genUniqueName(mapping(string => Proxy) storage proxy) internal returns(string memory name) {
        return genUniqueName(proxy, System.Config().DEFAULT_NAME.PROXY);
    }
    /*----- Mock Proxy -----*/
    function genUniqueMockName(mapping(string => Proxy) storage proxy) internal returns(string memory name) {
        return genUniqueName(proxy, System.Config().DEFAULT_NAME.PROXY_MOCK);
    }

}



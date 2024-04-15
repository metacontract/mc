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
        return genUniqueName(bundle, System.Config().DEFAULT_BUNDLE_NAME);
    }


    /**-------------------------
        🧩 Function Mapping
    ---------------------------*/
    function genUniqueName(mapping(string => Function) storage func, string memory baseName) internal returns(string memory name) {
        ScanRange memory range = System.Config().SCAN_RANGE;
        for (uint i = range.START; i <= range.END; ++i) {
            name = baseName.toSequential(i);
            if (func[name].notExists()) return name;
        }
        Validate.MUST_FoundInRange();
    }
    function genUniqueName(mapping(string => Function) storage func) internal returns(string memory name) {
        return genUniqueName(func, System.Config().DEFAULT_FUNCTION_NAME);
    }


    /**---------------------------
        📚 Dictionary Mapping
    -----------------------------*/
    function genUniqueName(mapping(string => Dictionary) storage dictionary, string memory baseName) internal returns(string memory name) {
        ScanRange memory range = System.Config().SCAN_RANGE;
        for (uint i = range.START; i <= range.END; ++i) {
            name = baseName.toSequential(i);
            if (dictionary[name].notExists()) return name;
        }
        Validate.MUST_FoundInRange();
    }
    /*----- Dictionary -----*/
    function genUniqueName(mapping(string => Dictionary) storage dictionary) internal returns(string memory name) {
        return genUniqueName(dictionary, System.Config().DEFAULT_DICTIONARY_NAME);
    }
    /*----- Dictionary -----*/
    function genUniqueDuplicatedName(mapping(string => Dictionary) storage dictionary) internal returns(string memory name) {
        return genUniqueName(dictionary, System.Config().DEFAULT_DICTIONARY_DUPLICATED_NAME);
    }
    /*----- Mock Dictionary -----*/
    function genUniqueMockName(mapping(string => Dictionary) storage dictionary) internal returns(string memory name) {
        return genUniqueName(dictionary, System.Config().DEFAULT_DICTIONARY_MOCK_NAME);
    }
    // function genUniqueName(DictionaryRegistry storage dictionaries, string memory baseName) internal returns(string memory name) {
    //     uint pid = dictionaries.startProcess("genUniqueName");
    //     ScanRange memory range = System.Config().SCAN_RANGE;
    //     for (uint i = range.START; i <= range.END; ++i) {
    //         name = baseName.toSequential(i);
    //         if (dictionaries.existsInDeployed(name).isFalse()) return name.recordExecFinish(pid);
    //     }
    //     throwError(ERR.FIND_NAME_OVER_RANGE);
    // }
    // function genUniqueName(DictionaryRegistry storage dictionaries) internal returns(string memory name) {
    //     return dictionaries.genUniqueName(System.Config().DEFAULT_DICTIONARY_NAME);
    // }
    // function genUniqueDuplicatedName(DictionaryRegistry storage dictionaries) internal returns(string memory name) {
    //     return dictionaries.genUniqueName(System.Config().DEFAULT_DICTIONARY_DUPLICATED_NAME);
    // }


    /**-----------------------
        🏠 Proxy Mapping
    -------------------------*/
    /*----- Mock Proxy -----*/
    function genUniqueName(mapping(string => Proxy) storage proxy, string memory baseName) internal returns(string memory name) {
        ScanRange memory range = System.Config().SCAN_RANGE;
        for (uint i = range.START; i <= range.END; ++i) {
            name = baseName.toSequential(i);
            if (proxy[name].notExists()) return name;
        }
        Validate.MUST_FoundInRange();
    }
    /*----- Proxy -----*/
    function genUniqueName(mapping(string => Proxy) storage proxy) internal returns(string memory name) {
        return genUniqueName(proxy, System.Config().DEFAULT_PROXY_NAME);
    }
    /*----- Mock Proxy -----*/
    function genUniqueMockName(mapping(string => Proxy) storage proxy) internal returns(string memory name) {
        return genUniqueName(proxy, System.Config().DEFAULT_PROXY_MOCK_NAME);
    }

}



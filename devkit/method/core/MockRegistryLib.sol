// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Error & Debug
import {ERR, throwError} from "devkit/error/Error.sol";
import {valid, Valid} from "devkit/error/Valid.sol";
import {Debug} from "devkit/debug/Debug.sol";
// Config
import {Config, ScanRange} from "devkit/config/Config.sol";
// Utils
import {AddressUtils} from "devkit/utils/AddressUtils.sol";
    using AddressUtils for address;
import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;
import {BoolUtils} from "devkit/utils/BoolUtils.sol";
    using BoolUtils for bool;
// Core
import {Proxy} from "devkit/core/Proxy.sol";
import {Dictionary} from "devkit/core/Dictionary.sol";

import {MockRegistry} from "devkit/core/MockRegistry.sol";
import {MappingAnalyzer} from "devkit/method/inspector/MappingAnalyzer.sol";
    using MappingAnalyzer for mapping(string => Dictionary);
    using MappingAnalyzer for mapping(string => Proxy);


/**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    🏭 Mock Registry
        📥 Add
            Mock Dictionary
            Mock Proxy
        🔍 Find
            Mock Dictionary
            Mock Proxy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
library MockRegistryLib {

    /**-------------
        📥 Add
    ---------------*/
    /*----- Mock Dictionary -----*/
    function add(MockRegistry storage mock, string memory name, Dictionary memory dictionary) internal returns(MockRegistry storage) {
        uint pid = mock.startProcess("add");
        Valid.isNotEmpty(name);
        valid(dictionary.isNotEmpty(), "Empty Dictionary");
        mock.dictionary[name] = dictionary;
        return mock.finishProcess(pid);
    }
    function add(MockRegistry storage mock, Dictionary memory dictionary) internal returns(MockRegistry storage) {
        return add(mock, mock.dictionary.genUniqueMockName(), dictionary);
    }

    /*----- Mock Proxy -----*/
    function add(MockRegistry storage mock, string memory name, Proxy memory proxy) internal returns(MockRegistry storage) {
        uint pid = mock.startProcess("add");
        Valid.isNotEmpty(name);
        valid(proxy.isNotEmpty(), "Empty Proxy");
        mock.proxy[name] = proxy;
        return mock.finishProcess(pid);
    }
    function add(MockRegistry storage mock, Proxy memory proxy) internal returns(MockRegistry storage) {
        return add(mock, mock.proxy.genUniqueMockName(), proxy);
    }


    /**--------------
        🔍 Find
    ----------------*/
    /*----- Mock Dictionary -----*/
    function findMockDictionary(MockRegistry storage mock, string memory name) internal returns(Dictionary storage) {
        uint pid = mock.startProcess("findMockDictionary");
        Valid.isNotEmpty(name);
        return mock.dictionary[name].assertExists().finishProcessInStorage(pid);
    }

    /*----- Mock Proxy -----*/
    function findMockProxy(MockRegistry storage mock, string memory name) internal returns(Proxy storage) {
        uint pid = mock.startProcess("findMockProxy");
        Valid.isNotEmpty(name);
        return mock.proxy[name].assertExists().finishProcessInStorage(pid);
    }

}

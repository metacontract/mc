// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Error & Debug
import {ERR, throwError} from "devkit/error/Error.sol";
import {check} from "devkit/error/Validation.sol";
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


/**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    📘 Dictionary Registry
        📥 Add Dictionary
        🔼 Update Current Context Dictionary
        ♻️ Reset Current Context Dictionary
        🔍 Find Dictionary
        🏷 Generate Unique Name
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
library MockRegistryLib {
    /**------------------------
        📥 Add Dictionary
    --------------------------*/
    function add(MockRegistry storage mock, string memory name, Dictionary memory dictionary) internal returns(MockRegistry storage) {
        uint pid = mock.startProcess("add");
        bytes32 nameHash = name.calcHash();
        mock.dictionary[nameHash] = dictionary;
        return mock.finishProcess(pid);
    }

    function safeAdd(MockRegistry storage mock, string memory name, Dictionary memory dictionary) internal returns(MockRegistry storage) {
        uint pid = mock.startProcess("safeAdd");
        return mock .add(name.assertNotEmpty(), dictionary.assertNotEmpty())
                            .finishProcess(pid);
    }


    /**------------------------
        🔍 Find Dictionary
    --------------------------*/
    function find(MockRegistry storage mock, string memory name) internal returns(Dictionary storage) {
        uint pid = mock.startProcess("find");
        return mock.dictionary[name.safeCalcHash()]
                            .assertExists()
                            .finishProcessInStorage(pid);
    }
    function findMockDictionary(MockRegistry storage mock, string memory name) internal returns(Dictionary storage) {
        uint pid = mock.startProcess("findMockDictionary");
        return mock.dictionary[name.safeCalcHash()].assertExists().finishProcessInStorage(pid);
    }
    function findSimpleMockProxy(MockRegistry storage mock, string memory name) internal returns(Proxy storage) {
        uint pid = mock.startProcess("findSimpleMockProxy");
        return mock.proxy[name.safeCalcHash()].assertExists().finishProcessInStorage(pid);
    }


    /**-----------------------------
        🏷 Generate Unique Name
    -------------------------------*/
    // function genUniqueName(MockRegistry storage mock, string memory baseName) internal returns(string memory name) {
    //     uint pid = mock.startProcess("genUniqueName");
    //     ScanRange memory range = Config().SCAN_RANGE;
    //     for (uint i = range.START; i <= range.END; ++i) {
    //         name = baseName.toSequential(i);
    //         if (mock.existsInDeployed(name).isFalse()) return name.recordExecFinish(pid);
    //     }
    //     throwError(ERR.FIND_NAME_OVER_RANGE);
    // }
    // function genUniqueName(MockRegistry storage mock) internal returns(string memory name) {
    //     return mock.genUniqueName(Config().DEFAULT_DICTIONARY_NAME);
    // }
    // function genUniqueDuplicatedName(MockRegistry storage mock) internal returns(string memory name) {
    //     return mock.genUniqueName(Config().DEFAULT_DICTIONARY_DUPLICATED_NAME);
    // }

    // function genUniqueMockName(MockRegistry storage mock) internal returns(string memory name) {
    //     uint pid = mock.startProcess("genUniqueName");
    //     ScanRange memory range = Config().SCAN_RANGE;
    //     for (uint i = range.START; i <= range.END; ++i) {
    //         name = Config().DEFAULT_DICTIONARY_MOCK_NAME.toSequential(i);
    //         if (mock.existsInMocks(name).isFalse()) return name.recordExecFinish(pid);
    //     }
    //     throwError(ERR.FIND_NAME_OVER_RANGE);
    // }

    // function genUniqueMockName(MockRegistry storage mock) internal returns(string memory name) {
    //     uint pid = mock.startProcess("genUniqueMockName");
    //     ScanRange memory range = Config().SCAN_RANGE;
    //     for (uint i = range.START; i <= range.END; ++i) {
    //         name = Config().DEFAULT_PROXY_MOCK_NAME.toSequential(i);
    //         if (mock.existsInMocks(name).isFalse()) return name.recordExecFinish(pid);
    //     }
    //     throwError(ERR.FIND_NAME_OVER_RANGE);
    // }

}

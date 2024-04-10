// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core Types
import {Proxy} from "devkit/core/types/Proxy.sol";
import {Dictionary} from "devkit/core/types/Dictionary.sol";
// Support Methods
import {ProcessLib} from "devkit/core/method/debug/ProcessLib.sol";
    using ProcessLib for MockRegistry global;
import {Inspector} from "devkit/core/method/inspector/Inspector.sol";
    using Inspector for MockRegistry global;
import {Require} from "devkit/error/Require.sol";
import {MappingAnalyzer} from "devkit/core/method/inspector/MappingAnalyzer.sol";
    using MappingAnalyzer for mapping(string => Dictionary);
    using MappingAnalyzer for mapping(string => Proxy);


/**======================
    🏭 Mock Registry
========================*/
using MockRegistryLib for MockRegistry global;
struct MockRegistry {
    mapping(string name => Proxy) proxy;
    mapping(string name => Dictionary) dictionary;
}
library MockRegistryLib {
    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        📥 Add
            Mock Dictionary
            Mock Proxy
        🔍 Find
            Mock Dictionary
            Mock Proxy
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

    /**-------------
        📥 Add
    ---------------*/
    /*----- Mock Dictionary -----*/
    function add(MockRegistry storage mock, string memory name, Dictionary memory dictionary) internal returns(MockRegistry storage) {
        uint pid = mock.startProcess("add");
        Require.notEmpty(name);
        Require.notEmpty(dictionary);
        mock.dictionary[name] = dictionary;
        return mock.finishProcess(pid);
    }
    function add(MockRegistry storage mock, Dictionary memory dictionary) internal returns(MockRegistry storage) {
        return add(mock, mock.dictionary.genUniqueMockName(), dictionary);
    }

    /*----- Mock Proxy -----*/
    function add(MockRegistry storage mock, string memory name, Proxy memory proxy) internal returns(MockRegistry storage) {
        uint pid = mock.startProcess("add");
        Require.notEmpty(name);
        Require.notEmpty(proxy);
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
        Require.notEmpty(name);
        Require.exists(mock.dictionary[name]);
        return mock.dictionary[name].finishProcessInStorage(pid);
    }

    /*----- Mock Proxy -----*/
    function findMockProxy(MockRegistry storage mock, string memory name) internal returns(Proxy storage) {
        uint pid = mock.startProcess("findMockProxy");
        Require.notEmpty(name);
        Require.exists(mock.proxy[name]);
        return mock.proxy[name].finishProcessInStorage(pid);
    }

}

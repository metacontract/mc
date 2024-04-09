// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {throwError, ERR} from "devkit/error/Error.sol";
import {Config, ScanRange} from "devkit/config/Config.sol";
// Core Types
import {Dictionary} from "devkit/core/Dictionary.sol";
import {Proxy} from "devkit/core/Proxy.sol";
// Utils
import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;

//================
//  🗒️ Parser
library Naming {

    /**---------------------------
        📚 Dictionary Mapping
    -----------------------------*/
    function genUniqueName(mapping(string => Dictionary) storage dictionary, string memory baseName) internal returns(string memory name) {
        ScanRange memory range = Config().SCAN_RANGE;
        for (uint i = range.START; i <= range.END; ++i) {
            name = baseName.toSequential(i);
            if (dictionary[name].notExists()) return name;
        }
        throwError(ERR.FIND_NAME_OVER_RANGE);
    }
    /*----- Dictionary -----*/
    function genUniqueName(mapping(string => Dictionary) storage dictionary) internal returns(string memory name) {
        return genUniqueName(dictionary, Config().DEFAULT_DICTIONARY_NAME);
    }
    /*----- Mock Dictionary -----*/
    function genUniqueMockName(mapping(string => Dictionary) storage dictionary) internal returns(string memory name) {
        return genUniqueName(dictionary, Config().DEFAULT_DICTIONARY_MOCK_NAME);
    }


    /**-----------------------
        🏠 Proxy Mapping
    -------------------------*/
    /*----- Mock Proxy -----*/
    function genUniqueName(mapping(string => Proxy) storage proxy, string memory baseName) internal returns(string memory name) {
        ScanRange memory range = Config().SCAN_RANGE;
        for (uint i = range.START; i <= range.END; ++i) {
            name = baseName.toSequential(i);
            if (proxy[name].notExists()) return name;
        }
        throwError(ERR.FIND_NAME_OVER_RANGE);
    }
    /*----- Proxy -----*/
    function genUniqueName(mapping(string => Proxy) storage proxy) internal returns(string memory name) {
        return genUniqueName(proxy, Config().DEFAULT_PROXY_NAME);
    }
    /*----- Mock Proxy -----*/
    function genUniqueMockName(mapping(string => Proxy) storage proxy) internal returns(string memory name) {
        return genUniqueName(proxy, Config().DEFAULT_PROXY_MOCK_NAME);
    }

}



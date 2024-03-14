// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Global Methods
import "@devkit/utils/GlobalMethods.sol";
// Config
import {Config} from "@devkit/Config.sol";
// Utils
import {StringUtils} from "@devkit/utils/StringUtils.sol";
    using StringUtils for string;
import {BoolUtils} from "@devkit/utils/BoolUtils.sol";
    using BoolUtils for bool;
// Errors
import {Errors} from "@devkit/errors/Errors.sol";
// Core
import {Proxy} from "@devkit/core/proxy/Proxy.sol";
import {Dictionary} from "@devkit/core/dictionary/Dictionary.sol";

/********************
    🏠 UCS Proxy
*********************/
using ProxyRegistryUtils for ProxyRegistry global;
struct ProxyRegistry {
    mapping(bytes32 nameHash => Proxy) deployed;
    mapping(bytes32 nameHash => Proxy) mocks;
    Proxy currentProxy;
}

library ProxyRegistryUtils {
    string constant LIB_NAME = "ProxyRegistry";

    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    << Primary >>
        📥 Add Proxy
        🔼 Update Current Context Proxy
        🔍 Find Proxy
        🏷 Generate Unique Name
    << Helper >>
        🧐 Inspectors & Assertions
        🐞 Debug
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/


    /**-------------------
        📥 Add Proxy
    ---------------------*/
    function add(ProxyRegistry storage proxies, string memory name, Proxy memory proxy) internal returns(ProxyRegistry storage) {
        uint pid = proxies.recordExecStart("add");
        bytes32 nameHash = name.calcHash();
        if (proxy.isNotMock()) {
            proxies.deployed[nameHash] = proxy;
        }
        if (proxy.isMock()) {
            proxies.mocks[nameHash] = proxy;
        }
        return proxies.recordExecFinish(pid);
    }

    function safeAdd(ProxyRegistry storage proxies, string memory name, Proxy memory proxy) internal returns(ProxyRegistry storage) {
        uint pid = proxies.recordExecStart("safeAdd");
        return proxies  .add(name.assertNotEmpty(), proxy.assertNotEmpty())
                        .recordExecFinish(pid);
    }


    /**------------------------------------
        🔼 Update Current Context Proxy
    --------------------------------------*/
    function safeUpdate(ProxyRegistry storage proxies, Proxy memory proxy) internal returns(ProxyRegistry storage) {
        uint pid = proxies.recordExecStart("safeUpdate");
        return proxies.update(proxy.assertNotEmpty()).recordExecFinish(pid);
    }
    function update(ProxyRegistry storage proxies, Proxy memory proxy) internal returns(ProxyRegistry storage) {
        uint pid = proxies.recordExecStart("update");
        proxies.currentProxy = proxy;
        return proxies.recordExecFinish(pid);
    }


    /**-------------------
        🔍 Find Proxy
    ---------------------*/
    function find(ProxyRegistry storage proxies, string memory name) internal returns(Proxy storage) {
        uint pid = proxies.recordExecStart("find");
        return proxies.deployed[name.safeCalcHash()]
                        .assertExists().recordExecFinishInStorage(pid);
    }
    function findCurrentProxy(ProxyRegistry storage proxies) internal returns(Proxy storage) {
        uint pid = proxies.recordExecStart("findCurrentProxy");
        return proxies.currentProxy.assertExists().recordExecFinishInStorage(pid);
    }
    function findSimpleMockProxy(ProxyRegistry storage proxies, string memory name) internal returns(Proxy storage) {
        uint pid = proxies.recordExecStart("findSimpleMockProxy");
        return proxies.mocks[name.safeCalcHash()].assertExists().recordExecFinishInStorage(pid);
    }


    /**-----------------------------
        🏷 Generate Unique Name
    -------------------------------*/
    function genUniqueName(ProxyRegistry storage proxies) internal returns(string memory name) {
        uint pid = proxies.recordExecStart("genUniqueName");
        Config.ScanRange memory range = Config.SCAN_RANGE();
        for (uint i = range.start; i <= range.end; ++i) {
            name = Config.DEFAULT_PROXY_NAME.toSequential(i);
            if (proxies.existsInDeployed(name).isFalse()) return name.recordExecFinish(pid);
        }
        throwError(Errors.FIND_NAME_OVER_RANGE);
    }

    function genUniqueMockName(ProxyRegistry storage proxies) internal returns(string memory name) {
        uint pid = proxies.recordExecStart("genUniqueMockName");
        Config.ScanRange memory range = Config.SCAN_RANGE();
        for (uint i = range.start; i <= range.end; ++i) {
            name = Config.DEFAULT_PROXY_MOCK_NAME.toSequential(i);
            if (proxies.existsInMocks(name).isFalse()) return name.recordExecFinish(pid);
        }
        throwError(Errors.FIND_NAME_OVER_RANGE);
    }



    /**-------------------------------
        🧐 Inspectors & Assertions
    ---------------------------------*/
    function existsInDeployed(ProxyRegistry storage proxies, string memory name) internal returns(bool) {
        return proxies.deployed[name.safeCalcHash()].exists();
    }
    function existsInMocks(ProxyRegistry storage proxies, string memory name) internal returns(bool) {
        return proxies.mocks[name.safeCalcHash()].exists();
    }


    /**----------------
        🐞 Debug
    ------------------*/
    /**
        Record Start
     */
    function recordExecStart(ProxyRegistry storage, string memory funcName, string memory params) internal returns(uint) {
        return Debug.recordExecStart(LIB_NAME, funcName, params);
    }
    function recordExecStart(ProxyRegistry storage proxies, string memory funcName) internal returns(uint) {
        return proxies.recordExecStart(funcName, "");
    }

    /**
        Record Finish
     */
    function recordExecFinish(ProxyRegistry storage proxies, uint pid) internal returns(ProxyRegistry storage) {
        Debug.recordExecFinish(pid);
        return proxies;
    }

}

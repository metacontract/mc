// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Global Methods
import "@devkit/utils/GlobalMethods.sol";
// Config
import {Config} from "@devkit/Config.sol";
// Utils
import {ForgeHelper} from "@devkit/utils/ForgeHelper.sol";
import {StringUtils} from "@devkit/utils/StringUtils.sol";
    using StringUtils for string;
// Errors
import {ERR_FIND_NAME_OVER_RANGE} from "@devkit/errors/Errors.sol";
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
    function __debug(string memory location) internal {
        Debug.start(location.append(" @ Proxy Registry Utils"));
    }

    /**~~~~~~~~~~~~~~~~~~~~~~~
        📥 Safe Add Proxy
        🔍 Find Proxy
        🔧 Helper Methods
    ~~~~~~~~~~~~~~~~~~~~~~~~~*/

    /**----------------------
        📥 Safe Add Proxy
    ------------------------*/
    function safeAdd(ProxyRegistry storage proxies, string memory name, Proxy memory proxy) internal returns(ProxyRegistry storage) {
        __debug("Safe Add Proxy to DevKitEnv");
        return proxies.add(name.assertNotEmpty(), proxy.assertNotEmpty());
    }
    function add(ProxyRegistry storage proxies, string memory name, Proxy memory proxy) internal returns(ProxyRegistry storage) {
        bytes32 nameHash = name.calcHash();
        if (proxy.isNotMock()) {
            proxies.deployed[nameHash] = proxy;
        }
        if (proxy.isMock()) {
            proxies.mocks[nameHash] = proxy;
        }
        return proxies;
    }

    /**-------------------
        🔍 Find Proxy
    ---------------------*/
    function find(ProxyRegistry storage proxies, string memory name) internal returns(Proxy storage) {
        __debug("Find Proxy in DevKitEnv");
        return proxies.deployed[name.safeCalcHash()]
                        .assertExists();
    }
    function findCurrentProxy(ProxyRegistry storage proxies) internal returns(Proxy storage) {
        __debug("Find Current Proxy");
        return proxies.currentProxy.assertExists();
    }
    function findSimpleMockProxy(ProxyRegistry storage proxies, string memory name) internal returns(Proxy storage) {
        __debug("Find Mock in DevKitEnv");
        return proxies.mocks[name.safeCalcHash()].assertExists();
    }


    /**-----------------------
        🔧 Helper Methods
    -------------------------*/
    function exists(ProxyRegistry storage proxies, string memory name) internal returns(bool) {
        return proxies.deployed[name.safeCalcHash()].exists();
    }

    function findUnusedProxyName(ProxyRegistry storage proxies) internal returns(string memory name) {
        (uint start, uint end) = Config.SCAN_RANGE();
        string memory baseName = "Proxy";

        for (uint i = start; i <= end; ++i) {
            name = ForgeHelper.appendNumberToNameIfNotOne(baseName, i);
            if (!proxies.exists(name)) return name;
        }

        throwError(ERR_FIND_NAME_OVER_RANGE);
    }

    /**----------------------
        🔼 Update Context
    ------------------------*/
    /**----- 🏠 Proxy -------*/
    function safeUpdate(ProxyRegistry storage proxies, Proxy memory proxy) internal returns(ProxyRegistry storage) {
        __debug("Safe Update DevKit Context");
        return proxies.update(proxy.assertNotEmpty());
    }
    function update(ProxyRegistry storage proxies, Proxy memory proxy) internal returns(ProxyRegistry storage) {
        proxies.currentProxy = proxy;
        return proxies;
    }

    /**-----------------------
        🔧 Helper Methods
    -------------------------*/
    function findUnusedName(
        ProxyRegistry storage proxies,
        function(ProxyRegistry storage, string memory) returns(bool) existsFunc,
        string memory baseName
    ) internal returns(string memory name) {
        (uint start, uint end) = Config.SCAN_RANGE();

        for (uint i = start; i <= end; ++i) {
            name = ForgeHelper.appendNumberToNameIfNotOne(baseName, i);
            if (!existsFunc(proxies, name)) return name;
        }

        throwError(ERR_FIND_NAME_OVER_RANGE);
    }

    function findUnusedMockProxyName(ProxyRegistry storage proxies) internal returns(string memory) {
        return proxies.findUnusedName(existsMockProxy, "MockProxy");
    }

    string constant exixtsMockProxy_ = "Exists";
    function existsMockProxy(ProxyRegistry storage proxies, string memory name) internal returns(bool) {
        return proxies.mocks[name.safeCalcHash()].exists();
    }

}

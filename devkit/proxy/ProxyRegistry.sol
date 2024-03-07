// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {DevUtils} from "DevKit/common/DevUtils.sol";
import {ForgeHelper} from "DevKit/common/ForgeHelper.sol";

import {Proxy} from "./Proxy.sol";
import {Dictionary} from "../dictionary/Dictionary.sol";

import {FuncInfo} from "../functions/FuncInfo.sol";
import {SimpleMockProxy} from "./mocks/SimpleMockProxy.sol";

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
    using DevUtils for string;
    /**~~~~~~~~~~~~~~~~~~~~~~~
        📥 Safe Add Proxy
        🔍 Find Proxy
        🔧 Helper Methods
    ~~~~~~~~~~~~~~~~~~~~~~~~~*/

    /**----------------------
        📥 Safe Add Proxy
    ------------------------*/
    string constant safeAdd_ = "Safe Add Proxy to DevKitEnv";
    function safeAdd(ProxyRegistry storage proxies, string memory name, Proxy memory proxy) internal returns(ProxyRegistry storage) {
        return proxies.add(name.assertNotEmptyAt(safeAdd_), proxy.assertNotEmptyAt(safeAdd_));
    }
    function add(ProxyRegistry storage proxies, string memory name, Proxy memory proxy) internal returns(ProxyRegistry storage) {
        proxies.deployed[name.calcHash()] = proxy;
        return proxies;
    }

    /**-------------------
        🔍 Find Proxy
    ---------------------*/
    string constant find_ = "Find Proxy in DevKitEnv";
    function find(ProxyRegistry storage proxies, string memory name) internal returns(Proxy storage) {
        return proxies.deployed[name.safeCalcHashAt(find_)]
                        .assertExistsAt(find_);
    }
    string constant findCurrentProxy_ = "Find in DevKit Context";
    function findCurrentProxy(ProxyRegistry storage proxies) internal returns(Proxy storage) {
        return proxies.currentProxy.assertExistsAt(findCurrentProxy_);
    }
    string constant findSimpleMockProxy_ = "Find Mock in DevKitEnv";
    function findSimpleMockProxy(ProxyRegistry storage proxies, string memory name) internal returns(Proxy storage) {
        return proxies.mocks[name.safeCalcHashAt(findSimpleMockProxy_)].assertExistsAt(findSimpleMockProxy_);
    }


    /**-----------------------
        🔧 Helper Methods
    -------------------------*/
    function exists(ProxyRegistry storage proxies, string memory name) internal returns(bool) {
        return proxies.deployed[name.safeCalcHashAt("")].exists();
    }

    function findUnusedProxyName(ProxyRegistry storage proxies) internal returns(string memory name) {
        (uint start, uint end) = DevUtils.getScanRange();
        string memory baseName = "Proxy";

        for (uint i = start; i <= end; ++i) {
            name = ForgeHelper.appendNumberToNameIfNotOne(baseName, i);
            if (!proxies.exists(name)) return name;
        }

        DevUtils.revertUnusedNameNotFound();
    }

    /**----------------------
        🔼 Update Context
    ------------------------*/
    string constant safeUpdate_ = "Safe Update DevKit Context";
    /**----- 🏠 Proxy -------*/
    function safeUpdate(ProxyRegistry storage proxies, Proxy memory proxy) internal returns(ProxyRegistry storage) {
        return proxies.update(proxy.assertNotEmptyAt(safeUpdate_));
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
        (uint start, uint end) = DevUtils.getScanRange();

        for (uint i = start; i <= end; ++i) {
            name = ForgeHelper.appendNumberToNameIfNotOne(baseName, i);
            if (!existsFunc(proxies, name)) return name;
        }

        DevUtils.revertUnusedNameNotFound();
    }

    function findUnusedMockProxyName(ProxyRegistry storage proxies) internal returns(string memory) {
        return proxies.findUnusedName(existsMockProxy, "MockProxy");
    }

    string constant exixtsMockProxy_ = "Exists";
    function existsMockProxy(ProxyRegistry storage proxies, string memory name) internal returns(bool) {
        return proxies.mocks[name.safeCalcHashAt(exixtsMockProxy_)].exists();
    }

}

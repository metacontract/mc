// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Core Type
import {Proxy} from "devkit/core/types/Proxy.sol";
// Support Methods
import {ProcessLib} from "devkit/core/method/debug/ProcessLib.sol";
    using ProcessLib for ProxyRegistry global;
import {Inspector} from "devkit/core/method/inspector/Inspector.sol";
    using Inspector for ProxyRegistry global;
import {Require} from "devkit/error/Require.sol";


/**=======================
    📕 Proxy Registry
=========================*/
using ProxyRegistryLib for ProxyRegistry global;
struct ProxyRegistry {
    mapping(string name => Proxy) deployed;
    Proxy currentProxy;
}
library ProxyRegistryLib {
    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        📥 Add Proxy
        🔼 Update Current Context Proxy
        ♻️ Reset Current Context Proxy
        🔍 Find Proxy
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
    /**-------------------
        📥 Add Proxy
    ---------------------*/
    function add(ProxyRegistry storage proxies, string memory name, Proxy memory proxy) internal returns(ProxyRegistry storage) {
        uint pid = proxies.startProcess("add");
        proxies.deployed[name] = proxy;
        return proxies.finishProcess(pid);
    }

    function safeAdd(ProxyRegistry storage proxies, string memory name, Proxy memory proxy) internal returns(ProxyRegistry storage) {
        uint pid = proxies.startProcess("safeAdd");
        Require.notEmpty(name);
        Require.notEmpty(proxy);
        return proxies  .add(name, proxy)
                        .finishProcess(pid);
    }


    /**------------------------------------
        🔼 Update Current Context Proxy
    --------------------------------------*/
    function safeUpdate(ProxyRegistry storage proxies, Proxy memory proxy) internal returns(ProxyRegistry storage) {
        uint pid = proxies.startProcess("safeUpdate");
        Require.notEmpty(proxy);
        return proxies.update(proxy).finishProcess(pid);
    }
    function update(ProxyRegistry storage proxies, Proxy memory proxy) internal returns(ProxyRegistry storage) {
        uint pid = proxies.startProcess("update");
        proxies.currentProxy = proxy;
        return proxies.finishProcess(pid);
    }


    /**----------------------------------
        ♻️ Reset Current Context Proxy
    ------------------------------------*/
    function reset(ProxyRegistry storage proxies) internal returns(ProxyRegistry storage) {
        uint pid = proxies.startProcess("reset");
        delete proxies.currentProxy;
        return proxies.finishProcess(pid);
    }


    /**-------------------
        🔍 Find Proxy
    ---------------------*/
    function find(ProxyRegistry storage proxies, string memory name) internal returns(Proxy storage) {
        uint pid = proxies.startProcess("find");
        Require.exists(proxies.deployed[name]);
        return proxies.deployed[name].finishProcessInStorage(pid);
    }
    function findCurrentProxy(ProxyRegistry storage proxies) internal returns(Proxy storage) {
        uint pid = proxies.startProcess("findCurrentProxy");
        Require.exists(proxies.currentProxy);
        return proxies.currentProxy.finishProcessInStorage(pid);
    }

}

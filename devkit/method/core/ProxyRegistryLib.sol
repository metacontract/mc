// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Error & Debug
import {ERR, throwError} from "devkit/error/Error.sol";
import {validate} from "devkit/error/Validate.sol";
import {Require} from "devkit/error/Require.sol";
import {Debug} from "devkit/debug/Debug.sol";
// Config
import {Config, ScanRange} from "devkit/config/Config.sol";
// Utils
import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;
import {BoolUtils} from "devkit/utils/BoolUtils.sol";
    using BoolUtils for bool;
// Core
import {Proxy} from "devkit/core/Proxy.sol";
import {Dictionary} from "devkit/core/Dictionary.sol";

import {ProxyRegistry} from "devkit/core/ProxyRegistry.sol";


/**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    🏠 Proxy Registry
        📥 Add Proxy
        🔼 Update Current Context Proxy
        ♻️ Reset Current Context Proxy
        🔍 Find Proxy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
library ProxyRegistryLib {
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

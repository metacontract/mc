// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Error & Debug
import {ERR, throwError} from "devkit/error/Error.sol";
import {check} from "devkit/error/Validation.sol";
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
        🏷 Generate Unique Name
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
library ProxyRegistryLib {
    /**-------------------
        📥 Add Proxy
    ---------------------*/
    function add(ProxyRegistry storage proxies, string memory name, Proxy memory proxy) internal returns(ProxyRegistry storage) {
        uint pid = proxies.startProcess("add");
        bytes32 nameHash = name.calcHash();
        proxies.deployed[nameHash] = proxy;
        return proxies.finishProcess(pid);
    }

    function safeAdd(ProxyRegistry storage proxies, string memory name, Proxy memory proxy) internal returns(ProxyRegistry storage) {
        uint pid = proxies.startProcess("safeAdd");
        return proxies  .add(name.assertNotEmpty(), proxy.assertNotEmpty())
                        .finishProcess(pid);
    }


    /**------------------------------------
        🔼 Update Current Context Proxy
    --------------------------------------*/
    function safeUpdate(ProxyRegistry storage proxies, Proxy memory proxy) internal returns(ProxyRegistry storage) {
        uint pid = proxies.startProcess("safeUpdate");
        return proxies.update(proxy.assertNotEmpty()).finishProcess(pid);
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
        return proxies.deployed[name.safeCalcHash()]
                        .assertExists().finishProcessInStorage(pid);
    }
    function findCurrentProxy(ProxyRegistry storage proxies) internal returns(Proxy storage) {
        uint pid = proxies.startProcess("findCurrentProxy");
        return proxies.currentProxy.assertExists().finishProcessInStorage(pid);
    }


    /**-----------------------------
        🏷 Generate Unique Name
    -------------------------------*/
    function genUniqueName(ProxyRegistry storage proxies) internal returns(string memory name) {
        uint pid = proxies.startProcess("genUniqueName");
        ScanRange memory range = Config().SCAN_RANGE;
        for (uint i = range.START; i <= range.END; ++i) {
            name = Config().DEFAULT_PROXY_NAME.toSequential(i);
            if (proxies.existsInDeployed(name).isFalse()) return name.recordExecFinish(pid);
        }
        throwError(ERR.FIND_NAME_OVER_RANGE);
    }


}

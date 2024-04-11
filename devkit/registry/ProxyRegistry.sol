// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {ProcessLib} from "devkit/utils/debug/ProcessLib.sol";
    using ProcessLib for ProxyRegistry global;
import {Inspector} from "devkit/utils/inspector/Inspector.sol";
    using Inspector for ProxyRegistry global;
import {MappingAnalyzer} from "devkit/utils/inspector/MappingAnalyzer.sol";
    using MappingAnalyzer for mapping(string => Proxy);
// Validation
import {Require} from "devkit/error/Require.sol";

// Core Type
import {Proxy, ProxyLib} from "devkit/core/Proxy.sol";
import {Dictionary} from "devkit/core/Dictionary.sol";
// Context
import {Current} from "devkit/utils/context/Current.sol";


/**=======================
    📕 Proxy Registry
=========================*/
using ProxyRegistryLib for ProxyRegistry global;
struct ProxyRegistry {
    mapping(string name => Proxy) proxies;
    Current current;
}
library ProxyRegistryLib {

    /**-------------------------------
        🚀 Deploy & Register Proxy
    ---------------------------------*/
    function deploy(ProxyRegistry storage registry, string memory name, Dictionary memory dictionary, bytes memory initData) internal returns(Proxy storage) {
        uint pid = registry.startProcess("deploy");
        Require.notEmpty(name);
        Require.notEmpty(dictionary);
        Proxy memory proxy = ProxyLib.deploy(dictionary, initData);
        registry.register(name, proxy);
        return registry.findCurrent().finishProcessInStorage(pid);
    }

    /**-----------------------
        🗳️ Register Proxy
    -------------------------*/
    function register(ProxyRegistry storage registry, string memory name, Proxy memory proxy) internal returns(Proxy storage) {
        uint pid = registry.startProcess("register");
        Require.notEmpty(name);
        Require.notEmpty(proxy);
        Require.notRegistered(registry, name);
        Proxy storage proxyStorage = registry.proxies[name] = proxy;
        proxyStorage.build().lock();
        registry.current.update(name);
        return proxyStorage.finishProcessInStorage(pid);
    }

    /**-------------------
        🔍 Find Proxy
    ---------------------*/
    function find(ProxyRegistry storage registry, string memory name) internal returns(Proxy storage) {
        uint pid = registry.startProcess("find");
        Require.notEmpty(name);
        Require.validRegistration(registry, name);
        Proxy storage proxy = registry.proxies[name];
        Require.valid(proxy);
        return proxy.finishProcessInStorage(pid);
    }
    function findCurrent(ProxyRegistry storage registry) internal returns(Proxy storage) {
        uint pid = registry.startProcess("findCurrent");
        string memory name = registry.current.name;
        Require.notEmpty(name);
        return registry.find(name).finishProcessInStorage(pid);
    }

    /**-----------------------------
        🏷 Generate Unique Name
    -------------------------------*/
    function genUniqueName(ProxyRegistry storage registry) internal returns(string memory name) {
        return registry.proxies.genUniqueName();
    }
    function genUniqueMockName(ProxyRegistry storage registry) internal returns(string memory name) {
        return registry.proxies.genUniqueMockName();
    }

}

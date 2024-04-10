// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {ProcessLib} from "devkit/core/method/debug/ProcessLib.sol";
    using ProcessLib for ProxyRegistry global;
import {Inspector} from "devkit/core/method/inspector/Inspector.sol";
    using Inspector for ProxyRegistry global;
import {Require} from "devkit/error/Require.sol";

// Context
import {Current} from "devkit/core/method/context/Current.sol";
// Core Type
import {Proxy, ProxyLib} from "devkit/core/types/Proxy.sol";
import {Dictionary} from "devkit/core/types/Dictionary.sol";


/**=======================
    📕 Proxy Registry
=========================*/
using ProxyRegistryLib for ProxyRegistry global;
struct ProxyRegistry {
    mapping(string name => Proxy) proxies;
    Current current;
}
library ProxyRegistryLib {

    /**---------------------
        🚀 Deploy Proxy
    -----------------------*/
    function deploy(ProxyRegistry storage registry, string memory name, Dictionary memory dictionary, bytes memory initData) internal returns(Proxy storage) {
        uint pid = registry.startProcess("deploy");
        Require.notEmpty(name);
        Require.isNotEmpty(dictionary);
        registry.insert(name, ProxyLib.deploy(dictionary, initData));
        return registry.findCurrent().finishProcessInStorage(pid);
    }


    /**---------------------
        🗳️ Insert Proxy
    -----------------------*/
    function insert(ProxyRegistry storage registry, string memory name, Proxy memory proxy) internal returns(Proxy storage) {
        uint pid = registry.startProcess("insert");
        Require.notEmpty(name);
        Require.notEmpty(proxy);
        Require.notExists(registry, name);
        registry.proxies[name] = proxy;
        registry.current.update(name);
        return registry.findCurrent().build().lock().finishProcessInStorage(pid);
    }


    /**-------------------
        🔍 Find Proxy
    ---------------------*/
    function find(ProxyRegistry storage registry, string memory name) internal returns(Proxy storage) {
        uint pid = registry.startProcess("find");
        Require.notEmpty(name);
        Require.isComplete(registry, name);
        Proxy storage proxy = registry.proxies[name];
        Require.exists(proxy);
        return proxy.finishProcessInStorage(pid);
    }
    function findCurrent(ProxyRegistry storage registry) internal returns(Proxy storage) {
        uint pid = registry.startProcess("findCurrent");
        string memory name = registry.current.name;
        Require.notEmpty(name);
        return registry.find(name).finishProcessInStorage(pid);
    }

}

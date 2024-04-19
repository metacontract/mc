// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {ProcessManager} from "devkit/system/debug/Process.sol";
import {Inspector} from "devkit/types/Inspector.sol";
import {NameGenerator} from "devkit/utils/mapping/NameGenerator.sol";
// Validation
import {Validate} from "devkit/system/Validate.sol";

// Context
import {Current} from "devkit/registry/context/Current.sol";
// Core Type
import {Proxy, ProxyLib} from "devkit/core/Proxy.sol";
import {Dictionary} from "devkit/core/Dictionary.sol";


////////////////////////////////////////////////////////
//  📕 Proxy Registry    ///////////////////////////////
    using ProxyRegistryLib for ProxyRegistry global;
    using ProcessManager for ProxyRegistry global;
    using Inspector for ProxyRegistry global;
////////////////////////////////////////////////////////
struct ProxyRegistry {
    mapping(string name => Proxy) proxies;
    Current current;
}
library ProxyRegistryLib {
    using NameGenerator for mapping(string => Proxy);

    /**-------------------------------
        🚀 Deploy & Register Proxy
    ---------------------------------*/
    function deploy(ProxyRegistry storage registry, string memory name, Dictionary memory dictionary, bytes memory initData) internal returns(Proxy storage) {
        uint pid = registry.startProcess("deploy");
        Validate.MUST_NotEmptyName(name);
        Validate.MUST_Completed(dictionary);
        Proxy memory proxy = ProxyLib.deploy(dictionary, initData);
        registry.register(name, proxy);
        return registry.findCurrent().finishProcessInStorage(pid);
    }

    /**-----------------------
        🗳️ Register Proxy
    -------------------------*/
    function register(ProxyRegistry storage registry, string memory name, Proxy memory proxy) internal returns(Proxy storage) {
        uint pid = registry.startProcess("register");
        Validate.MUST_NotEmptyName(name);
        Validate.MUST_Completed(proxy);
        Validate.MUST_NotRegistered(registry, name);
        Proxy storage proxyStorage = registry.proxies[name] = proxy;
        registry.current.update(name);
        return proxyStorage.finishProcessInStorage(pid);
    }

    /**-------------------
        🔍 Find Proxy
    ---------------------*/
    function find(ProxyRegistry storage registry, string memory name) internal returns(Proxy storage) {
        uint pid = registry.startProcess("find");
        Validate.MUST_NotEmptyName(name);
        Validate.MUST_Registered(registry, name);
        Proxy storage proxy = registry.proxies[name];
        Validate.MUST_Completed(proxy);
        return proxy.finishProcessInStorage(pid);
    }
    function findCurrent(ProxyRegistry storage registry) internal returns(Proxy storage) {
        uint pid = registry.startProcess("findCurrent");
        string memory name = registry.current.name;
        Validate.MUST_NotEmptyName(name);
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

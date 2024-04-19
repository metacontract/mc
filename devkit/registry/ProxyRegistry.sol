// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {Tracer, param} from "devkit/system/Tracer.sol";
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
    using Tracer for ProxyRegistry global;
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
    function deploy(ProxyRegistry storage registry, string memory name, Dictionary memory dictionary, bytes memory initData) internal returns(Proxy storage proxy) {
        uint pid = registry.startProcess("deploy", param(name, dictionary, initData));
        Validate.MUST_NotEmptyName(name);
        Validate.MUST_Completed(dictionary);
        Proxy memory _proxy = ProxyLib.deploy(dictionary, initData);
        proxy = registry.register(name, _proxy);
        registry.finishProcess(pid);
    }

    /**-----------------------
        🗳️ Register Proxy
    -------------------------*/
    function register(ProxyRegistry storage registry, string memory name, Proxy memory _proxy) internal returns(Proxy storage proxy) {
        uint pid = registry.startProcess("register", param(name, _proxy));
        Validate.MUST_NotEmptyName(name);
        Validate.MUST_Completed(_proxy);
        Validate.MUST_NotRegistered(registry, name);
        proxy = registry.proxies[name] = _proxy;
        registry.current.update(name);
        registry.finishProcess(pid);
    }

    /**-------------------
        🔍 Find Proxy
    ---------------------*/
    function find(ProxyRegistry storage registry, string memory name) internal returns(Proxy storage proxy) {
        uint pid = registry.startProcess("find", param(name));
        Validate.MUST_NotEmptyName(name);
        Validate.MUST_Registered(registry, name);
        proxy = registry.proxies[name];
        Validate.MUST_Completed(proxy);
        registry.finishProcess(pid);
    }
    function findCurrent(ProxyRegistry storage registry) internal returns(Proxy storage proxy) {
        uint pid = registry.startProcess("findCurrent");
        string memory name = registry.current.name;
        Validate.MUST_NotEmptyName(name);
        proxy = registry.find(name);
        registry.finishProcess(pid);
    }

    /**-----------------------------
        🏷 Generate Unique Name
    -------------------------------*/
    function genUniqueName(ProxyRegistry storage registry) internal returns(string memory name) {
        uint pid = registry.startProcess("genUniqueName");
        name = registry.proxies.genUniqueName();
        registry.finishProcess(pid);
    }
    function genUniqueMockName(ProxyRegistry storage registry) internal returns(string memory name) {
        uint pid = registry.startProcess("genUniqueMockName");
        name = registry.proxies.genUniqueMockName();
        registry.finishProcess(pid);
    }

}

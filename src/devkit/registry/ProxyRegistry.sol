// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;
/**
 * ---------------------
 *     Support Methods
 * -----------------------
 */

import {Tracer, param} from "@mc-devkit/system/Tracer.sol";
import {Inspector} from "@mc-devkit/types/Inspector.sol";
import {NameGenerator} from "@mc-devkit/utils/mapping/NameGenerator.sol";
// Validation
import {Validator} from "@mc-devkit/system/Validator.sol";

// Context
import {Current} from "@mc-devkit/registry/context/Current.sol";
// Core Type
import {Proxy, ProxyLib} from "@mc-devkit/core/Proxy.sol";
import {Dictionary} from "@mc-devkit/core/Dictionary.sol";

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

    /**
     * -----------------------
     *     🗳️ Register Proxy
     * -------------------------
     */
    function register(ProxyRegistry storage registry, string memory name, Proxy memory _proxy)
        internal
        returns (Proxy storage proxy)
    {
        uint256 pid = registry.startProcess("register", param(name, _proxy));
        Validator.MUST_NotEmptyName(name);
        Validator.MUST_Completed(_proxy);
        Validator.MUST_NotRegistered(registry, name);
        proxy = registry.proxies[name] = _proxy;
        registry.current.update(name);
        registry.finishProcess(pid);
    }

    /**
     * -------------------
     *     🔍 Find Proxy
     * ---------------------
     */
    function find(ProxyRegistry storage registry, string memory name) internal returns (Proxy storage proxy) {
        uint256 pid = registry.startProcess("find", param(name));
        Validator.MUST_NotEmptyName(name);
        proxy = registry.proxies[name];
        Validator.MUST_Completed(proxy);
        registry.finishProcess(pid);
    }

    function findCurrent(ProxyRegistry storage registry) internal returns (Proxy storage proxy) {
        uint256 pid = registry.startProcess("findCurrent");
        Validator.MUST_ExistCurrentName(registry);
        proxy = registry.find(registry.current.name);
        registry.finishProcess(pid);
    }

    /**
     * -----------------------------
     *     🏷 Generate Unique Name
     * -------------------------------
     */
    function genUniqueName(ProxyRegistry storage registry) internal returns (string memory name) {
        uint256 pid = registry.startProcess("genUniqueName");
        name = registry.proxies.genUniqueName();
        registry.finishProcess(pid);
    }

    function genUniqueMockName(ProxyRegistry storage registry, string memory baseName)
        internal
        returns (string memory name)
    {
        uint256 pid = registry.startProcess("genUniqueMockName");
        name = registry.proxies.genUniqueMockName(baseName);
        registry.finishProcess(pid);
    }
}

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
import {Bundle} from "@mc-devkit/core/Bundle.sol";
import {Function} from "@mc-devkit/core/Function.sol";

//////////////////////////////////////////////////////////
//  📙 Bundle Registry    ////////////////////////////////
using BundleRegistryLib for BundleRegistry global;
using Tracer for BundleRegistry global;
using Inspector for BundleRegistry global;
//////////////////////////////////////////////////////////

struct BundleRegistry {
    mapping(string name => Bundle) bundles;
    Current current;
}

library BundleRegistryLib {
    using Tracer for string;
    using NameGenerator for mapping(string => Bundle);

    /**
     * ---------------------
     *     🌱 Init Bundle
     * -----------------------
     */
    function init(BundleRegistry storage registry, string memory name) internal returns (BundleRegistry storage) {
        uint256 pid = registry.startProcess("init", param(name));
        Validator.MUST_NotEmptyName(name);
        Bundle storage bundle = registry.bundles[name];
        Validator.MUST_NotInitialized(bundle);
        bundle.assignName(name);
        registry.current.update(name);
        return registry.finishProcess(pid);
    }

    function ensureInit(BundleRegistry storage registry) internal returns (BundleRegistry storage) {
        uint256 pid = registry.startProcess("ensureInit");
        Validator.SHOULD_ExistCurrentBundle(registry) ? registry : registry.init(registry.genUniqueName());
        return registry.finishProcess(pid);
    }

    /**
     * --------------------
     *     🔍 Find Bundle
     * ----------------------
     */
    function find(BundleRegistry storage registry, string memory name) internal returns (Bundle storage bundle) {
        uint256 pid = registry.startProcess("find", param(name));
        Validator.MUST_NotEmptyName(name);
        bundle = registry.bundles[name];
        Validator.SHOULD_Completed(bundle);
        registry.finishProcess(pid);
    }

    function findCurrent(BundleRegistry storage registry) internal returns (Bundle storage bundle) {
        uint256 pid = registry.startProcess("findCurrent");
        Validator.MUST_ExistCurrentName(registry);
        bundle = registry.find(registry.current.name);
        registry.finishProcess(pid);
    }

    /**
     * -----------------------------
     *     🏷 Generate Unique Name
     * -------------------------------
     */
    function genUniqueName(BundleRegistry storage registry) internal returns (string memory name) {
        uint256 pid = registry.startProcess("genUniqueName");
        name = registry.bundles.genUniqueName();
        registry.finishProcess(pid);
    }
}

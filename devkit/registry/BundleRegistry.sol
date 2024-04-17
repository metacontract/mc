// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {ProcessLib} from "devkit/system/debug/Process.sol";
    using ProcessLib for BundleRegistry global;
    using ProcessLib for string;
import {Inspector} from "devkit/types/Inspector.sol";
    using Inspector for BundleRegistry global;
import {NameGenerator} from "devkit/utils/mapping/NameGenerator.sol";
    using NameGenerator for mapping(string => Bundle);
// Validation
import {Validate} from "devkit/system/Validate.sol";

// Core Type
import {Bundle} from "devkit/core/Bundle.sol";
import {Function} from "devkit/core/Function.sol";
// Context
import {Current} from "devkit/registry/context/Current.sol";


/**========================
    📙 Bundle Registry
==========================*/
using BundleRegistryLib for BundleRegistry global;
struct BundleRegistry {
    mapping(string name => Bundle) bundles;
    Current current;
}
library BundleRegistryLib {

    /**---------------------
        🌱 Init Bundle
    -----------------------*/
    function init(BundleRegistry storage registry, string memory name) internal returns(BundleRegistry storage) {
        uint pid = registry.startProcess("init");
        Validate.MUST_NotEmptyName(name);
        Bundle storage bundle = registry.bundles[name];
        Validate.MUST_notInitialized(bundle);
        bundle.assignName(name);
        registry.current.update(name);
        return registry.finishProcess(pid);
    }
    function ensureInit(BundleRegistry storage registry) internal returns(BundleRegistry storage) {
        uint pid = registry.startProcess("ensureInit");
        Validate.SHOULD_ExistCurrentBundle(registry) ? registry : registry.init(registry.genUniqueName());
        return registry.finishProcess(pid);
    }

    /**--------------------
        🔍 Find Bundle
    ----------------------*/
    function find(BundleRegistry storage registry, string memory name) internal returns(Bundle storage) {
        uint pid = registry.startProcess("find");
        Validate.MUST_NotEmptyName(name);
        Bundle storage bundle = registry.bundles[name];
        Validate.SHOULD_Completed(bundle);
        return bundle.finishProcess(pid);
    }
    function findCurrentName(BundleRegistry storage registry) internal returns(string memory) {
        uint pid = registry.startProcess("findCurrentName");
        string memory name = registry.current.name;
        Validate.MUST_NotEmptyName(name);
        return name.finishProcess(pid);
    }
    function findCurrent(BundleRegistry storage registry) internal returns(Bundle storage) {
        uint pid = registry.startProcess("findCurrent");
        string memory name = registry.findCurrentName();
        return registry.find(name).finishProcess(pid);
    }

    /**-----------------------------
        🏷 Generate Unique Name
    -------------------------------*/
    function genUniqueName(BundleRegistry storage registry) internal returns(string memory name) {
        return registry.bundles.genUniqueName();
    }

}

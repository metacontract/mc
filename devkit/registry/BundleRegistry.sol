// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {ProcessManager, params} from "devkit/system/debug/Process.sol";
import {Inspector} from "devkit/types/Inspector.sol";
import {NameGenerator} from "devkit/utils/mapping/NameGenerator.sol";
// Validation
import {Validate} from "devkit/system/Validate.sol";

// Context
import {Current} from "devkit/registry/context/Current.sol";
// Core Type
import {Bundle} from "devkit/core/Bundle.sol";
import {Function} from "devkit/core/Function.sol";


//////////////////////////////////////////////////////////
//  📙 Bundle Registry    ////////////////////////////////
    using BundleRegistryLib for BundleRegistry global;
    using ProcessManager for BundleRegistry global;
    using Inspector for BundleRegistry global;
//////////////////////////////////////////////////////////
struct BundleRegistry {
    mapping(string name => Bundle) bundles;
    Current current;
}
library BundleRegistryLib {
    using ProcessManager for string;
    using NameGenerator for mapping(string => Bundle);

    /**---------------------
        🌱 Init Bundle
    -----------------------*/
    function init(BundleRegistry storage registry, string memory name) internal returns(BundleRegistry storage) {
        uint pid = registry.startProcess("init", params(name));
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
    function find(BundleRegistry storage registry, string memory name) internal returns(Bundle storage bundle) {
        uint pid = registry.startProcess("find", params(name));
        Validate.MUST_NotEmptyName(name);
        bundle = registry.bundles[name];
        Validate.SHOULD_Completed(bundle);
        registry.finishProcess(pid);
    }
    function findCurrent(BundleRegistry storage registry) internal returns(Bundle storage bundle) {
        uint pid = registry.startProcess("findCurrent");
        string memory name = registry.findCurrentName();
        bundle = registry.find(name);
        registry.finishProcess(pid);
    }
    function findCurrentName(BundleRegistry storage registry) internal returns(string memory name) {
        uint pid = registry.startProcess("findCurrentName");
        name = registry.current.name;
        Validate.MUST_NotEmptyName(name);
        registry.finishProcess(pid);
    }

    /**-----------------------------
        🏷 Generate Unique Name
    -------------------------------*/
    function genUniqueName(BundleRegistry storage registry) internal returns(string memory name) {
        uint pid = registry.startProcess("genUniqueName");
        name = registry.bundles.genUniqueName();
        registry.finishProcess(pid);
    }

}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {ProcessLib} from "devkit/utils/debug/ProcessLib.sol";
    using ProcessLib for BundleRegistry global;
import {Inspector} from "devkit/utils/inspector/Inspector.sol";
    using Inspector for BundleRegistry global;
import {MappingAnalyzer} from "devkit/utils/inspector/MappingAnalyzer.sol";
    using MappingAnalyzer for mapping(string => Bundle);
// Validation
import {Validate} from "devkit/validate/Validate.sol";

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
        Validate.notEmpty(name);
        Bundle storage bundle = registry.bundles[name];
        Validate.isUnassigned(bundle);
        bundle.assignName(name);
        registry.current.update(name);
        return registry.finishProcess(pid);
    }

    /**--------------------
        🔍 Find Bundle
    ----------------------*/
    function find(BundleRegistry storage registry, string memory name) internal returns(Bundle storage) {
        uint pid = registry.startProcess("find");
        Validate.MUST_notEmpty(name);
        Validate.SHOULD_beCompleted(registry, name);
        Bundle storage bundle = registry.bundles[name];
        Validate.SHOULD_valid(bundle);
        return bundle.finishProcess(pid);
    }
    function findCurrent(BundleRegistry storage registry) internal returns(Bundle storage) {
        uint pid = registry.startProcess("findCurrent");
        string memory name = registry.current.name;
        Validate.MUST_notEmpty(name);
        return registry.find(name).finishProcess(pid);
    }

    /**-----------------------------
        🏷 Generate Unique Name
    -------------------------------*/
    function genUniqueName(BundleRegistry storage registry) internal returns(string memory name) {
        return registry.bundles.genUniqueName();
    }

}

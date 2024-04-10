// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {ProcessLib} from "devkit/core/method/debug/ProcessLib.sol";
    using ProcessLib for BundleRegistry global;
import {Inspector} from "devkit/core/method/inspector/Inspector.sol";
    using Inspector for BundleRegistry global;
import {MappingAnalyzer} from "devkit/core/method/inspector/MappingAnalyzer.sol";
    using MappingAnalyzer for mapping(string => Bundle);

// Validation
import {validate} from "devkit/error/Validate.sol";
import {Require} from "devkit/error/Require.sol";
// Context
import {Current} from "devkit/core/method/context/Current.sol";
// Core Type
import {Bundle} from "devkit/core/types/Bundle.sol";
import {Function} from "devkit/core/types/Function.sol";


/**========================
    📙 Bundle Registry
==========================*/
using BundleRegistryLib for BundleRegistry global;
struct BundleRegistry {
    mapping(string name => Bundle) bundles;
    Current current;
}
library BundleRegistryLib {
    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        🌱 Init Bundle
        🔍 Find Bundle
        🏷 Generate Unique Name
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

    /**---------------------
        🌱 Init Bundle
    -----------------------*/
    function init(BundleRegistry storage registry, string memory name) internal returns(BundleRegistry storage) {
        uint pid = registry.startProcess("init");
        Require.notEmpty(name);
        Bundle storage bundle = registry.bundles[name];

        Require.isUnassigned(bundle);
        bundle.assignName(name);

        registry.current.update(name);
        return registry.finishProcess(pid);
    }

    /**--------------------
        🔍 Find Bundle
    ----------------------*/
    function find(BundleRegistry storage registry, string memory name) internal returns(Bundle storage) {
        uint pid = registry.startProcess("find");
        return registry.bundles[name].finishProcess(pid);
    }
    function findCurrent(BundleRegistry storage registry) internal returns(Bundle storage) {
        uint pid = registry.startProcess("findCurrent");
        string memory name = registry.current.name;
        Require.notEmpty(name);
        return registry.find(name).finishProcess(pid);
    }

    /**-----------------------------
        🏷 Generate Unique Name
    -------------------------------*/
    function genUniqueName(BundleRegistry storage bundle) internal returns(string memory name) {
        return bundle.bundles.genUniqueName();
    }

}

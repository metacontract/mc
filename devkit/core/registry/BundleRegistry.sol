// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**--------------------------
    Apply Support Methods
----------------------------*/
import {ProcessLib} from "devkit/core/method/debug/ProcessLib.sol";
    using ProcessLib for BundleRegistry global;
import {Inspector} from "devkit/core/method/inspector/Inspector.sol";
    using Inspector for BundleRegistry global;
import {MappingAnalyzer} from "devkit/core/method/inspector/MappingAnalyzer.sol";
    using MappingAnalyzer for mapping(string => Bundle);

// Validation
import {validate} from "devkit/error/Validate.sol";
import {Require} from "devkit/error/Require.sol";
// Core Type
import {Bundle} from "devkit/core/types/Bundle.sol";
import {Function} from "devkit/core/types/Function.sol";


struct Current {
    string name;
}
using CurrentLib for Current global;
library CurrentLib {
    function update(Current storage current, string memory name) internal {
        Require.notEmpty(name);
        current.name = name;
    }
    function reset(Current storage current) internal {
        // uint pid = bundle.startProcess("reset");
        delete current.name;
        // return bundle.finishProcess(pid);
    }
}

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
        🔼 Update Current Context Function & Bundle
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


    // /**------------------------------------------------
    //     🔼 Update Current Context
    // --------------------------------------------------*/
    // function updateCurrent(BundleRegistry storage bundle, string memory name) internal returns(BundleRegistry storage) {
    //     uint pid = bundle.startProcess("safeUpdateCurrentBundle");
    //     Require.notEmpty(name);
    //     bundle.currentName = name;
    //     return bundle.finishProcess(pid);
    // }


    // /**-----------------------------------------------
    //     ♻️ Reset Current Context Function & Bundle
    // -------------------------------------------------*/
    // function reset(BundleRegistry storage bundle) internal returns(BundleRegistry storage) {
    //     uint pid = bundle.startProcess("reset");
    //     delete bundle.currentName;
    //     return bundle.finishProcess(pid);
    // }


    /**--------------------
        🔍 Find Bundle
    ----------------------*/
    function find(BundleRegistry storage bundle, string memory name) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("find");
        return bundle.bundles[name].finishProcess(pid);
    }
    function findCurrent(BundleRegistry storage bundle) internal returns(Bundle storage) {
        uint pid = bundle.startProcess("findCurrent");
        string memory name = bundle.current.name;
        Require.notEmpty(name);
        return bundle.find(name).finishProcess(pid);
    }


    /**-----------------------------
        🏷 Generate Unique Name
    -------------------------------*/
    function genUniqueName(BundleRegistry storage bundle) internal returns(string memory name) {
        return bundle.bundles.genUniqueName();
    }

}

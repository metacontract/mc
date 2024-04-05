// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKit} from "devkit/MCDevKit.sol";
// Validation
import {check} from "devkit/error/Validation.sol";
// Utils
import {Params} from "devkit/debug/Params.sol";
import {Config} from "devkit/Config.sol";
// Core
//  dictionary
import {Dictionary, DictionaryUtils} from "devkit/core/dictionary/Dictionary.sol";
//  functions
import {BundleInfo} from "devkit/core/functions/BundleInfo.sol";
import {MCStdFuncsArgs} from "devkit/core/functions/MCStdFuncs.sol";
    using MCStdFuncsArgs for address;
//  proxy
import {Proxy, ProxyUtils} from "devkit/core/proxy/Proxy.sol";



/***********************************************
    🚀 Deployment
        🌞 Deploy Meta Contract
        🏠 Deploy Proxy
        📚 Deploy Dictionary
        🔂 Duplicate Dictionary
************************************************/
using DeployLib for MCDevKit;
library DeployLib {
    string constant LIB_NAME = "MCDeploy";

    /**-----------------------------
        🌞 Deploy Meta Contract
    -------------------------------*/
    function deploy(MCDevKit storage mc, string memory name, BundleInfo storage bundleInfo, address owner, bytes memory initData) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("deploy");
        // uint pid = mc.recordExecStart("deploy", PARAMS.append(name).comma().append(bundleInfo.name).comma().append(facade).comma().append(owner).comma().append(string(initData)));
        Dictionary memory dictionary = mc.deployDictionary(name, bundleInfo, owner);
        mc.deployProxy(name, dictionary, initData);
        return mc.recordExecFinish(pid);
        // TODO gen and set facade
    }

    function deploy(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return mc.deploy(mc.findCurrentBundleName(), mc.functions.findCurrentBundle(), Config.defaultOwner(), Config.defaultInitData());
    }
    // function deploy(MCDevKit storage mc, string memory name, BundleInfo storage bundleInfo, address facade, address owner) internal returns(MCDevKit storage) {
    //     return mc.deploy(name, bundleInfo, facade, owner, Config.defaultInitData());
    // }
    // function deploy(MCDevKit storage mc, string memory name, BundleInfo storage bundleInfo) internal returns(MCDevKit storage) {
    //     return mc.deploy(name, bundleInfo, Config.defaultInitData(), );
    // }
    // function deploy(MCDevKit storage mc, BundleInfo storage bundleInfo) internal returns(MCDevKit storage) {
    //     return mc.deploy(Config.defaultName(), bundleInfo, Config.defaultInitData());
    // }
    // function deploy(MCDevKit storage mc, string memory name, bytes memory initData) internal returns(MCDevKit storage) {
    //     return mc.deploy(name, mc.functions.findBundle(name), initData);
    // }
    // function deploy(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
    //     return mc.deploy(name, mc.functions.findBundle(name), Config.defaultInitData());
    // }
    function deploy(MCDevKit storage mc, bytes memory initData) internal returns(MCDevKit storage) {
        return mc.deploy(mc.findCurrentBundleName(), mc.functions.findCurrentBundle(), Config.defaultOwner(), initData);
    }


    /**---------------------
        🏠 Deploy Proxy
    -----------------------*/
    function deployProxy(MCDevKit storage mc, string memory name, Dictionary memory dictionary, bytes memory initData) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("deployProxy", Params.append(dictionary.addr, initData));
        Proxy memory proxy = ProxyUtils.deploy(dictionary, initData);
        mc.proxy.safeAdd(name, proxy)
                .safeUpdate(proxy);
        return mc.recordExecFinish(pid);
    }
    function deployProxy(MCDevKit storage mc, string memory name, Dictionary storage dictionary, address owner) internal returns(MCDevKit storage) {
        return mc.deployProxy(name, dictionary, owner.initSetAdminBytes());
    }
    function deployProxy(MCDevKit storage mc, string memory name, Dictionary storage dictionary) internal returns(MCDevKit storage) {
        return mc.deployProxy(name, dictionary, Config.defaultOwner().initSetAdminBytes());
    }
    function deployProxy(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        return mc.deployProxy(name, mc.findCurrentDictionary(), Config.defaultOwner().initSetAdminBytes());
    }
    function deployProxy(MCDevKit storage mc, string memory name, bytes memory initData) internal returns(MCDevKit storage) {
        return mc.deployProxy(name, mc.findCurrentDictionary(), initData);
    }
    function deployProxy(MCDevKit storage mc, bytes memory initData) internal returns(MCDevKit storage) {
        return mc.deployProxy(mc.proxy.genUniqueName(), mc.findCurrentDictionary(), initData);
    }
    function deployProxy(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return mc.deployProxy(mc.proxy.genUniqueName(), mc.findCurrentDictionary(), Config.defaultOwner().initSetAdminBytes());
    }


    /**-------------------------
        📚 Deploy Dictionary
    ---------------------------*/
    function deployDictionary(MCDevKit storage mc, string memory name, BundleInfo storage bundleInfo, address owner) internal returns(Dictionary memory) {
        uint pid = mc.recordExecStart("deployDictionary", Params.append(name, bundleInfo.name, owner));
        Dictionary memory dictionary = DictionaryUtils  .deploy(owner)
                                                        .set(bundleInfo)
                                                        .upgradeFacade(bundleInfo.facade);
        mc.dictionary   .safeAdd(name, dictionary)
                        .safeUpdate(dictionary);
        return dictionary.recordExecFinish(pid);
    }

    function deployDictionary(MCDevKit storage mc) internal returns(Dictionary memory) {
        return mc.deployDictionary(mc.dictionary.genUniqueName(), mc.functions.findCurrentBundle(), Config.defaultOwner());
    }
    function deployDictionary(MCDevKit storage mc, string memory name) internal returns(Dictionary memory) {
        return mc.deployDictionary(name, mc.functions.findCurrentBundle(), Config.defaultOwner());
    }
    function deployDictionary(MCDevKit storage mc, BundleInfo storage bundleInfo) internal returns(Dictionary memory) {
        return mc.deployDictionary(mc.dictionary.genUniqueName(), bundleInfo, Config.defaultOwner());
    }
    function deployDictionary(MCDevKit storage mc, address owner) internal returns(Dictionary memory) {
        return mc.deployDictionary(mc.dictionary.genUniqueName(), mc.functions.findCurrentBundle(), owner);
    }
    function deployDictionary(MCDevKit storage mc, string memory name, BundleInfo storage bundleInfo) internal returns(Dictionary memory) {
        return mc.deployDictionary(name, bundleInfo, Config.defaultOwner());
    }
    function deployDictionary(MCDevKit storage mc, string memory name, address owner) internal returns(Dictionary memory) {
        return mc.deployDictionary(name, mc.functions.findCurrentBundle(), owner);
    }
    function deployDictionary(MCDevKit storage mc, BundleInfo storage bundleInfo, address owner) internal returns(Dictionary memory) {
        return mc.deployDictionary(mc.dictionary.genUniqueName(), bundleInfo, owner);
    }


    /**----------------------------
        🔂 Duplicate Dictionary
    ------------------------------*/
    function duplicateDictionary(MCDevKit storage mc, string memory name, Dictionary storage targetDictionary) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("duplicateDictionary", Params.append(name, targetDictionary.addr));
        Dictionary memory newDictionary = targetDictionary.duplicate();
        mc.dictionary   .safeAdd(name, newDictionary)
                        .safeUpdate(newDictionary);
        return mc.recordExecFinish(pid);
    }
    function duplicateDictionary(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        return mc.duplicateDictionary(name, mc.findCurrentDictionary());
    }
    function duplicateDictionary(MCDevKit storage mc, Dictionary storage targetDictionary) internal returns(MCDevKit storage) {
        return mc.duplicateDictionary(mc.dictionary.genUniqueDuplicatedName(), targetDictionary);
    }
    function duplicateDictionary(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return mc.duplicateDictionary(mc.dictionary.genUniqueDuplicatedName(), mc.findCurrentDictionary());
    }

}

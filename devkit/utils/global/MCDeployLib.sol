// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKit} from "devkit/MCDevKit.sol";
import {System} from "devkit/system/System.sol";
// Validation
import {Validate} from "devkit/system/Validate.sol";
// Utils
import {Params} from "devkit/system/debug/Params.sol";
// Core
//  dictionary
import {Dictionary, DictionaryLib} from "devkit/core/Dictionary.sol";
//  functions
import {Bundle} from "devkit/core/Bundle.sol";
import {StdFunctionsArgs} from "devkit/registry/StdRegistry.sol";
    using StdFunctionsArgs for address;
//  proxy
import {Proxy, ProxyLib} from "devkit/core/Proxy.sol";

import {NameGenerator} from "devkit/utils/mapping/NameGenerator.sol";
    using NameGenerator for mapping(string => Dictionary);
    using NameGenerator for mapping(string => Proxy);


/***************************************
    🚀 Deployment
        🌞 Deploy Meta Contract
        🏠 Deploy Proxy
        📚 Deploy Dictionary
        🔂 Duplicate Dictionary
****************************************/
library MCDeployLib {

    /**-----------------------------
        🌞 Deploy Meta Contract
    -------------------------------*/
    function deploy(MCDevKit storage mc, string memory name, Bundle storage bundle, address owner, bytes memory initData) internal returns(MCDevKit storage) {
        uint pid = mc.startProcess("deploy");
        // uint pid = mc.startProcess("deploy", PARAMS.append(name).comma().append(bundle.name).comma().append(facade).comma().append(owner).comma().append(string(initData)));
        Dictionary memory dictionary = mc.dictionary.deploy(name, bundle, owner);
        mc.proxy.deploy(name, dictionary, initData);
        return mc.finishProcess(pid);
        // TODO gen and set facade
    }

    function deploy(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return deploy(mc, mc.bundle.findCurrent().name, mc.bundle.findCurrent(), System.Config().defaultOwner(), System.Config().defaultInitData());
    }
    // function deploy(MCDevKit storage mc, string memory name, Bundle storage bundleInfo, address facade, address owner) internal returns(MCDevKit storage) {
    //     return mc.deploy(name, bundleInfo, facade, owner, System.Config().defaultInitData());
    // }
    // function deploy(MCDevKit storage mc, string memory name, Bundle storage bundleInfo) internal returns(MCDevKit storage) {
    //     return mc.deploy(name, bundleInfo, System.Config().defaultInitData(), );
    // }
    // function deploy(MCDevKit storage mc, Bundle storage bundleInfo) internal returns(MCDevKit storage) {
    //     return mc.deploy(System.Config().defaultName(), bundleInfo, System.Config().defaultInitData());
    // }
    // function deploy(MCDevKit storage mc, string memory name, bytes memory initData) internal returns(MCDevKit storage) {
    //     return mc.deploy(name, mc.functions.findBundle(name), initData);
    // }
    // function deploy(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
    //     return mc.deploy(name, mc.functions.findBundle(name), System.Config().defaultInitData());
    // }
    function deploy(MCDevKit storage mc, bytes memory initData) internal returns(MCDevKit storage) {
        return mc.deploy(mc.bundle.findCurrent().name, mc.bundle.findCurrent(), System.Config().defaultOwner(), initData);
    }


    /**---------------------
        🏠 Deploy Proxy
    -----------------------*/
    function deployProxy(MCDevKit storage mc, string memory name, Dictionary memory dictionary, bytes memory initData) internal returns(MCDevKit storage) {
        uint pid = mc.startProcess("deployProxy", Params.append(dictionary.addr, initData));
        Proxy memory proxy = ProxyLib.deploy(dictionary, initData);
        mc.proxy.register(name, proxy);
        return mc.finishProcess(pid);
    }
    function deployProxy(MCDevKit storage mc, string memory name, Dictionary storage dictionary, address owner) internal returns(MCDevKit storage) {
        return mc.deployProxy(name, dictionary, owner.initSetAdminBytes());
    }
    function deployProxy(MCDevKit storage mc, string memory name, Dictionary storage dictionary) internal returns(MCDevKit storage) {
        return mc.deployProxy(name, dictionary, System.Config().defaultOwner().initSetAdminBytes());
    }
    function deployProxy(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        return mc.deployProxy(name, mc.findCurrentDictionary(), System.Config().defaultOwner().initSetAdminBytes());
    }
    function deployProxy(MCDevKit storage mc, string memory name, bytes memory initData) internal returns(MCDevKit storage) {
        return mc.deployProxy(name, mc.findCurrentDictionary(), initData);
    }
    function deployProxy(MCDevKit storage mc, bytes memory initData) internal returns(MCDevKit storage) {
        return mc.deployProxy(mc.proxy.proxies.genUniqueName(), mc.findCurrentDictionary(), initData);
    }
    function deployProxy(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return mc.deployProxy(mc.proxy.proxies.genUniqueName(), mc.findCurrentDictionary(), System.Config().defaultOwner().initSetAdminBytes());
    }


    /**-------------------------
        📚 Deploy Dictionary
    ---------------------------*/
    function deployDictionary(MCDevKit storage mc, string memory name, Bundle storage bundleInfo, address owner) internal returns(Dictionary memory) {
        uint pid = mc.startProcess("deployDictionary", Params.append(name, bundleInfo.name, owner));
        Dictionary memory dictionary = DictionaryLib.deploy(owner)
                                                    .set(bundleInfo)
                                                    .upgradeFacade(bundleInfo.facade);
        mc.dictionary.register(name, dictionary);
        return dictionary.finishProcess(pid);
    }

    function deployDictionary(MCDevKit storage mc) internal returns(Dictionary memory) {
        return mc.deployDictionary(mc.bundle.findCurrentName(), mc.bundle.findCurrent(), System.Config().defaultOwner());
    }
    function deployDictionary(MCDevKit storage mc, string memory name) internal returns(Dictionary memory) {
        return mc.deployDictionary(name, mc.bundle.findCurrent(), System.Config().defaultOwner());
    }
    function deployDictionary(MCDevKit storage mc, Bundle storage bundleInfo) internal returns(Dictionary memory) {
        return mc.deployDictionary(mc.bundle.findCurrentName(), bundleInfo, System.Config().defaultOwner());
    }
    function deployDictionary(MCDevKit storage mc, address owner) internal returns(Dictionary memory) {
        return mc.deployDictionary(mc.bundle.findCurrentName(), mc.bundle.findCurrent(), owner);
    }
    function deployDictionary(MCDevKit storage mc, string memory name, Bundle storage bundleInfo) internal returns(Dictionary memory) {
        return mc.deployDictionary(name, bundleInfo, System.Config().defaultOwner());
    }
    function deployDictionary(MCDevKit storage mc, string memory name, address owner) internal returns(Dictionary memory) {
        return mc.deployDictionary(name, mc.bundle.findCurrent(), owner);
    }
    function deployDictionary(MCDevKit storage mc, Bundle storage bundleInfo, address owner) internal returns(Dictionary memory) {
        return mc.deployDictionary(mc.bundle.findCurrentName(), bundleInfo, owner);
    }


    /**----------------------------
        🔂 Duplicate Dictionary
    ------------------------------*/
    function duplicateDictionary(MCDevKit storage mc, string memory name, Dictionary storage targetDictionary) internal returns(MCDevKit storage) {
        uint pid = mc.startProcess("duplicateDictionary", Params.append(name, targetDictionary.addr));
        Dictionary memory newDictionary = targetDictionary.duplicate();
        mc.dictionary.register(name, newDictionary);
        return mc.finishProcess(pid);
    }
    function duplicateDictionary(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        return mc.duplicateDictionary(name, mc.findCurrentDictionary());
    }
    function duplicateDictionary(MCDevKit storage mc, Dictionary storage targetDictionary) internal returns(MCDevKit storage) {
        return mc.duplicateDictionary(mc.dictionary.dictionaries.genUniqueDuplicatedName(), targetDictionary);
    }
    function duplicateDictionary(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return mc.duplicateDictionary(mc.dictionary.dictionaries.genUniqueDuplicatedName(), mc.findCurrentDictionary());
    }

}

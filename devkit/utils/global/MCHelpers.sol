// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {ProxyUtils} from "@ucs.mc/proxy/ProxyUtils.sol";

import {Logger} from "devkit/system/Logger.sol";

// Validation
import {Validator} from "devkit/system/Validator.sol";

import {MCDevKit} from "devkit/MCDevKit.sol";
import {System} from "devkit/system/System.sol";
// Utils
import {param} from "devkit/system/Tracer.sol";
import {ForgeHelper, vm} from "devkit/utils/ForgeHelper.sol";
// Core
//  functions
import {Bundle} from "devkit/core/Bundle.sol";
import {Function} from "devkit/core/Function.sol";
//  proxy
import {Proxy, ProxyLib} from "devkit/core/Proxy.sol";
//  dictionary
import {Dictionary, DictionaryLib} from "devkit/core/Dictionary.sol";

/******************************************
 *  🛠️ Helper
 *      ♻️ Reset Current Context
 *      🤲 Set Storage Reader
*******************************************/
library MCHelpers {

    /**-----------------------------
        ♻️ Reset Current Context
    -------------------------------*/
    function reset(MCDevKit storage mc) internal returns(MCDevKit storage) {
        uint pid = mc.startProcess("reset");
        mc.bundle.current.reset();
        mc.functions.current.reset();
        mc.dictionary.current.reset();
        mc.proxy.current.reset();
        return mc.finishProcess(pid);
    }


    /**--------------------------
        🤲 Set Storage Reader
    ----------------------------*/
    function setStorageReader(MCDevKit storage mc, Dictionary memory dictionary, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
        uint pid = mc.startProcess("setStorageReader", param(dictionary, selector, implementation));
        dictionary.set(selector, implementation);
        return mc.finishProcess(pid);
    }
    function setStorageReader(MCDevKit storage mc, string memory bundleName, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
        return mc.setStorageReader(mc.dictionary.find(bundleName), selector, implementation);
    }
    function setStorageReader(MCDevKit storage mc, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
        return mc.setStorageReader(mc.dictionary.findCurrent(), selector, implementation);
    }


    /// ForgeHelper Wrapper

    /**-------------------
        🔧 Env File
    ---------------------*/
    function loadPrivateKey(MCDevKit storage, string memory envKey) internal view returns(uint256) {
        return ForgeHelper.loadPrivateKey(envKey);
    }

    function loadAddressFromEnv(MCDevKit storage, string memory envKey) internal view returns(address) {
        return ForgeHelper.loadAddressFromEnv(envKey);
    }


    /**-------------------------
        📍 Address Operation
    ---------------------------*/
    function injectCode(MCDevKit storage, address target, bytes memory runtimeBytecode) internal {
        ForgeHelper.injectCode(target, runtimeBytecode);
    }

    function injectDictionary(MCDevKit storage, address proxy, address dictionary) internal {
        ForgeHelper.injectDictionary(proxy, dictionary);
    }

    function getAddress(MCDevKit storage, address target, bytes32 slot) internal view returns(address) {
        return ForgeHelper.getAddress(target, slot);
    }

    function getDictionaryAddress(MCDevKit storage, address proxy) internal view returns(address) {
        return ForgeHelper.getDictionaryAddress(proxy);
    }

    function assumeAddressIsNotReserved(MCDevKit storage, address addr) internal pure {
        ForgeHelper.assumeAddressIsNotReserved(addr);
    }


    /**----------------
        📓 Context
    ------------------*/
    function msgSender(MCDevKit storage) internal returns(address) {
        return ForgeHelper.msgSender();
    }


    /**---------------
        🏷️ Label
    -----------------*/
    function assignLabel(MCDevKit storage, address addr, string memory name) internal returns(address) {
        return ForgeHelper.assignLabel(addr, name);
    }

    function getLabel(MCDevKit storage, address addr) internal view returns(string memory) {
        return ForgeHelper.getLabel(addr);
    }


    /**------------------
        📡 Broadcast
    --------------------*/
    function pauseBroadcast(MCDevKit storage) internal {
        ForgeHelper.pauseBroadcast();
    }
    function resumeBroadcast(MCDevKit storage, bool isBroadcasting, address currentSender) internal {
        ForgeHelper.resumeBroadcast(isBroadcasting, currentSender);
    }


    /**----------------------
        🛠️ Forge Extender
    ------------------------*/
    function expectRevert(MCDevKit storage, string memory message) internal {
        vm.expectRevert(bytes(message));
    }
}

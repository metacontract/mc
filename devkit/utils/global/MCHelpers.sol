// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
// Validation
import {Validator} from "devkit/system/Validator.sol";

import {MCDevKit} from "devkit/MCDevKit.sol";
import {System} from "devkit/system/System.sol";
// Utils
import {param} from "devkit/system/Tracer.sol";
import {ForgeHelper} from "devkit/utils/ForgeHelper.sol";
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

}

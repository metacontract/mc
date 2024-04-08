// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Debug} from "devkit/debug/Debug.sol";
// Core Types
import {Function} from "devkit/core/Function.sol";
import {Bundle} from "devkit/core/Bundle.sol";
import {StdFunctions} from "devkit/core/StdFunctions.sol";
import {ProxyRegistry} from "devkit/core/ProxyRegistry.sol";
import {DictionaryRegistry} from "devkit/core/DictionaryRegistry.sol";

library ProcessLib {
    /**------------------
        🧩 Function
    --------------------*/
    function startProcess(Function storage, string memory name, string memory params) internal returns(uint) {
        return Debug.recordExecStart("FunctionLib", name, params);
    }
    function startProcess(Function storage func, string memory name) internal returns(uint) {
        return func.startProcess(name, "");
    }

    function finishProcess(Function storage func, uint pid) internal returns(Function storage) {
        Debug.recordExecFinish(pid);
        return func;
    }


    /**----------------
        🧺 Bundle
    ------------------*/
    function startProcess(Bundle storage, string memory name, string memory params) internal returns(uint) {
        return Debug.recordExecStart("Bundle", name, params);
    }
    function startProcess(Bundle storage bundle, string memory name) internal returns(uint) {
        return bundle.startProcess(name, "");
    }

    function finishProcess(Bundle storage bundle, uint pid) internal returns(Bundle storage) {
        Debug.recordExecFinish(pid);
        return bundle;
    }


    /**--------------------------
        🏛 Standard Functions
    ----------------------------*/
    function startProcess(StdFunctions storage, string memory name, string memory params) internal returns(uint) {
        return Debug.recordExecStart("StdFunctionsLib", name, params);
    }
    function startProcess(StdFunctions storage std, string memory name) internal returns(uint) {
        return std.startProcess(name, "");
    }

    function finishProcess(StdFunctions storage std, uint pid) internal returns(StdFunctions storage) {
        Debug.recordExecFinish(pid);
        return std;
    }


    /**----------------------
        🏠 Proxy Registry
    ------------------------*/
    function startProcess(ProxyRegistry storage, string memory name, string memory params) internal returns(uint) {
        return Debug.recordExecStart("ProxyRegistryLib", name, params);
    }
    function startProcess(ProxyRegistry storage proxies, string memory name) internal returns(uint) {
        return proxies.startProcess(name, "");
    }

    function finishProcess(ProxyRegistry storage proxies, uint pid) internal returns(ProxyRegistry storage) {
        Debug.recordExecFinish(pid);
        return proxies;
    }


    /**----------------------------
        📚 Dictionary Registry
    ------------------------------*/
    function startProcess(DictionaryRegistry storage, string memory name, string memory params) internal returns(uint) {
        return Debug.recordExecStart("DictionaryRegistryLib", name, params);
    }
    function startProcess(DictionaryRegistry storage dictionaries, string memory name) internal returns(uint) {
        return dictionaries.startProcess(name, "");
    }

    function finishProcess(DictionaryRegistry storage dictionaries, uint pid) internal returns(DictionaryRegistry storage) {
        Debug.recordExecFinish(pid);
        return dictionaries;
    }

}

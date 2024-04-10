// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Debug} from "devkit/debug/Debug.sol";
// Core Types
import {Function} from "devkit/core/types/Function.sol";
import {FunctionRegistry} from "devkit/core/registry/FunctionRegistry.sol";
import {Bundle} from "devkit/core/types/Bundle.sol";
import {BundleRegistry} from "devkit/core/registry/BundleRegistry.sol";
import {StdFunctions} from "devkit/core/registry/StdFunctions.sol";
import {Proxy} from "devkit/core/types/Proxy.sol";
import {ProxyRegistry} from "devkit/core/registry/ProxyRegistry.sol";
import {Dictionary} from "devkit/core/types/Dictionary.sol";
import {DictionaryRegistry} from "devkit/core/registry/DictionaryRegistry.sol";
import {MockRegistry} from "devkit/core/registry/MockRegistry.sol";


library ProcessLib {
    function finishProcess(uint pid) internal {
        Debug.recordExecFinish(pid);
    }


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

    /**--------------------------
        🧩 Functions Registry
    ----------------------------*/
    function startProcess(FunctionRegistry storage, string memory name, string memory params) internal returns(uint) {
        return Debug.recordExecStart("FunctionRegistry", name, params);
    }
    function startProcess(FunctionRegistry storage functions, string memory name) internal returns(uint) {
        return functions.startProcess(name, "");
    }

    function finishProcess(FunctionRegistry storage functions, uint pid) internal returns(FunctionRegistry storage) {
        Debug.recordExecFinish(pid);
        return functions;
    }


    /**----------------
        🗂️ Bundle
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
        🧩 Bundle Registry
    ----------------------------*/
    function startProcess(BundleRegistry storage, string memory name, string memory params) internal returns(uint) {
        return Debug.recordExecStart("BundleRegistry", name, params);
    }
    function startProcess(BundleRegistry storage bundle, string memory name) internal returns(uint) {
        return bundle.startProcess(name, "");
    }

    function finishProcess(BundleRegistry storage bundle, uint pid) internal returns(BundleRegistry storage) {
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


    /**---------------
        🏠 Proxy
    -----------------*/
    function startProxyLibProcess(string memory name, string memory params) internal returns(uint) {
        return Debug.recordExecStart("ProxyLib", name, params);
    }
    function startProxyLibProcess(string memory name) internal returns(uint) {
        return startProxyLibProcess(name, "");
    }

    function finishProcess(Proxy memory proxy, uint pid) internal returns(Proxy memory) {
        finishProcess(pid);
        return proxy;
    }
    function finishProcessInStorage(Proxy storage proxy, uint pid) internal returns(Proxy storage) {
        finishProcess(pid);
        return proxy;
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


    /**-------------------
        📚 Dictionary
    ---------------------*/
    function startDictionaryLibProcess(string memory name, string memory params) internal returns(uint) {
        return Debug.recordExecStart("DictionaryLib", name, params);
    }
    function startDictionaryLibProcess(string memory name) internal returns(uint) {
        return startDictionaryLibProcess(name, "");
    }

    function finishProcess(Dictionary memory dictionary, uint pid) internal returns(Dictionary memory) {
        finishProcess(pid);
        return dictionary;
    }
    function finishProcessInStorage(Dictionary storage dictionary, uint pid) internal returns(Dictionary storage) {
        finishProcess(pid);
        return dictionary;
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


    /**---------------------
        🏭 Mock Registry
    -----------------------*/
    function startProcess(MockRegistry storage, string memory name, string memory params) internal returns(uint) {
        return Debug.recordExecStart("MockRegistryLib", name, params);
    }
    function startProcess(MockRegistry storage mock, string memory name) internal returns(uint) {
        return mock.startProcess(name, "");
    }

    function finishProcess(MockRegistry storage mock, uint pid) internal returns(MockRegistry storage) {
        Debug.recordExecFinish(pid);
        return mock;
    }
}

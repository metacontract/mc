// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {DebuggerLib} from "devkit/system/debug/Debugger.sol";
// Core Types
import {Function} from "devkit/core/Function.sol";
import {FunctionRegistry} from "devkit/registry/FunctionRegistry.sol";
import {Bundle} from "devkit/core/Bundle.sol";
import {BundleRegistry} from "devkit/registry/BundleRegistry.sol";
import {StdRegistry} from "devkit/registry/StdRegistry.sol";
import {StdFunctions} from "devkit/registry/StdFunctions.sol";
import {Proxy} from "devkit/core/Proxy.sol";
import {ProxyRegistry} from "devkit/registry/ProxyRegistry.sol";
import {Dictionary} from "devkit/core/Dictionary.sol";
import {DictionaryRegistry} from "devkit/registry/DictionaryRegistry.sol";
import {Current} from "devkit/registry/context/Current.sol";


/**=================
    ⛓️ Process
===================*/
library ProcessLib {
    function finishProcess(uint pid) internal {
        DebuggerLib.recordExecFinish(pid);
    }


    /**------------------
        🧩 Function
    --------------------*/
    function startProcess(Function storage, string memory name, string memory params) internal returns(uint) {
        return DebuggerLib.recordExecStart("FunctionLib", name, params);
    }
    function startProcess(Function storage func, string memory name) internal returns(uint) {
        return func.startProcess(name, "");
    }

    function finishProcess(Function storage func, uint pid) internal returns(Function storage) {
        DebuggerLib.recordExecFinish(pid);
        return func;
    }

    /**--------------------------
        🧩 Functions Registry
    ----------------------------*/
    function startProcess(FunctionRegistry storage, string memory name, string memory params) internal returns(uint) {
        return DebuggerLib.recordExecStart("FunctionRegistry", name, params);
    }
    function startProcess(FunctionRegistry storage functions, string memory name) internal returns(uint) {
        return functions.startProcess(name, "");
    }

    function finishProcess(FunctionRegistry storage functions, uint pid) internal returns(FunctionRegistry storage) {
        DebuggerLib.recordExecFinish(pid);
        return functions;
    }


    /**----------------
        🗂️ Bundle
    ------------------*/
    function startProcess(Bundle storage, string memory name, string memory params) internal returns(uint) {
        return DebuggerLib.recordExecStart("Bundle", name, params);
    }
    function startProcess(Bundle storage bundle, string memory name) internal returns(uint) {
        return bundle.startProcess(name, "");
    }

    function finishProcess(Bundle storage bundle, uint pid) internal returns(Bundle storage) {
        DebuggerLib.recordExecFinish(pid);
        return bundle;
    }

    /**--------------------------
        🧩 Bundle Registry
    ----------------------------*/
    function startProcess(BundleRegistry storage, string memory name, string memory params) internal returns(uint) {
        return DebuggerLib.recordExecStart("BundleRegistry", name, params);
    }
    function startProcess(BundleRegistry storage bundle, string memory name) internal returns(uint) {
        return bundle.startProcess(name, "");
    }

    function finishProcess(BundleRegistry storage bundle, uint pid) internal returns(BundleRegistry storage) {
        DebuggerLib.recordExecFinish(pid);
        return bundle;
    }


    /**-------------------------
        🏛 Standard Registry
    ---------------------------*/
    function startProcess(StdRegistry storage, string memory name, string memory params) internal returns(uint) {
        return DebuggerLib.recordExecStart("StdRegistryLib", name, params);
    }
    function startProcess(StdRegistry storage std, string memory name) internal returns(uint) {
        return std.startProcess(name, "");
    }

    function finishProcess(StdRegistry storage std, uint pid) internal returns(StdRegistry storage) {
        DebuggerLib.recordExecFinish(pid);
        return std;
    }


    /**--------------------------
        🏰 Standard Functions
    ----------------------------*/
    function startProcess(StdFunctions storage, string memory name, string memory params) internal returns(uint) {
        return DebuggerLib.recordExecStart("StdFunctionsLib", name, params);
    }
    function startProcess(StdFunctions storage std, string memory name) internal returns(uint) {
        return std.startProcess(name, "");
    }

    function finishProcess(StdFunctions storage std, uint pid) internal returns(StdFunctions storage) {
        DebuggerLib.recordExecFinish(pid);
        return std;
    }


    /**---------------
        🏠 Proxy
    -----------------*/
    function startProxyLibProcess(string memory name, string memory params) internal returns(uint) {
        return DebuggerLib.recordExecStart("ProxyLib", name, params);
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
        return DebuggerLib.recordExecStart("ProxyRegistryLib", name, params);
    }
    function startProcess(ProxyRegistry storage proxies, string memory name) internal returns(uint) {
        return proxies.startProcess(name, "");
    }

    function finishProcess(ProxyRegistry storage proxies, uint pid) internal returns(ProxyRegistry storage) {
        DebuggerLib.recordExecFinish(pid);
        return proxies;
    }


    /**-------------------
        📚 Dictionary
    ---------------------*/
    function startDictionaryLibProcess(string memory name, string memory params) internal returns(uint) {
        return DebuggerLib.recordExecStart("DictionaryLib", name, params);
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
        return DebuggerLib.recordExecStart("DictionaryRegistryLib", name, params);
    }
    function startProcess(DictionaryRegistry storage dictionaries, string memory name) internal returns(uint) {
        return dictionaries.startProcess(name, "");
    }

    function finishProcess(DictionaryRegistry storage dictionaries, uint pid) internal returns(DictionaryRegistry storage) {
        DebuggerLib.recordExecFinish(pid);
        return dictionaries;
    }


    /**------------------------
        📸 Current Context
    --------------------------*/
    function startProcess(Current storage, string memory name, string memory params) internal returns(uint) {
        return DebuggerLib.recordExecStart("CurrentLib", name, params);
    }
    function startProcess(Current storage current, string memory name) internal returns(uint) {
        return current.startProcess(name, "");
    }

}

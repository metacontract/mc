// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {System} from "devkit/system/System.sol";
import {Debugger, DebuggerLib} from "devkit/system/debug/Debugger.sol";
import {Logger} from "devkit/system/debug/Logger.sol";
import {Inspector} from "devkit/types/Inspector.sol";
    using Inspector for bool;
import {Formatter} from "devkit/types/Formatter.sol";
    using Formatter for Process global;
    using Formatter for bytes4;
    using Formatter for address;
    using Formatter for string;
// Core Types
import {MCDevKit} from "devkit/MCDevKit.sol";
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
struct Process {
    string libName;
    string funcName;
    string params;
    uint nest;
    // bool isFinished; TODO
}
library ProcessManager {
    /**----------------------------
        📈 Execution Tracking
    ------------------------------*/
    function start(string memory libName, string memory funcName, string memory params) internal returns(uint pid) {
        if (System.Config().DEBUG.RECORD_EXECUTION_PROCESS.isFalse()) return 0;
        Debugger storage debugger = System.Debug();
        pid = debugger.nextPid;
        Process memory process = Process(libName, funcName, params, debugger.currentNest);
        debugger.processStack.push(process);
        debugger.currentNest++;
        Logger.logInfo(process.toStart(pid));
        debugger.nextPid++;
    }

    function finish(uint pid) internal {
        if (System.Config().DEBUG.RECORD_EXECUTION_PROCESS.isFalse()) return;
        Debugger storage debugger = System.Debug();
        Process memory process = debugger.processStack[pid];
        Logger.logInfo(process.toFinish(pid));
        debugger.currentNest--;
    }


    /**-----------
        🌞 mc
    -------------*/
    function startProcess(MCDevKit storage, string memory name, string memory params) internal returns(uint) {
        return start("mc", name, params);
    }
    function startProcess(MCDevKit storage mc, string memory name) internal returns(uint) {
        return startProcess(mc, name, "");
    }
    function finishProcess(MCDevKit storage mc, uint pid) internal returns(MCDevKit storage) {
        finish(pid);
        return mc;
    }

    // String
    function finishProcess(string memory str, uint pid) internal returns(string memory) {
        finish(pid);
        return str;
    }

    /**------------------
        🧩 Function
    --------------------*/
    function startProcess(Function storage, string memory name, string memory params) internal returns(uint) {
        return start("Function", name, params);
    }
    function startProcess(Function storage func, string memory name) internal returns(uint) {
        return startProcess(func, name, "");
    }
    function finishProcess(Function storage func, uint pid) internal returns(Function storage) {
        finish(pid);
        return func;
    }

    /**--------------------------
        🧩 Functions Registry
    ----------------------------*/
    function startProcess(FunctionRegistry storage, string memory name, string memory params) internal returns(uint) {
        return start("FunctionRegistry", name, params);
    }
    function startProcess(FunctionRegistry storage functions, string memory name) internal returns(uint) {
        return functions.startProcess(name, "");
    }

    function finishProcess(FunctionRegistry storage functions, uint pid) internal returns(FunctionRegistry storage) {
        finish(pid);
        return functions;
    }


    /**----------------
        🗂️ Bundle
    ------------------*/
    function startProcess(Bundle storage, string memory name, string memory params) internal returns(uint) {
        return start("Bundle", name, params);
    }
    function startProcess(Bundle storage bundle, string memory name) internal returns(uint) {
        return bundle.startProcess(name, "");
    }

    function finishProcess(Bundle storage bundle, uint pid) internal returns(Bundle storage) {
        finish(pid);
        return bundle;
    }

    /**--------------------------
        🧩 Bundle Registry
    ----------------------------*/
    function startProcess(BundleRegistry storage, string memory name, string memory params) internal returns(uint) {
        return start("BundleRegistry", name, params);
    }
    function startProcess(BundleRegistry storage bundle, string memory name) internal returns(uint) {
        return bundle.startProcess(name, "");
    }

    function finishProcess(BundleRegistry storage bundle, uint pid) internal returns(BundleRegistry storage) {
        finish(pid);
        return bundle;
    }


    /**-------------------------
        🏛 Standard Registry
    ---------------------------*/
    function startProcess(StdRegistry storage, string memory name, string memory params) internal returns(uint) {
        return start("StdRegistryLib", name, params);
    }
    function startProcess(StdRegistry storage std, string memory name) internal returns(uint) {
        return std.startProcess(name, "");
    }

    function finishProcess(StdRegistry storage std, uint pid) internal returns(StdRegistry storage) {
        finish(pid);
        return std;
    }


    /**--------------------------
        🏰 Standard Functions
    ----------------------------*/
    function startProcess(StdFunctions storage, string memory name, string memory params) internal returns(uint) {
        return start("StdFunctionsLib", name, params);
    }
    function startProcess(StdFunctions storage std, string memory name) internal returns(uint) {
        return std.startProcess(name, "");
    }

    function finishProcess(StdFunctions storage std, uint pid) internal returns(StdFunctions storage) {
        finish(pid);
        return std;
    }


    /**---------------
        🏠 Proxy
    -----------------*/
    function startProcess(Proxy memory, string memory name, string memory params) internal returns(uint) {
        return start("Proxy", name, params);
    }
    function startProcess(Proxy memory, string memory name) internal returns(uint) {
        return start("Proxy", name, "");
    }

    function finishProcess(Proxy memory proxy, uint pid) internal returns(Proxy memory) {
        finish(pid);
        return proxy;
    }
    function finishProcessInStorage(Proxy storage proxy, uint pid) internal returns(Proxy storage) {
        finish(pid);
        return proxy;
    }

    /**----------------------
        🏠 Proxy Registry
    ------------------------*/
    function startProcess(ProxyRegistry storage, string memory name, string memory params) internal returns(uint) {
        return start("ProxyRegistryLib", name, params);
    }
    function startProcess(ProxyRegistry storage proxies, string memory name) internal returns(uint) {
        return proxies.startProcess(name, "");
    }

    function finishProcess(ProxyRegistry storage proxies, uint pid) internal returns(ProxyRegistry storage) {
        finish(pid);
        return proxies;
    }


    /**-------------------
        📚 Dictionary
    ---------------------*/
    function startProcess(Dictionary memory, string memory name, string memory params) internal returns(uint) {
        return start("Dictionary", name, params);
    }
    function startProcess(Dictionary memory, string memory name) internal returns(uint) {
        return start("Dictionary", name, "");
    }
    function finishProcess(Dictionary memory dictionary, uint pid) internal returns(Dictionary memory) {
        finish(pid);
        return dictionary;
    }
    function finishProcessInStorage(Dictionary storage dictionary, uint pid) internal returns(Dictionary storage) {
        finish(pid);
        return dictionary;
    }

    /**----------------------------
        📚 Dictionary Registry
    ------------------------------*/
    function startProcess(DictionaryRegistry storage, string memory name, string memory params) internal returns(uint) {
        return start("DictionaryRegistryLib", name, params);
    }
    function startProcess(DictionaryRegistry storage dictionaries, string memory name) internal returns(uint) {
        return dictionaries.startProcess(name, "");
    }

    function finishProcess(DictionaryRegistry storage dictionaries, uint pid) internal returns(DictionaryRegistry storage) {
        finish(pid);
        return dictionaries;
    }


    /**------------------------
        📸 Current Context
    --------------------------*/
    function startProcess(Current storage, string memory name, string memory params) internal returns(uint) {
        return start("Current", name, params);
    }
    function startProcess(Current storage current, string memory name) internal returns(uint) {
        return current.startProcess(name, "");
    }
    function finishProcess(Current storage current, uint pid) internal {
        finish(pid);
    }
}

/**
    Params
 */
 /* solhint-disable 2519 */
function param(string memory str) returns(string memory) {
    return str;
}
function param(string memory str, address addr, Function[] memory funcs) returns(string memory) {
    return str.comma(addr).comma(param(funcs));
}
function param(string memory str, bytes4 b4, address addr) returns(string memory) {
    return str.comma(b4).comma(addr);
}
function param(string memory str, Proxy memory proxy) returns(string memory) {
    return str.comma(proxy.addr);
}
function param(string memory str, Dictionary memory dictionary) returns(string memory) {
    return str.comma(dictionary.addr);
}
function param(string memory str, Dictionary memory dictionary, bytes memory b) returns(string memory) {
    return str.comma(dictionary.addr).comma(string(b));
}
function param(string memory str, Function[] memory funcs) returns(string memory) {
    return str.comma(param(funcs));
}
function param(string memory str, Bundle memory bundle, address addr) returns(string memory) {
    return str.comma(bundle.name).comma(addr);
}
function param(string memory str, Bundle memory bundle, address addr, bytes memory b) returns(string memory) {
    return str.comma(bundle.name).comma(addr).comma(string(b));
}

function param(bytes4 b4) returns(string memory) {
    return b4.toString();
}
function param(bytes4 b4, address addr) returns(string memory) {
    return b4.toString().comma(addr);
}

function param(address addr) returns(string memory) {
    return addr.toString();
}
function param(address addr, address addr2) returns(string memory) {
    return addr.toString().comma(addr2);
}
function param(address addr, string memory str) returns(string memory) {
    return addr.toString().comma(str);
}

function param(Dictionary memory dict, address addr) returns(string memory) {
    return param(dict.addr, addr);
}
function param(Dictionary memory dict, bytes4 b4, address addr) returns(string memory) {
    return param(dict.addr).comma(b4).comma(addr);
}
function param(Dictionary memory dict, bytes memory b) returns(string memory) {
    return param(dict.addr, string(b));
}
function param(Dictionary memory dict1, Dictionary memory dict2) returns(string memory) {
    return param(dict1.addr, dict2.addr);
}

function param(Function memory func) returns(string memory) {
    return func.name;
}
function param(Function[] memory functions) returns(string memory res) {
    for (uint i; i < functions.length; ++i) {
        res = res.comma(functions[i].name);
    }
}

function param(Bundle memory bundle) returns(string memory) {
    return bundle.name;
}

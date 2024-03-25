// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Global Methods
import "@devkit/utils/GlobalMethods.sol";
// Utils
import {ForgeHelper} from "@devkit/utils/ForgeHelper.sol";
import {AddressUtils} from "@devkit/utils/AddressUtils.sol";
    using AddressUtils for address;
import {BoolUtils} from "@devkit/utils/BoolUtils.sol";
    using BoolUtils for bool;
import {Bytes4Utils} from "@devkit/utils/Bytes4Utils.sol";
    using Bytes4Utils for bytes4;
import {StringUtils} from "@devkit/utils/StringUtils.sol";
    using StringUtils for string;
// Debug
import {Debug} from "@devkit/debug/Debug.sol";
import {Logger} from "@devkit/debug/Logger.sol";
// Core
//  dictionary
import {DictRegistry} from "@devkit/core/dictionary/DictRegistry.sol";
import {Dictionary, DictionaryUtils} from "@devkit/core/dictionary/Dictionary.sol";
//  functions
import {FuncRegistry} from "@devkit/core/functions/FuncRegistry.sol";
import {BundleInfo} from "@devkit/core/functions/BundleInfo.sol";
import {FuncInfo} from "@devkit/core/functions/FuncInfo.sol";
import {MCStdFuncsArgs} from "@devkit/core/functions/MCStdFuncs.sol";
    using MCStdFuncsArgs for address;
//  proxy
import {ProxyRegistry} from "@devkit/core/proxy/ProxyRegistry.sol";
import {Proxy, ProxyUtils} from "@devkit/core/proxy/Proxy.sol";


/********************************
    🌟 Meta Contract DevKit
*********************************/
using MCDevKitUtils for MCDevKit global;
struct MCDevKit {
    FuncRegistry functions;
    DictRegistry dictionary;
    ProxyRegistry proxy;
}

library MCDevKitUtils {
    string constant LIB_NAME = "MCDevKit";
    function recordExecStart(MCDevKit storage, string memory funcName, string memory params) internal returns(uint) {
        return Debug.recordExecStart(LIB_NAME, funcName, params);
    }
    function recordExecStart(MCDevKit storage mc, string memory funcName) internal returns(uint) {
        return mc.recordExecStart(funcName, "");
    }
    function recordExecFinish(MCDevKit storage mc, uint pid) internal returns(MCDevKit storage) {
        Debug.recordExecFinish(pid);
        return mc;
    }

    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        🏗 Setup DevKit Environment
        🌱 Init Custom Bundle
        🔗 Use Function
            ✨ Add Custom Function
            🧺 Add Custom Function to Bundle
        🚀 Deploy Meta Contract
        🧩 Functions
        📚 Dictionary
        🏠 Proxy
        🧪 Test
        🎭 Context
        📝 Settings
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/


    /**--------------------------------
        🏗 Setup DevKit Environment
    ----------------------------------*/
    function setupMCStdFuncs(MCDevKit storage mc) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("setupMCStdFuncs");
        mc.functions.std.assignAndLoad()
                        .deployIfNotExists()
                        .configureStdBundle();
        return mc.recordExecFinish(pid);
    }


    /*****************************
        🌱 Init Custom Bundle
    ******************************/
    function init(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("init", PARAMS.append(name));
        mc.functions.safeInit(name);
        return mc.recordExecFinish(pid);
    }
    function init(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return mc.init(mc.defaultBundleName());
    }

    //
    function ensureInit(MCDevKit storage mc) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("ensureInit");
        if (mc.functions.findCurrentBundle().hasNotName()) mc.init();
        return mc.recordExecFinish(pid);
    }


    /***********************
        🔗 Use Function
    ************************/
    function use(MCDevKit storage mc, string memory name, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("use", PARAMS.append(name).comma().append(selector).comma().append(implementation));
        return mc   .ensureInit()
                    .addFunction(name, selector, implementation)
                    .addCurrentToBundle()
                    .recordExecFinish(pid);
    }
    function use(MCDevKit storage mc, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
        return mc.use(implementation.getLabel(), selector, implementation);
    }
    function use(MCDevKit storage mc, FuncInfo storage functionInfo) internal returns(MCDevKit storage) {
        return mc.use(functionInfo.name, functionInfo.selector, functionInfo.implementation);
    }
    // function use(MCDevKit storage mc, BundleInfo storage bundleInfo) internal returns(MCDevKit storage) {
    //     return mc;
    // } TODO
    function use(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        check(mc.functions.findFunction(name).isComplete(), "Invalid Function Name");
        return mc.use(mc.findFunction(name));
    }
        /**---------------------------
            ✨ Add Custom Function
        -----------------------------*/
        function addFunction(MCDevKit storage mc, string memory name, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
            uint pid = mc.recordExecStart("addFunction");
            mc.functions.safeAddFunction(name, selector, implementation);
            return mc.recordExecFinish(pid);
        }
        /**-------------------------------------
            🧺 Add Custom Function to Bundle
        ---------------------------------------*/
        function addToBundle(MCDevKit storage mc, FuncInfo storage functionInfo) internal returns(MCDevKit storage) {
            uint pid = mc.recordExecStart("addToBundle");
            mc.functions.addToBundle(functionInfo);
            return mc.recordExecFinish(pid);
        }
        function addCurrentToBundle(MCDevKit storage mc) internal returns(MCDevKit storage) {
            mc.functions.addToBundle(mc.findCurrentFunction());
            return mc;
        }


    /********************
        🖼 Set Facade
    *********************/
    function set(MCDevKit storage mc, string memory name, address facade) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("set");
        mc.functions.set(name, facade);
            return mc.recordExecFinish(pid);
    }
    function set(MCDevKit storage mc, address facade) internal returns(MCDevKit storage) {
        return mc.set(mc.functions.findCurrentBundleName(), facade);
    }


    /******************************
        🚀 Deploy Meta Contract
    *******************************/
    function deploy(MCDevKit storage mc, string memory name, BundleInfo storage bundleInfo, bytes memory initData) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("deploy", PARAMS.append(name).comma().append(bundleInfo.name).comma().append(string(initData)));
        return mc   .deployDictionary(name.append("_Dictionary"))
                    .set(bundleInfo)
                    .deployProxy(name.append("_Proxy"), initData)
                    .recordExecFinish(pid);
        // TODO gen and set facade
    }
    function deploy(MCDevKit storage mc, string memory name, BundleInfo storage bundleInfo) internal returns(MCDevKit storage) {
        return mc.deploy(name, bundleInfo, mc.defaultInitData());
    }
    function deploy(MCDevKit storage mc, BundleInfo storage bundleInfo) internal returns(MCDevKit storage) {
        return mc.deploy(mc.defaultName(), bundleInfo, mc.defaultInitData());
    }
    function deploy(MCDevKit storage mc, string memory name, bytes memory initData) internal returns(MCDevKit storage) {
        return mc.deploy(name, mc.functions.findBundle(name), initData);
    }
    function deploy(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        return mc.deploy(name, mc.functions.findBundle(name), mc.defaultInitData());
    }
    function deploy(MCDevKit storage mc, bytes memory initData) internal returns(MCDevKit storage) {
        return mc.deploy(mc.defaultName(), mc.functions.findCurrentBundle(), initData);
    }
    function deploy(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return mc.deploy(mc.defaultName(), mc.functions.findCurrentBundle(), mc.defaultInitData());
    }



/************************************************
    📚 Dictionary Global Utils
        🐣 Deploy Dictionary
        🔂 Duplicate Dictionary
        🧩 Set Function
        🖼 Upgrade Facade
        🔧 Helper Methods for type Dictionary
*************************************************/
    /**-------------------------
        🐣 Deploy Dictionary
    ---------------------------*/
    function deployDictionary(MCDevKit storage mc, string memory name, address owner) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("deployDictionary", PARAMS.append(name).comma().append(owner));
        Dictionary memory dictionary = DictionaryUtils.deploy(owner);
        mc.dictionary   .safeAdd(name, dictionary)
                        .safeUpdate(dictionary);
        return mc.recordExecFinish(pid);
    }
    function deployDictionary(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        return mc.deployDictionary(name, mc.defaultOwner());
    }
    function deployDictionary(MCDevKit storage mc, address owner) internal returns(MCDevKit storage) {
        return mc.deployDictionary(mc.defaultDictionaryName(), owner);
    }
    function deployDictionary(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return mc.deployDictionary(mc.defaultDictionaryName(), mc.defaultOwner());
    }


    /**----------------------------
        🔂 Duplicate Dictionary
    ------------------------------*/
    function duplicateDictionary(MCDevKit storage mc, string memory name, Dictionary storage targetDictionary) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("duplicateDictionary", PARAMS.append(name).comma().append(targetDictionary.addr));
        Dictionary memory newDictionary = targetDictionary.duplicate();
        mc.dictionary   .safeAdd(name, newDictionary)
                        .safeUpdate(newDictionary);
        return mc.recordExecFinish(pid);
    }
    function duplicateDictionary(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        return mc.duplicateDictionary(name, mc.findCurrentDictionary());
    }
    function duplicateDictionary(MCDevKit storage mc, Dictionary storage targetDictionary) internal returns(MCDevKit storage) {
        return mc.duplicateDictionary(mc.defaultDuplicatedDictionaryName(), targetDictionary);
    }
    function duplicateDictionary(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return mc.duplicateDictionary(mc.defaultDuplicatedDictionaryName(), mc.findCurrentDictionary());
    }


    /**---------------------
        🧩 Set Function
    -----------------------*/
    function set(MCDevKit storage mc, FuncInfo memory functionInfo) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("set", PARAMS.append(functionInfo.name));
        mc.findCurrentDictionary().set(functionInfo);
        return mc.recordExecFinish(pid);
    }


    /**------------------
        🧺 Set Bundle
    --------------------*/
    function set(MCDevKit storage mc, BundleInfo storage bundleInfo) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("set", PARAMS.append(bundleInfo.name));
        mc.findCurrentDictionary().set(bundleInfo);
        return mc.recordExecFinish(pid);
    }


    /**----------------------
        🖼 Upgrade Facade
    ------------------------*/
    function upgradeFacade(MCDevKit storage mc, address newFacade) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("upgradeFacade", PARAMS.append(newFacade));
        mc.findCurrentDictionary().upgradeFacade(newFacade);
        return mc.recordExecFinish(pid);
    }



/********************************************
    🏠 Proxy Global Utils
        🐣 Deploy Proxy
        🔧 Helper Methods for type Proxy
*********************************************/
    /**---------------------
        🐣 Deploy Proxy
    -----------------------*/
    function deployProxy(MCDevKit storage mc, string memory name, Dictionary storage dictionary, bytes memory initData) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("deployProxy", PARAMS.append(dictionary.addr).comma().append(string(initData)));
        Proxy memory proxy = ProxyUtils.deploy(dictionary, initData);
        mc.proxy.safeAdd(name, proxy)
                .safeUpdate(proxy);
        return mc.recordExecFinish(pid);
    }
    function deployProxy(MCDevKit storage mc, string memory name, Dictionary storage dictionary, address owner) internal returns(MCDevKit storage) {
        return mc.deployProxy(name, dictionary, owner.initSetAdminBytes());
    }
    function deployProxy(MCDevKit storage mc, string memory name, Dictionary storage dictionary) internal returns(MCDevKit storage) {
        return mc.deployProxy(name, dictionary, mc.defaultOwner().initSetAdminBytes());
    }
    function deployProxy(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        return mc.deployProxy(name, mc.findCurrentDictionary(), mc.defaultOwner().initSetAdminBytes());
    }
    function deployProxy(MCDevKit storage mc, string memory name, bytes memory initData) internal returns(MCDevKit storage) {
        return mc.deployProxy(name, mc.findCurrentDictionary(), initData);
    }
    function deployProxy(MCDevKit storage mc, bytes memory initData) internal returns(MCDevKit storage) {
        return mc.deployProxy(mc.defaultProxyName(), mc.findCurrentDictionary(), initData);
    }
    function deployProxy(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return mc.deployProxy(mc.defaultProxyName(), mc.findCurrentDictionary(), mc.defaultOwner().initSetAdminBytes());
    }



/******************************************
    🧪 Test Global Utils
        🏠 Mocking Proxy
        📚 Mocking Dictionary
*******************************************/
    /**---------------------
        🏠 Mocking Proxy
    -----------------------*/
    /**
        @notice Creates a SimpleMockProxy as a MockProxy
        @param name The name of the MockProxy, used as a key in the `mc.test.mockProxies` mapping and as a label name in the Forge test runner. If not provided, sequential default names from `MockProxy0` to `MockProxy4` will be used.
        @param functionInfos The function contract infos to be registered with the SimpleMockProxy. A bundle can also be specified. Note that the SimpleMockProxy cannot have its functions changed later. If no functions are provided, defaultBundle will be used.
    */
    function createSimpleMockProxy(MCDevKit storage mc, string memory name, FuncInfo[] memory functionInfos) internal returns(MCDevKit storage) {
        string memory params = PARAMS.append(name);
        for (uint i; i < functionInfos.length; ++i) {
            params = params.comma().append(functionInfos[i].name);
        }
        uint pid = mc.recordExecStart("createSimpleMockProxy", params);
        Proxy memory simpleMockProxy = ProxyUtils.createSimpleMockProxy(functionInfos);
        mc.proxy.safeAdd(name, simpleMockProxy)
                .safeUpdate(simpleMockProxy);
        return mc.recordExecFinish(pid);
    }
    function createSimpleMockProxy(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        return mc.createSimpleMockProxy(name, mc.defaultFunctionInfos());
    }
    function createSimpleMockProxy(MCDevKit storage mc, FuncInfo[] memory functionInfos) internal returns(MCDevKit storage) {
        return mc.createSimpleMockProxy(mc.defaultMockProxyName(), functionInfos);
    }
    function createSimpleMockProxy(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return mc.createSimpleMockProxy(mc.defaultMockProxyName(), mc.defaultFunctionInfos());
    }


    /**-------------------------
        📚 Mocking Dictionary
    ---------------------------*/
    /**
        @notice Creates a DictionaryEtherscan as a MockDictionary.
        @param name The name of the `MockDictionary`, used as a key in the `mc.test.mockDictionaries` mapping and as a label name in the Forge test runner. If not provided, sequential default names from `MockDictionary0` to `MockDictionary4` will be used.
        @param owner The address to be set as the owner of the DictionaryEtherscan contract. If not provided, the DefaultOwner from the UCS environment settings is used.
        @param functionInfos The Functions to be registered with the `MockDictionary`. A bundle can also be specified. If no Ops are provided, defaultBundle will be used.
    */
    function createMockDictionary(MCDevKit storage mc, string memory name, address owner, FuncInfo[] memory functionInfos) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("createMockDictionary", PARAMS.append(name).comma().append(owner));
        Dictionary memory mockDictionary = DictionaryUtils.createMockDictionary(owner, functionInfos);
        mc.dictionary   .safeAdd(name, mockDictionary)
                        .safeUpdate(mockDictionary);
        return mc.recordExecFinish(pid);
    }
    function createMockDictionary(MCDevKit storage mc, string memory name, address owner) internal returns(MCDevKit storage) {
        return mc.createMockDictionary(name, owner, mc.defaultFunctionInfos());
    }
    function createMockDictionary(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        return mc.createMockDictionary(name, mc.defaultOwner(), mc.defaultFunctionInfos());
    }
    function createMockDictionary(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return mc.createMockDictionary(mc.defaultMockDictionaryName(), mc.defaultOwner(), mc.defaultFunctionInfos());
    }


    /**--------------------------
        🤲 Set Storage Getter
    ----------------------------*/
    function setStorageGetter(MCDevKit storage mc, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("setStorageGetter", PARAMS.append(selector).comma().append(implementation));
        return mc.set(FuncInfo({
            name: "StorageGetter",
            selector: selector,
            implementation: implementation
        })).recordExecFinish(pid);
    }



    /**----------------------
        🔼 Update Context
    ------------------------*/
    function updateCurrentBundle(MCDevKit storage mc, string memory bundleName) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("updateCurrentBundle", PARAMS.append(bundleName));
        mc.functions.safeUpdateCurrentBundle(bundleName);
        return mc.recordExecFinish(pid);
    }
    function updateCurrentFunction(MCDevKit storage mc, string memory functionName) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("updateCurrentFunction", PARAMS.append(functionName));
        mc.functions.safeUpdateCurrentFunction(functionName);
        return mc.recordExecFinish(pid);
    }
    function updateCurrent(MCDevKit storage mc, Proxy storage proxy) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("updateCurrent", PARAMS.append(proxy.addr));
        mc.proxy.safeUpdate(proxy);
        return mc.recordExecFinish(pid);
    }
    function updateCurrent(MCDevKit storage mc, Dictionary storage dictionary) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("updateCurrent", PARAMS.append(dictionary.addr));
        mc.dictionary.safeUpdate(dictionary);
        return mc.recordExecFinish(pid);
    }



    /*************************
        🕵️ Getter Methods
    **************************/
    /**----- 🧺 Bundle -------*/
    // function findCurrentBundle(MCDevKit storage mc) internal returns(BundleInfo storage) {
    //     uint pid = mc.recordExecStart("findCurrentBundle");
    //     return mc.functions.findCurrentBundle();
    // }
    function findBundle(MCDevKit storage mc, string memory name) internal returns(BundleInfo storage) {
        return mc.functions.findBundle(name);
    }

    /**----- 🧩 Function -------*/
    function findCurrentFunction(MCDevKit storage mc) internal returns(FuncInfo storage) {
        uint pid = mc.recordExecStart("findCurrentFunction", "");
        return mc.functions.findCurrentFunction();
    }
    function findFunction(MCDevKit storage mc, string memory name) internal returns(FuncInfo storage) {
        uint pid = mc.recordExecStart("findFunction");
        return mc.functions.findFunction(name);
    }

    /**----- 🏠 Proxy -------*/
    function findCurrentProxy(MCDevKit storage mc) internal returns(Proxy storage) {
        return mc.proxy.findCurrentProxy();
    }
    function findProxy(MCDevKit storage mc, string memory name) internal returns(Proxy storage) {
        return mc.proxy.find(name);
    }
    // function findMockProxy(MCDevKit storage mc, string memory name) internal returns(MockProxy) {
    //     return mc.test.findMockProxy(name);
    // }

    /**----- 📚 Dictionary -------*/
    function findCurrentDictionary(MCDevKit storage mc) internal returns(Dictionary storage) {
        return mc.dictionary.findCurrentDictionary();
    }
    function findDictionary(MCDevKit storage mc, string memory name) internal returns(Dictionary storage) {
        return mc.dictionary.find(name);
    }
    function findMockDictionary(MCDevKit storage mc, string memory name) internal returns(Dictionary storage) {
        return mc.dictionary.findMockDictionary(name);
    }

    function getDictionaryAddress(MCDevKit storage mc) internal returns(address) {
        return mc.findCurrentDictionary().addr;
    }


/*******************************************************
    📝 Settings
        logging
        provide the Default Values of the UCS DevEnv
********************************************************/
    function startDebug(MCDevKit storage mc) internal returns(MCDevKit storage) {
        Debug.startDebug();
        return mc;
    }
    function stopLog(MCDevKit storage mc) internal returns(MCDevKit storage) {
        Debug.stopLog();
        return mc;
    }
    function insert(MCDevKit storage mc, string memory message) internal returns(MCDevKit storage) {
        Logger.insert(message);
        return mc;
    }

    function defaultOwner(MCDevKit storage) internal returns(address) {
        return ForgeHelper.msgSender();
    }

    function defaultName(MCDevKit storage) internal pure returns(string memory) {
        return "ProjectName"; // TODO
    }

    function defaultProxyName(MCDevKit storage mc) internal returns(string memory) {
        return mc.proxy.genUniqueName();
    }
    function defaultMockProxyName(MCDevKit storage mc) internal returns(string memory) {
        return mc.proxy.genUniqueMockName();
    }

    function defaultDictionaryName(MCDevKit storage mc) internal returns(string memory) {
        return mc.dictionary.genUniqueName();
    }
    function defaultDuplicatedDictionaryName(MCDevKit storage mc) internal returns(string memory) {
        return mc.dictionary.genUniqueDuplicatedName();
    }
    function defaultMockDictionaryName(MCDevKit storage mc) internal returns(string memory) {
        return mc.dictionary.genUniqueMockName();
    }

    function defaultFunctionInfos(MCDevKit storage mc) internal returns(FuncInfo[] storage) {
        return mc.functions.std.allFunctions.functionInfos;
    }
    function defaultBundleName(MCDevKit storage mc) internal returns(string memory) {
        return mc.functions.genUniqueBundleName();
    }

    function defaultInitData(MCDevKit storage mc) internal pure returns(bytes memory) {
        return "";
    }


    function toProxyAddress(MCDevKit storage mc) internal returns(address) {
        return mc.findCurrentProxy().addr;
    }
}

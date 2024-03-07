// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ForgeHelper, console2} from "DevKit/common/ForgeHelper.sol";
import {DevUtils} from "DevKit/common/DevUtils.sol";

import {MCStdFuncs, MCStdFuncsArgs} from "./functions/MCStdFuncs.sol";
import {MCCustomFuncs} from "./functions/MCCustomFuncs.sol";
import {DictionaryRegistry} from "./dictionary/DictionaryRegistry.sol";
import {ProxyRegistry} from "./proxy/ProxyRegistry.sol";
import {FuncInfo} from "./functions/FuncInfo.sol";
import {BundleInfo} from "./functions/BundleInfo.sol";
import {Dictionary, DictionaryUtils} from "./dictionary/Dictionary.sol";
import {Proxy, ProxyUtils} from "./proxy/Proxy.sol";


/********************************
    🌟 Meta Contract DevKit
*********************************/
using MCDevKitUtils for MCDevKit global;
struct MCDevKit {
    MCStdFuncs std;
    MCCustomFuncs custom;
    DictionaryRegistry dictionary;
    ProxyRegistry proxy;
}

    /**----------------------
        📝 DevKit Settings
    ------------------------*/
    /// @dev We will utilize this struct after Solidity is updated to allow Structs to be applied to Transient Storage.
    // struct MCDevKitSettings {
    //     bool outputLogs;
    // }


library MCDevKitUtils {
    using MCStdFuncsArgs for address;
    using DevUtils for string;
    using DevUtils for address;
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
        mc.std.assignAndLoad()
                        .deployIfNotExists()
                        .configureStdBundle();
        return mc;
    }


    /*****************************
        🌱 Init Custom Bundle
    ******************************/
    function init(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        mc.custom   .safeInit(name)
                    .safeUpdateBundleName(name);
        return mc;
    }
    function init(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return mc.init(mc.defaultCustomBundleName());
    }
    function ensureInit(MCDevKit storage mc) internal returns(MCDevKit storage) {
        if (!mc.existsCurrentBundle()) mc.init();
        return mc;
    }


    /***********************
        🔗 Use Function
    ************************/
    function use(MCDevKit storage mc, string memory name, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
        return mc   .ensureInit()
                    .addFunction(name, selector, implementation)
                    .addToBundle(name, mc.findCurrentFunction());
    }
    function use(MCDevKit storage mc, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
        return mc.use(implementation.getLabel(), selector, implementation);
    }
    function use(MCDevKit storage mc, FuncInfo storage functionInfo) internal returns(MCDevKit storage) {
        return mc;
    }
    function use(MCDevKit storage mc, BundleInfo storage bundleInfo) internal returns(MCDevKit storage) {
        return mc;
    }
    function use(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        return mc;
    }
    function use(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return mc;
    }
        /**---------------------------
            ✨ Add Custom Function
        -----------------------------*/
        function addFunction(MCDevKit storage mc, string memory name, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
            mc.custom   .safeAddFunction(name, selector, implementation)
                        .safeUpdateFunctionName(name);
            return mc;
        }
        /**-------------------------------------
            🧺 Add Custom Function to Bundle
        ---------------------------------------*/
        function addToBundle(MCDevKit storage mc, string memory name, FuncInfo storage functionInfo) internal returns(MCDevKit storage) {
            mc.custom.addToBundle(name, functionInfo);
            return mc;
        }


    /********************
        🖼 Set Facade
    *********************/
    function set(MCDevKit storage mc, string memory name, address facade) internal returns(MCDevKit storage) {
        mc.custom.set(name, facade);
        return mc;
    }
    // function set(MCDevKit storage mc, address facade) internal returns(MCDevKit storage) {
    //     return mc.set(mc.findCurrentBundleName(), facade);
    // }


    /******************************
        🚀 Deploy Meta Contract
    *******************************/
    function deploy(MCDevKit storage mc) internal returns(MCDevKit storage) {
        // TODO gen and set facade
        return mc.deploy(string("MyProxy"));
    }

    function deploy(MCDevKit storage mc, bytes memory initData) internal returns(MCDevKit storage) {
        return mc   .deployDictionary()
                    .set(mc.findCurrentBundle())
                    .deployProxy(initData);
    }
    function deploy(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        return mc.deploy(name, mc.findCurrentBundle(), mc.defaultInitData());
        // TODO defaultBundle --> current or allStd
    }
    function deploy(MCDevKit storage mc, BundleInfo storage bundleInfo) internal returns(MCDevKit storage) {
        return mc.deploy(mc.defaultName(), bundleInfo, mc.defaultInitData());
    }
    function deploy(MCDevKit storage mc, string memory name, BundleInfo storage bundleInfo) internal returns(MCDevKit storage) {
        return mc.deploy(name, bundleInfo, mc.defaultInitData());
    }
    function deploy(MCDevKit storage mc, string memory name, BundleInfo storage bundleInfo, bytes memory initData) internal returns(MCDevKit storage) {
        return mc   .deployDictionary(name.append("_Dictionary"))
                    .set(bundleInfo)
                    .deployProxy(name.append("_Proxy"), initData);
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
        Dictionary memory dictionary = DictionaryUtils.deploy(owner);

        mc.dictionary   .safeAdd(name, dictionary)
                        .safeUpdate(dictionary);

        return mc;
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
        Dictionary memory newDictionary = targetDictionary.duplicate();

        mc.dictionary   .safeAdd(name, newDictionary)
                        .safeUpdate(newDictionary);

        return mc;
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
        mc.findDictionary().set(functionInfo);
        return mc;
    }


    /**------------------
        🧺 Set Bundle
    --------------------*/
    function set(MCDevKit storage mc, BundleInfo memory bundleInfo) internal returns(MCDevKit storage) {
        mc.findDictionary().set(bundleInfo);
        return mc;
    }


    /**----------------------
        🖼 Upgrade Facade
    ------------------------*/
    function upgradeFacade(MCDevKit storage mc, address newFacade) internal returns(MCDevKit storage) {
        mc.findCurrentDictionary().upgradeFacade(newFacade);
        return mc;
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
        Proxy memory proxy = ProxyUtils.deploy(dictionary, initData);

        mc.proxy.safeAdd(name, proxy)
                .safeUpdate(proxy);

        return mc;
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
        Proxy memory simpleMockProxy = ProxyUtils.createSimpleMockProxy(functionInfos);

        mc.proxy.safeAdd(name, simpleMockProxy)
                .safeUpdate(simpleMockProxy);

        return mc;
    }
    function createSimpleMockProxy(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        return mc.createSimpleMockProxy(name, mc.defaultBundle().functionInfos);
    }
    function createSimpleMockProxy(MCDevKit storage mc, FuncInfo[] memory functionInfos) internal returns(MCDevKit storage) {
        return mc.createSimpleMockProxy(mc.defaultMockProxyName(), functionInfos);
    }
    function createSimpleMockProxy(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return mc.createSimpleMockProxy(mc.defaultMockProxyName(), mc.defaultBundle().functionInfos);
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
        Dictionary memory mockDictionary = DictionaryUtils.createMockDictionary(owner, functionInfos);
        // MockDictionary mockDictionary = SimpleMockDictionaryUtils.createMockDictionary(owner, functionInfos);

        mc.dictionary   .safeAdd(name, mockDictionary)
                        .safeUpdate(mockDictionary);

        return mc;
    }
    function createMockDictionary(MCDevKit storage mc, string memory name, address owner) internal returns(MCDevKit storage) {
        return mc.createMockDictionary(name, owner, mc.defaultBundle().functionInfos);
    }
    function createMockDictionary(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        return mc.createMockDictionary(name, mc.defaultOwner(), mc.defaultBundle().functionInfos);
    }
    function createMockDictionary(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return mc.createMockDictionary(mc.defaultMockDictionaryName(), mc.defaultOwner(), mc.defaultBundle().functionInfos);
    }



/******************************************
    🎭 Context Global Utils
        🔼 Update Context
*******************************************/
    /**----------------------
        🔼 Update Context
    ------------------------*/
    function updateContext(MCDevKit storage mc, Proxy storage proxy) internal returns(MCDevKit storage) {
        mc.proxy.safeUpdate(proxy);
        return mc;
    }
    function updateContext(MCDevKit storage mc, Dictionary storage dictionary) internal returns(MCDevKit storage) {
        mc.dictionary.safeUpdate(dictionary);
        return mc;
    }
    function updateContextBundle(MCDevKit storage mc, string memory bundleName) internal returns(MCDevKit storage) {
        mc.custom.safeUpdateBundleName(bundleName);
        return mc;
    }
    function updateContextFunction(MCDevKit storage mc, string memory functionName) internal returns(MCDevKit storage) {
        mc.custom.safeUpdateFunctionName(functionName);
        return mc;
    }


    /*************************
        🕵️ Getter Methods
    **************************/
    /**-------------------------
        📌 Current Context
    ---------------------------*/
    function findCurrentProxy(MCDevKit storage mc) internal returns(Proxy storage) {
        return mc.proxy.findCurrentProxy();
    }
    function findCurrentDictionary(MCDevKit storage mc) internal returns(Dictionary storage) {
        return mc.dictionary.findCurrentDictionary();
    }
    function findCurrentBundle(MCDevKit storage mc) internal returns(BundleInfo storage) {
        return mc.custom.findBundle(mc.custom.findCurrentBundleName());
    }
    function findCurrentFunction(MCDevKit storage mc) internal returns(FuncInfo storage) {
        return mc.custom.findCurrentFunction();
    }

    /**--------------------------
        📖 DevKit Environment
    ----------------------------*/
    function findProxy(MCDevKit storage mc, string memory name) internal returns(Proxy storage) {
        return mc.proxy.find(name);
    }
    function findProxy(MCDevKit storage mc) internal returns(Proxy storage) {
        return mc.findCurrentProxy();
    }
    function findProxyAddress(MCDevKit storage mc) internal returns(address) {
        return mc.findProxy().toAddress();
    }
    // function findMockProxy(MCDevKit storage mc, string memory name) internal returns(MockProxy) {
    //     return mc.test.findMockProxy(name);
    // }

    function findDictionary(MCDevKit storage mc, string memory name) internal returns(Dictionary storage) {
        return mc.dictionary.find(name);
    }
    function findDictionary(MCDevKit storage mc) internal returns(Dictionary storage) {
        return mc.findCurrentDictionary();
    }
    function findDictionaryAddress(MCDevKit storage mc) internal returns(address) {
        return mc.findDictionary().toAddress();
    }
    function findMockDictionary(MCDevKit storage mc, string memory name) internal returns(Dictionary storage) {
        return mc.dictionary.findMockDictionary(name);
    }

    function getDictionaryAddress(MCDevKit storage mc) internal returns(address) {
        return mc.findCurrentDictionary().toAddress();
    }

    function existsCurrentBundle(MCDevKit storage mc) internal returns(bool) {
        return mc.findCurrentBundle().exists();
    }

    function findCustomFunction(MCDevKit storage mc, string memory name) internal returns(FuncInfo storage) {
        return mc.custom.findFunction(name);
    }

    // function getExistingCustomBundle(MCDevKit storage mc, string memory name) internal returns(BundleInfo storage) {
    //     return mc.custom.getExistingBundleInfoBy(name);
    // }

    // function getRef_CustomBundle(MCDevKit storage mc, string memory name) internal returns(BundleInfo storage) {
    //     return mc.custom.getRef_BundleInfoBy(name);
    // }


/*******************************************************
    📝 Settings
        logging
        provide the Default Values of the UCS DevEnv
********************************************************/
    function toggleLog(MCDevKit storage mc) internal returns(MCDevKit storage) {
        DevUtils.toggleLog();
        return mc;
    }

    function defaultOwner(MCDevKit storage mc) internal returns(address) {
        return ForgeHelper.msgSender();
    }

    function defaultBundle(MCDevKit storage mc) internal returns(BundleInfo memory bundleInfo) {
        return mc.std.allFunctions;
    }

    function defaultName(MCDevKit storage mc) internal returns(string memory) {
        return "ProjectName"; // TODO
    }

    function defaultProxyName(MCDevKit storage mc) internal returns(string memory) {
        return mc.proxy.findUnusedProxyName();
    }

    function defaultDictionaryName(MCDevKit storage mc) internal returns(string memory) {
        return mc.dictionary.findUnusedDictionaryName();
    }

    function defaultDuplicatedDictionaryName(MCDevKit storage mc) internal returns(string memory) {
        return mc.dictionary.findUnusedDuplicatedDictionaryName();
    }

    function defaultCustomBundleName(MCDevKit storage mc) internal returns(string memory) {
        return mc.custom.findUnusedCustomBundleName();
    }

    function defaultMockProxyName(MCDevKit storage mc) internal returns(string memory) {
        return mc.proxy.findUnusedMockProxyName();
    }

    function defaultMockDictionaryName(MCDevKit storage mc) internal returns(string memory) {
        return mc.dictionary.findUnusedMockDictionaryName();
    }

    function defaultInitData(MCDevKit storage mc) internal returns(bytes memory) {
        return "";
    }

}

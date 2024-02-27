// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ForgeHelper, console2} from "dev-env/common/ForgeHelper.sol";
import {DevUtils} from "dev-env/common/DevUtils.sol";
import {UCSDevEnv, Dictionary, Proxy, Op, OpInfo, BundleOpsInfo, MockProxy, MockDictionary} from "dev-env/UCSDevEnv.sol";
import {DictionaryUtils} from "dev-env/dictionary/DictionaryUtils.sol";
import {ProxyUtils} from "dev-env/proxy/ProxyUtils.sol";
import {StdOpsArgs} from "dev-env/ops/StdOpsArgs.sol";

/***************************************
🌟 UCS Development Environment Utils
    🌐 General
    🧩 Ops
    📚 Dictionary
    🏠 Proxy
    🧪 Test
    🎭 Context
    📝 Settings
****************************************/
library UCSDevEnvUtils {
    using StdOpsArgs for address;

    /**********************************
        🌐 General
    **********************************/
    function deploy(UCSDevEnv storage ucs) internal returns(UCSDevEnv storage) {
        return ucs.deploy("MyProxy");
    }

    function deploy(UCSDevEnv storage ucs, string memory name) internal returns(UCSDevEnv storage) {
        return ucs  .deployDictionary()
                    .set(ucs.ops.stdOps.allStdOps)
                    .deployProxy(name);
    }

    function getProxy(UCSDevEnv storage ucs) internal returns(Proxy) {
        return ucs.context.currentProxy;
    }

    function getDictionary(UCSDevEnv storage ucs) internal returns(Dictionary) {
        return ucs.context.currentDictionary;
    }



/**********************************
    🧩 Ops Global Utils
        📦 Setup Standard Ops
        - Deploy Dictionary
        - Clone Dictionary
        - SetOp
        - UpgradeFacade
**********************************/
    /**--------------------------
        📦 Setup Standard Ops
    ----------------------------*/
    function setStdOpsInfoAndTrySetDeployedOps(UCSDevEnv storage ucs) internal returns(UCSDevEnv storage) {
        ucs.ops.setStdOpsInfoAndTrySetDeployedOps();
        return ucs;
    }

    function deployStdOpsIfNotExists(UCSDevEnv storage ucs) internal returns(UCSDevEnv storage) {
        ucs.ops.deployStdOpsIfNotExists();
        return ucs;
    }

    function setStdBundleOps(UCSDevEnv storage ucs) internal returns(UCSDevEnv storage) {
        ucs.ops.setStdBundleOps();
        return ucs;
    }

    // function getDeployedFacadeBy(UCSDevEnv storage ucs, string memory bundleName) internal returns(address) {
    //     bytes32 _bundleNameHash = DevUtils.getNameHash(bundleName);
    //     return ucs.ops.bundleOps.infos[_bundleNameHash].facade;
    // }



/************************************************
    📚 Dictionary Global Utils
        🐣 Deploy Dictionary
        🔂 Duplicate Dictionary
        🧩 Set Op
        🖼 Upgrade Facade
        🔧 Helper Methods for type Dictionary
*************************************************/
    /**-------------------------
        🐣 Deploy Dictionary
    ---------------------------*/
    function deployDictionary(UCSDevEnv storage ucs, string memory name, address owner) internal returns(UCSDevEnv storage) {
        ucs.dictionary.deployAndSetDictionary(name, owner);
        ucs.context.setCurrentDictionary(ucs.getDeployedDictionaryBy(name));
        return ucs;
    }
    function deployDictionary(UCSDevEnv storage ucs, string memory name) internal returns(UCSDevEnv storage) {
        return ucs.deployDictionary(name, ucs.defaultOwner());
    }
    function deployDictionary(UCSDevEnv storage ucs) internal returns(UCSDevEnv storage) {
        return ucs.deployDictionary(ucs.defaultDictionaryName(), ucs.defaultOwner());
    }


    /**----------------------------
        🔂 Duplicate Dictionary
    ------------------------------*/
    function duplicateDictionary(UCSDevEnv storage ucs, string memory name, Dictionary targetDictionary) internal returns(UCSDevEnv storage) {
        ucs.dictionary.duplicateAndSetDictionary(name, targetDictionary);
        ucs.context.setCurrentDictionary(ucs.getDeployedDictionaryBy(name));
        return ucs;
    }
    function duplicateDictionary(UCSDevEnv storage ucs, string memory name) internal returns(UCSDevEnv storage) {
        return ucs.duplicateDictionary(name, ucs.getCurrentDictionary());
    }
    function duplicateDictionary(UCSDevEnv storage ucs, Dictionary targetDictionary) internal returns(UCSDevEnv storage) {
        return ucs.duplicateDictionary(ucs.defaultDuplicatedDictionaryName(), targetDictionary);
    }
    function duplicateDictionary(UCSDevEnv storage ucs) internal returns(UCSDevEnv storage) {
        return ucs.duplicateDictionary(ucs.defaultDuplicatedDictionaryName(), ucs.getCurrentDictionary());
    }


    /**----------------
        🧩 Set Op
    ------------------*/
    function set(UCSDevEnv storage ucs, Dictionary dictionary, Op memory op) internal returns(UCSDevEnv storage) {
        dictionary.set(op);
        return ucs;
    }
    function set(UCSDevEnv storage ucs, Dictionary dictionary, OpInfo memory opInfo) internal returns(UCSDevEnv storage) {
        return ucs.set(dictionary, opInfo.toOp());
    }
    function set(UCSDevEnv storage ucs, string memory dictionaryName, Op memory op) internal returns(UCSDevEnv storage) {
        return ucs.set(ucs.getDeployedDictionaryBy(dictionaryName), op);
    }
    function set(UCSDevEnv storage ucs, string memory dictionaryName, OpInfo memory opInfo) internal returns(UCSDevEnv storage) {
        return ucs.set(ucs.getDeployedDictionaryBy(dictionaryName), opInfo.toOp());
    }
    function set(UCSDevEnv storage ucs, Op memory op) internal returns(UCSDevEnv storage) {
        return ucs.set(ucs.getCurrentDictionary(), op);
    }
    function set(UCSDevEnv storage ucs, OpInfo memory opInfo) internal returns(UCSDevEnv storage) {
        return ucs.set(ucs.getCurrentDictionary(), opInfo.toOp());
    }

    function set(UCSDevEnv storage ucs, Dictionary dictionary, BundleOpsInfo memory bundleOpsInfo) internal returns(UCSDevEnv storage) {
        dictionary.set(bundleOpsInfo);
        return ucs;
    }
    function set(UCSDevEnv storage ucs, BundleOpsInfo memory bundleOpsInfo) internal returns(UCSDevEnv storage) {
        return ucs.set(ucs.getCurrentDictionary(), bundleOpsInfo);
    }


    /**----------------------
        🖼 Upgrade Facade
    ------------------------*/
    function upgradeFacade(UCSDevEnv storage ucs, Dictionary dictionary, address newFacade) internal returns(UCSDevEnv storage) {
        dictionary.upgradeFacade(newFacade);
        return ucs;
    }
    function upgradeFacade(UCSDevEnv storage ucs, address newFacade) internal returns(UCSDevEnv storage) {
        return ucs.upgradeFacade(ucs.getCurrentDictionary(), newFacade);
    }


    /**------------------------------------------
        🔧 Helper Methods for type Dictionary
    --------------------------------------------*/
    function getDeployedDictionaryBy(UCSDevEnv storage ucs, string memory name) internal returns(Dictionary) {
        return ucs.dictionary.getDictionary(name);
    }



/********************************************
    🏠 Proxy Global Utils
        🐣 Deploy Proxy
        🔧 Helper Methods for type Proxy
*********************************************/
    /**---------------------
        🐣 Deploy Proxy
    -----------------------*/
    function deployProxy(UCSDevEnv storage ucs, string memory name, Dictionary dictionary, bytes memory initData) internal returns(UCSDevEnv storage) {
        ucs.proxy.deployAndSetProxy(name, dictionary, initData);
        ucs.context.setCurrentProxy(ucs.getDeployedProxyBy(name));
        return ucs;
    }
    function deployProxy(UCSDevEnv storage ucs, string memory name, Dictionary dictionary, address owner) internal returns(UCSDevEnv storage) {
        return ucs.deployProxy(name, dictionary, owner.initSetAdminBytes());
    }
    function deployProxy(UCSDevEnv storage ucs, string memory name, Dictionary dictionary) internal returns(UCSDevEnv storage) {
        return ucs.deployProxy(name, dictionary, ucs.defaultOwner().initSetAdminBytes());
    }
    function deployProxy(UCSDevEnv storage ucs, string memory name) internal returns(UCSDevEnv storage) {
        return ucs.deployProxy(name, ucs.getCurrentDictionary(), ucs.defaultOwner().initSetAdminBytes());
    }
    function deployProxy(UCSDevEnv storage ucs) internal returns(UCSDevEnv storage) {
        return ucs.deployProxy(ucs.defaultProxyName(), ucs.getCurrentDictionary(), ucs.defaultOwner().initSetAdminBytes());
    }

    /**------------------------------------
        🔧 Helper Methods for type Proxy
    --------------------------------------*/
    function getDeployedProxyBy(UCSDevEnv storage ucs, string memory name) internal returns(Proxy) {
        return ucs.proxy.getProxy(name);
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
        @param name The name of the MockProxy, used as a key in the `ucs.test.mockProxies` mapping and as a label name in the Forge test runner. If not provided, sequential default names from `MockProxy0` to `MockProxy4` will be used.
        @param ops The Ops to be registered with the SimpleMockProxy. A bundle can also be specified. Note that the SimpleMockProxy cannot have its Ops changed later. If no Ops are provided, defaultOps will be used.
    */
    function createSimpleMockProxy(UCSDevEnv storage ucs, string memory name, Op[] memory ops) internal returns(UCSDevEnv storage) {
        ucs.test.createAndSetSimpleMockProxy(name, ops);
        ucs.context.setCurrentProxy(ucs.getMockProxyBy(name));
        return ucs;
    }
    function createSimpleMockProxy(UCSDevEnv storage ucs, string memory name, BundleOpsInfo memory bundleOpsInfo) internal returns(UCSDevEnv storage) {
        return ucs.createSimpleMockProxy(name, bundleOpsInfo.toOps());
    }
    function createSimpleMockProxy(UCSDevEnv storage ucs, string memory name) internal returns(UCSDevEnv storage) {
        return ucs.createSimpleMockProxy(name, ucs.defaultOps());
    }
    function createSimpleMockProxy(UCSDevEnv storage ucs, Op[] memory ops) internal returns(UCSDevEnv storage) {
        return ucs.createSimpleMockProxy(ucs.defaultMockProxyName(), ops);
    }
    function createSimpleMockProxy(UCSDevEnv storage ucs, BundleOpsInfo memory bundleOpsInfo) internal returns(UCSDevEnv storage) {
        return ucs.createSimpleMockProxy(ucs.defaultMockProxyName(), bundleOpsInfo.toOps());
    }
    function createSimpleMockProxy(UCSDevEnv storage ucs) internal returns(UCSDevEnv storage) {
        return ucs.createSimpleMockProxy(ucs.defaultMockProxyName(), ucs.defaultOps());
    }

    /**
        @notice Get MockProxy by name
     */
    function getMockProxyBy(UCSDevEnv storage ucs, string memory name) internal returns(MockProxy) {
        return ucs.test.getMockProxyBy(name);
    }



    /**-------------------------
        📚 Mocking Dictionary
    ---------------------------*/
    /**
        @notice Creates a DictionaryEtherscan as a MockDictionary.
        @param name The name of the `MockDictionary`, used as a key in the `ucs.test.mockDictionaries` mapping and as a label name in the Forge test runner. If not provided, sequential default names from `MockDictionary0` to `MockDictionary4` will be used.
        @param owner The address to be set as the owner of the DictionaryEtherscan contract. If not provided, the DefaultOwner from the UCS environment settings is used.
        @param ops The Ops to be registered with the `MockDictionary`. A bundle can also be specified. If no Ops are provided, defaultOps will be used.
    */
    function createMockDictionary(UCSDevEnv storage ucs, string memory name, address owner, Op[] memory ops) internal returns(UCSDevEnv storage) {
        ucs.test.createAndSetMockDictionary(name, owner, ops);
        ucs.context.setCurrentDictionary(ucs.getMockDictionaryBy(name));
        return ucs;
    }
    function createMockDictionary(UCSDevEnv storage ucs, string memory name, address owner, BundleOpsInfo memory bundleOpsInfo) internal returns(UCSDevEnv storage) {
        return ucs.createMockDictionary(name, owner, bundleOpsInfo.toOps());
    }
    function createMockDictionary(UCSDevEnv storage ucs, string memory name, address owner) internal returns(UCSDevEnv storage) {
        return ucs.createMockDictionary(name, owner, ucs.defaultOps());
    }
    function createMockDictionary(UCSDevEnv storage ucs, string memory name, Op[] memory ops) internal returns(UCSDevEnv storage) {
        return ucs.createMockDictionary(name, ucs.defaultOwner(), ops);
    }
    function createMockDictionary(UCSDevEnv storage ucs, string memory name, BundleOpsInfo memory bundleOpsInfo) internal returns(UCSDevEnv storage) {
        return ucs.createMockDictionary(name, ucs.defaultOwner(), bundleOpsInfo.toOps());
    }
    function createMockDictionary(UCSDevEnv storage ucs, string memory name) internal returns(UCSDevEnv storage) {
        return ucs.createMockDictionary(name, ucs.defaultOwner(), ucs.defaultOps());
    }
    function createMockDictionary(UCSDevEnv storage ucs, Op[] memory ops) internal returns(UCSDevEnv storage) {
        return ucs.createMockDictionary(ucs.defaultMockDictionaryName(), ucs.defaultOwner(), ops);
    }
    function createMockDictionary(UCSDevEnv storage ucs, BundleOpsInfo memory bundleOpsInfo) internal returns(UCSDevEnv storage) {
        return ucs.createMockDictionary(ucs.defaultMockDictionaryName(), ucs.defaultOwner(), bundleOpsInfo.toOps());
    }
    function createMockDictionary(UCSDevEnv storage ucs) internal returns(UCSDevEnv storage) {
        return ucs.createMockDictionary(ucs.defaultMockDictionaryName(), ucs.defaultOwner(), ucs.defaultOps());
    }

    /**
        @notice Get MockDictionary by name
     */
    function getMockDictionaryBy(UCSDevEnv storage ucs, string memory name) internal returns(MockDictionary) {
        return ucs.test.getMockDictionaryBy(name);
    }



/******************************************
    🎭 Context Global Utils
        🏠 Current Context Proxy
        📚 Current Context Dictionary
*******************************************/
    /**-----------------------------
        🏠 Current Context Proxy
    -------------------------------*/
    function setCurrentProxy(UCSDevEnv storage ucs, Proxy proxy) internal returns(UCSDevEnv storage) {
        ucs.context.setCurrentProxy(proxy);
        return ucs;
    }

    /// @notice Set named proxy as the current proxy
    function setCurrentProxyBy(UCSDevEnv storage ucs, string memory name) internal returns(UCSDevEnv storage) {
        return ucs.setCurrentProxy(ucs.getDeployedProxyBy(name));
    }

    function getCurrentProxy(UCSDevEnv storage ucs) internal returns(Proxy) {
        return ucs.context.getCurrentProxy();
    }

    function getProxyAddress(UCSDevEnv storage ucs) internal returns(address) {
        return ucs.getCurrentProxy().toAddress();
    }


    /**----------------------------------
        📚 Current Context Dictionary
    ------------------------------------*/
    function setCurrentDictionary(UCSDevEnv storage ucs, Dictionary dictionary) internal returns(UCSDevEnv storage) {
        ucs.context.setCurrentDictionary(dictionary);
        return ucs;
    }

    /// @dev Set named dictionary as the current dictionary
    function setCurrentDictionaryBy(UCSDevEnv storage ucs, string memory name) internal returns(UCSDevEnv storage) {
        return ucs.setCurrentDictionary(ucs.getDeployedDictionaryBy(name));
    }

    function getCurrentDictionary(UCSDevEnv storage ucs) internal returns(Dictionary) {
        return ucs.context.getCurrentDictionary();
    }

    function getDictionaryAddress(UCSDevEnv storage ucs) internal returns(address) {
        return ucs.getCurrentDictionary().toAddress();
    }



/*******************************************************
    📝 Settings
        logging
        provide the Default Values of the UCS DevEnv
********************************************************/
    function toggleLog(UCSDevEnv storage ucs) internal returns(UCSDevEnv storage) {
        DevUtils.toggleLog();
        return ucs;
    }

    function defaultOwner(UCSDevEnv storage ucs) internal returns(address) {
        return ForgeHelper.msgSender();
    }

    function defaultOps(UCSDevEnv storage ucs) internal returns(Op[] memory ops) {
        return ucs.ops.stdOps.allStdOps.toOps();
    }

    function defaultProxyName(UCSDevEnv storage ucs) internal returns(string memory) {
        return ucs.proxy.findUnusedProxyName();
    }

    function defaultDictionaryName(UCSDevEnv storage ucs) internal returns(string memory) {
        return ucs.dictionary.findUnusedDictionaryName();
    }

    function defaultDuplicatedDictionaryName(UCSDevEnv storage ucs) internal returns(string memory) {
        return "DUPLICATED_DICTIONARY"; // TODO
    }

    function defaultMockProxyName(UCSDevEnv storage ucs) internal returns(string memory) {
        return ucs.test.findUnusedMockProxyName();
    }

    function defaultMockDictionaryName(UCSDevEnv storage ucs) internal returns(string memory) {
        return ucs.test.findUnusedMockDictionaryName();
    }

}

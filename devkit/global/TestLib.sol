// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKit} from "devkit/MCDevKit.sol";
// Utils
import {Params} from "devkit/debug/Params.sol";
import {Config} from "devkit/Config.sol";
// Core
//  functions
import {BundleInfo} from "devkit/core/functions/BundleInfo.sol";
import {FuncInfo} from "devkit/core/functions/FuncInfo.sol";
//  proxy
import {Proxy, ProxyUtils} from "devkit/core/proxy/Proxy.sol";
//  dictionary
import {Dictionary, DictionaryUtils} from "devkit/core/dictionary/Dictionary.sol";


/******************************************
    🧪 Test
        🏠 Mocking Proxy
        📚 Mocking Dictionary
        🤲 Set Storage Reader
*******************************************/
library TestLib {
    using TestLib for MCDevKit;
    string constant LIB_NAME = "TestLib";


    /**---------------------
        🏠 Mocking Proxy
    -----------------------*/
    /**
        @notice Creates a SimpleMockProxy as a MockProxy
        @param name The name of the MockProxy, used as a key in the `mc.test.mockProxies` mapping and as a label name in the Forge test runner. If not provided, sequential default names from `MockProxy0` to `MockProxy4` will be used.
        @param functionInfos The function contract infos to be registered with the SimpleMockProxy. A bundle can also be specified. Note that the SimpleMockProxy cannot have its functions changed later. If no functions are provided, defaultBundle will be used.
    */
    function createSimpleMockProxy(MCDevKit storage mc, string memory name, FuncInfo[] memory functionInfos) internal returns(MCDevKit storage) {
        string memory params = Params.append(name);
        // for (uint i; i < functionInfos.length; ++i) {
        //     params = params.comma().append(functionInfos[i].name);
        // }
        uint pid = mc.recordExecStart("createSimpleMockProxy", params);
        Proxy memory simpleMockProxy = ProxyUtils.createSimpleMockProxy(functionInfos);
        mc.proxy.safeAdd(name, simpleMockProxy)
                .safeUpdate(simpleMockProxy);
        return mc.recordExecFinish(pid);
    }
    function createSimpleMockProxy(MCDevKit storage mc, string memory name, BundleInfo storage bundleInfo) internal returns(MCDevKit storage) {
        return mc.createSimpleMockProxy(name, bundleInfo.functionInfos);
    }
    function createSimpleMockProxy(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        return mc.createSimpleMockProxy(name, mc.functions.std.all);
    }
    function createSimpleMockProxy(MCDevKit storage mc, FuncInfo[] memory functionInfos) internal returns(MCDevKit storage) {
        return mc.createSimpleMockProxy(mc.proxy.genUniqueMockName(), functionInfos);
    }
    function createSimpleMockProxy(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return mc.createSimpleMockProxy(mc.proxy.genUniqueMockName(), mc.functions.std.all);
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
        uint pid = mc.recordExecStart("createMockDictionary", Params.append(name, owner));
        Dictionary memory mockDictionary = DictionaryUtils.createMockDictionary(owner, functionInfos);
        mc.dictionary   .safeAdd(name, mockDictionary)
                        .safeUpdate(mockDictionary);
        return mc.recordExecFinish(pid);
    }
    function createMockDictionary(MCDevKit storage mc, string memory name, address owner, BundleInfo storage bundleInfo) internal returns(MCDevKit storage) {
        return mc.createMockDictionary(name, owner, bundleInfo.functionInfos);
    }
    function createMockDictionary(MCDevKit storage mc, string memory name, address owner) internal returns(MCDevKit storage) {
        return mc.createMockDictionary(name, owner, mc.functions.std.all);
    }
    function createMockDictionary(MCDevKit storage mc, string memory name) internal returns(MCDevKit storage) {
        return mc.createMockDictionary(name, Config.defaultOwner(), mc.functions.std.all);
    }
    function createMockDictionary(MCDevKit storage mc) internal returns(MCDevKit storage) {
        return mc.createMockDictionary(mc.dictionary.genUniqueMockName(), Config.defaultOwner(), mc.functions.std.all);
    }


    /**--------------------------
        🤲 Set Storage Reader
    ----------------------------*/
    function setStorageReader(MCDevKit storage mc, Dictionary memory dictionary, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
        uint pid = mc.recordExecStart("setStorageReader", Params.append(selector, implementation));
        dictionary.set(
            FuncInfo({
                name: "StorageGetter",
                selector: selector,
                implementation: implementation
            })
        );
        return mc.recordExecFinish(pid);
    }
    function setStorageReader(MCDevKit storage mc, string memory bundleName, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
        return mc.setStorageReader(mc.findDictionary(bundleName), selector, implementation);
    }
    function setStorageReader(MCDevKit storage mc, bytes4 selector, address implementation) internal returns(MCDevKit storage) {
        return mc.setStorageReader(mc.findCurrentDictionary(), selector, implementation);
    }

}

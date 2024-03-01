// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {DevUtils} from "dev-env/common/DevUtils.sol";
import {UCSContext, Proxy, MockProxy, Dictionary, MockDictionary, OpInfo} from "dev-env/UCSDevEnv.sol";
import {ProxyUtils} from "dev-env/proxy/ProxyUtils.sol";
import {DictionaryUtils} from "dev-env/dictionary/DictionaryUtils.sol";

/******************************************
    🎭 Context Primitive Utils
        🏠 Current Context Proxy
        📚 Current Context Dictionary
*******************************************/
library ContextUtils {
    using {ProxyUtils.asProxy} for address;
    using {DictionaryUtils.asDictionary} for address;
    using DevUtils for string;

    /**-----------------------------
        🏠 Current Context Proxy
    -------------------------------*/
    function setCurrentProxy(UCSContext storage context, Proxy proxy) internal returns(UCSContext storage) {
        if (!proxy.exists()) DevUtils.revertWith("SetCurrentProxy_EmptyProxy");
        context.currentProxy = proxy;
        return context;
    }

    function setCurrentProxy(UCSContext storage context, MockProxy mockProxy) internal returns(UCSContext storage) {
        return context.setCurrentProxy(mockProxy.toAddress().asProxy());
    }

    function getCurrentProxy(UCSContext storage context) internal returns(Proxy) {
        Proxy proxy = context.currentProxy;
        if (!proxy.exists()) DevUtils.revertWith("GetCurrentProxy_NotFound");
        return proxy;
    }


    /**----------------------------------
        📚 Current Context Dictionary
    ------------------------------------*/
    function setCurrentDictionary(UCSContext storage context, Dictionary dictionary) internal returns(UCSContext storage) {
        if (!dictionary.exists()) DevUtils.revertWith("SetCurrentDictionary_EmptyDictionary");
        context.currentDictionary = dictionary;
        return context;
    }

    function setCurrentDictionary(UCSContext storage context, MockDictionary mockDictionary) internal returns(UCSContext storage) {
        return context.setCurrentDictionary(mockDictionary.toAddress().asDictionary());
    }

    function getCurrentDictionary(UCSContext storage context) internal returns(Dictionary) {
        Dictionary dictionary = context.currentDictionary;
        if (!dictionary.exists()) DevUtils.revertWith("GetCurrentDictionary_NotFound");
        return dictionary;
    }


    /**----------------------------------
        🧰 Current Context Bundle Ops
    ------------------------------------*/
    function setCurrentBundleOpsName(UCSContext storage context, string memory name) internal returns(UCSContext storage) {
        context.currentCustomBundleOpsName = name.assertNotEmpty("UCSContext: SetCurrentBundleOpsName_EmptyName");
        return context;
    }

    function getCurrentBundleOpsName(UCSContext storage context) internal returns(string memory) {
        return context.currentCustomBundleOpsName;
    }

    function getCurrentBundleOpsNameHash(UCSContext storage context) internal returns(bytes32) {
        return DevUtils.getHash(context.getCurrentBundleOpsName());
    }


    /**------------------------------
        🧩 Current Context OpInfo
    --------------------------------*/
    function setCurrentOpInfo(UCSContext storage context, OpInfo storage opInfo) internal returns(UCSContext storage) {
        context.currentOpInfo = opInfo.assertExists("UCSContext: Set Current OpInfo");
        return context;
    }

    function getCurrentOpInfo(UCSContext storage context) internal returns(OpInfo storage) {
        return context.currentOpInfo;
    }
}

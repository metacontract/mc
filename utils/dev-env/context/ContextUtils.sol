// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {DevUtils} from "dev-env/common/DevUtils.sol";
import {UCSContext, Proxy, MockProxy, Dictionary, MockDictionary} from "dev-env/UCSDevEnv.sol";
import {ProxyUtils} from "dev-env/proxy/ProxyUtils.sol";

/******************************************
    🎭 Context Primitive Utils
        🏠 Current Context Proxy
        📚 Current Context Dictionary
*******************************************/
library ContextUtils {
    using {ProxyUtils.asProxy} for address;

    /**-----------------------------
        🏠 Current Context Proxy
    -------------------------------*/
    function setCurrentProxy(UCSContext storage context, Proxy proxy) internal returns(UCSContext storage) {
        if (!proxy.exists()) DevUtils.revertWithDevEnvError("SetCurrentProxy_EmptyProxy");
        context.currentProxy = proxy;
        return context;
    }

    function setCurrentProxy(UCSContext storage context, MockProxy mockProxy) internal returns(UCSContext storage) {
        return context.setCurrentProxy(mockProxy.toAddress().asProxy());
    }

    function getCurrentProxy(UCSContext storage context) internal returns(Proxy) {
        Proxy proxy = context.currentProxy;
        if (!proxy.exists()) DevUtils.revertWithDevEnvError("GetCurrentProxy_NotFound");
        return proxy;
    }


    /**----------------------------------
        📚 Current Context Dictionary
    ------------------------------------*/
    function setCurrentDictionary(UCSContext storage context, Dictionary dictionary) internal returns(UCSContext storage) {
        if (!dictionary.exists()) DevUtils.revertWithDevEnvError("SetCurrentDictionary_EmptyDictionary");
        context.currentDictionary = dictionary;
        return context;
    }

    function getCurrentDictionary(UCSContext storage context) internal returns(Dictionary) {
        Dictionary dictionary = context.currentDictionary;
        if (!dictionary.exists()) DevUtils.revertWithDevEnvError("GetCurrentDictionary_NotFound");
        return dictionary;
    }

}

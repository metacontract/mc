// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {DevUtils} from "dev-env/common/DevUtils.sol";
import {UCSContext, Proxy, Dictionary} from "dev-env/UCSDevEnv.sol";

/******************************************
    🎭 Context Primitive Utils
        🏠 Current Context Proxy
        📚 Current Context Dictionary
*******************************************/
library ContextUtils {
    /**-----------------------------
        🏠 Current Context Proxy
    -------------------------------*/
    function setCurrentProxy(UCSContext storage context, Proxy proxy) internal returns(UCSContext storage) {
        if (!proxy.exists()) DevUtils.revertWithDevEnvError("SetCurrentProxy_EmptyProxy");
        context.currentProxy = proxy;
        return context;
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

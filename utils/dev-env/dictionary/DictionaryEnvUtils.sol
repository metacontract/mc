// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {DevUtils} from "dev-env/common/DevUtils.sol";
import {UCSDictionaryEnv, Dictionary} from "dev-env/UCSDevEnv.sol";

/********************************************
    📚 Dictionary Deployed Contract Utils
        🗒 Set Dictionary
        🔍 Get Dictionary
*********************************************/
library DictionaryEnvUtils {
    using {DevUtils.exists} for address;

    /**-------------------------
        🗒 Set Dictionary
    ---------------------------*/
    error SetDictionary_EmptyDictionary();
    function setDictionary(UCSDictionaryEnv storage env, string memory name, Dictionary dictionary) internal returns(UCSDictionaryEnv storage) {
        if (!dictionary.exists()) revert SetDictionary_EmptyDictionary();
        bytes32 nameHash = DevUtils.getHash(name);
        env.deployed[nameHash] = dictionary;
        return env;
    }


    /**-------------------------
        🔍 Get Dictionary
    ---------------------------*/
    error GetDictionary_NotFound();
    function getDictionary(UCSDictionaryEnv storage env, string memory name) internal returns(Dictionary) {
        bytes32 nameHash = DevUtils.getHash(name);
        Dictionary dictionary = env.deployed[nameHash];
        if (!dictionary.exists()) revert GetDictionary_NotFound();
        return dictionary;
    }

    error SetDictionaryUpgradeableImpl_EmptyImpl();
    function setDictionaryUpgradeableImpl(UCSDictionaryEnv storage env, address dictionaryUpgradeableImpl) internal returns(UCSDictionaryEnv storage) {
        if (dictionaryUpgradeableImpl.exists()) revert SetDictionaryUpgradeableImpl_EmptyImpl();
        env.upgradeableImpl = dictionaryUpgradeableImpl;
        return env;
    }

    error SetDictionaryUpgradeableEtherscanImpl_EmptyImpl();
    function setDictionaryUpgradeableEtherscanImpl(UCSDictionaryEnv storage env, address dictionaryUpgradeableEtherscanImpl) internal returns(UCSDictionaryEnv storage) {
        if (dictionaryUpgradeableEtherscanImpl.exists()) revert SetDictionaryUpgradeableEtherscanImpl_EmptyImpl();
        env.upgradeableEtherscanImpl = dictionaryUpgradeableEtherscanImpl;
        return env;
    }

    error GetDictionaryImpl_NotFound();
    function getDictionaryImpl(UCSDictionaryEnv storage env, bool useEtherscanVerification) internal returns(address) {
        address impl;

        if (useEtherscanVerification) {
            impl = env.upgradeableEtherscanImpl;
        } else {
            impl = env.upgradeableImpl;
        }

        if (impl.exists()) revert GetDictionaryImpl_NotFound();
        return impl;
    }

}

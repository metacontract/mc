// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {DevUtils} from "dev-env/common/DevUtils.sol";
import {UCSDictionaryEnv, Dictionary} from "dev-env/UCSDevEnv.sol";
import {DictionaryUtils} from "dev-env/dictionary/DictionaryUtils.sol";
import {ForgeHelper} from "dev-env/common/ForgeHelper.sol";

/********************************************
    📚 Dictionary Deployed Contract Utils
        🗒 Set Dictionary
        🔍 Get Dictionary
*********************************************/
library DictionaryEnvUtils {
    using {DevUtils.exists} for address;

    function deployAndSetDictionary(UCSDictionaryEnv storage dictionaryEnv, string memory name, address owner) internal returns(UCSDictionaryEnv storage) {
        /// @dev Until Etherscan supports UCS, we are deploying contracts with additional features for Etherscan compatibility by default.
        Dictionary dictionary = DictionaryUtils.deployDictionaryEtherscan(owner).assignLabel(name);
        dictionaryEnv.setDictionary(name, dictionary);
        return dictionaryEnv;
    }

    function duplicateAndSetDictionary(UCSDictionaryEnv storage dictionaryEnv, string memory name, Dictionary targetDictionary) internal returns(UCSDictionaryEnv storage) {
        Dictionary duplicatedDictionary = targetDictionary.duplicate(name);
        dictionaryEnv.setDictionary(name, duplicatedDictionary);
        return dictionaryEnv;
    }

    /**-------------------------
        🗒 Set Dictionary
    ---------------------------*/
    function setDictionary(UCSDictionaryEnv storage dictionaryEnv, string memory name, Dictionary dictionary) internal returns(UCSDictionaryEnv storage) {
        if (!dictionary.exists()) DevUtils.revertWithDevEnvError("SetDictionary_EmptyDictionary");
        dictionaryEnv.deployed[DevUtils.getHash(name)] = dictionary.assignLabel(name);
        return dictionaryEnv;
    }

    function setDictionaryUpgradeableImpl(UCSDictionaryEnv storage dictionaryEnv, address dictionaryUpgradeableImpl) internal returns(UCSDictionaryEnv storage) {
        if (dictionaryUpgradeableImpl.exists()) DevUtils.revertWithDevEnvError("SetDictionaryUpgradeableImpl_EmptyImpl");
        dictionaryEnv.upgradeableImpl = dictionaryUpgradeableImpl;
        return dictionaryEnv;
    }

    function setDictionaryUpgradeableEtherscanImpl(UCSDictionaryEnv storage dictionaryEnv, address dictionaryUpgradeableEtherscanImpl) internal returns(UCSDictionaryEnv storage) {
        if (dictionaryUpgradeableEtherscanImpl.exists()) DevUtils.revertWithDevEnvError("SetDictionaryUpgradeableEtherscanImpl_EmptyImpl");
        dictionaryEnv.upgradeableEtherscanImpl = dictionaryUpgradeableEtherscanImpl;
        return dictionaryEnv;
    }


    /**-------------------------
        🔍 Get Dictionary
    ---------------------------*/
    function getDictionary(UCSDictionaryEnv storage dictionaryEnv, string memory name) internal returns(Dictionary) {
        Dictionary dictionary = dictionaryEnv.deployed[DevUtils.getHash(name)];
        if (!dictionary.exists()) DevUtils.revertWithDevEnvError("GetDictionary_NotFound");
        return dictionary;
    }

    function getDictionaryImpl(UCSDictionaryEnv storage dictionaryEnv, bool useEtherscanVerification) internal returns(address) {
        address impl;

        if (useEtherscanVerification) {
            impl = dictionaryEnv.upgradeableEtherscanImpl;
        } else {
            impl = dictionaryEnv.upgradeableImpl;
        }

        if (impl.exists()) DevUtils.revertWithDevEnvError("GetDictionaryImpl_NotFound");
        return impl;
    }

    function exists(UCSDictionaryEnv storage dictionaryEnv, string memory name) internal returns(bool) {
        return dictionaryEnv.deployed[DevUtils.getHash(name)].exists();
    }


    function findUnusedDictionaryName(UCSDictionaryEnv storage dictionaryEnv) internal returns(string memory name) {
        return dictionaryEnv.findUnusedName("Dictionary");
    }

    function findUnusedDuplicatedDictionaryName(UCSDictionaryEnv storage dictionaryEnv) internal returns(string memory name) {
        return dictionaryEnv.findUnusedName("DuplicatedDictionary");
    }


    /**-----------------------
        🔧 Helper Methods
    -------------------------*/
    function findUnusedName(
        UCSDictionaryEnv storage dictionaryEnv,
        string memory baseName
    ) internal returns(string memory name) {
        (uint start, uint end) = DevUtils.getScanRange();

        for (uint i = start; i <= end; ++i) {
            name = ForgeHelper.appendNumberToNameIfNotOne(baseName, i);
            if (!dictionaryEnv.exists(name)) return name;
        }

        DevUtils.revertUnusedNameNotFound();
    }
}

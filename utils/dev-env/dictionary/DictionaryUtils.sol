// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// UCS Dictionary
import {DictionaryUpgradeableEtherscan as DictionaryUpgradeableEtherscanImpl} from "@ucs-contracts/src/dictionary/DictionaryUpgradeableEtherscan.sol";
import {DictionaryUpgradeableEtherscanProxy} from "@ucs-contracts/src/dictionary/DictionaryUpgradeableEtherscanProxy.sol";
import {DictionaryUpgradeable as DictionaryUpgradeableImpl} from "@ucs-contracts/src/dictionary/DictionaryUpgradeable.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {DictionaryEtherscan} from "@ucs-contracts/src/dictionary/DictionaryEtherscan.sol";
import {Dictionary as DictionaryContract} from "@ucs-contracts/src/dictionary/Dictionary.sol";
import {DictionaryBase} from "@ucs-contracts/src/dictionary/DictionaryBase.sol";

import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

import {IDictionary} from "@ucs-contracts/src/dictionary/IDictionary.sol";
import {ERC1967Utils} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Utils.sol";

import {DevUtils} from "dev-env/common/DevUtils.sol";
import {ForgeHelper, console2} from "dev-env/common/ForgeHelper.sol";

import {Dictionary, Proxy, Op, OpInfo, BundleOpsInfo} from "dev-env/UCSDevEnv.sol";

using {DictionaryUtils.asDictionary} for address;
using {DevUtils.exists} for address;

/***********************************************
    📚 Dictionary Primitive Utils
        🐣 Deploy Dictionary
        🔂 Duplicate Dictionary
        🧩 Set Op
        🖼 Upgrade Facade
        🔧 Helper Methods for type Dictionary
************************************************/
library DictionaryUtils {
    /**-------------------------
        🐣 Deploy Dictionary
    ---------------------------*/
    error DeployDictionary_UnnecessaryImplementation();
    function deployDictionary() internal returns(Dictionary) {
        return deployDictionary("DICTIONARY");
    }
    function deployDictionary(string memory name) internal returns(Dictionary) {
        /// @dev Until Etherscan supports UCS, we are deploying contracts with additional features for Etherscan compatibility by default.
        bool useEtherscanVerification = true;
        bool useUpgradeableDictionary = false;
        address implementation = address(0); // Note If not upgradeable, an implementation contract is not required.
        return deployDictionary(name, useEtherscanVerification, useUpgradeableDictionary, implementation);
    }
    function deployDictionary(string memory name, bool useEtherscanVerification, bool useUpgradeableDictionary, address implementation) internal returns(Dictionary) {
        address owner = ForgeHelper.msgSender();
        return deployDictionary(name, useEtherscanVerification, useUpgradeableDictionary, implementation, owner);
    }
    function deployDictionary(string memory name, bool useEtherscanVerification, bool useUpgradeableDictionary, address implementation, address owner) internal returns(Dictionary) {
        if (!useUpgradeableDictionary && implementation != address(0)) {
            revert DeployDictionary_UnnecessaryImplementation();
        }

        Dictionary dictionary;

        if (useEtherscanVerification && useUpgradeableDictionary) {
            dictionary = deployDictionaryUpgradeableEtherscan(implementation, owner);
        }
        if (!useEtherscanVerification && useUpgradeableDictionary) {
            dictionary = deployDictionaryUpgradeable(implementation, owner);
        }
        if (useEtherscanVerification && !useUpgradeableDictionary) {
            dictionary = deployDictionaryEtherscan(owner);
        }
        if (!useEtherscanVerification && !useUpgradeableDictionary) {
            dictionary = deployDictionary(owner);
        }

        return dictionary.assignLabel(name);
    }

    //  1️⃣ Upgradeable & Etherscan-verifiable Dictionary
    function deployDictionaryUpgradeableEtherscan(address implementation, address owner) internal returns(Dictionary) {
        bytes memory initData = abi.encodeCall(DictionaryUpgradeableEtherscanImpl.initialize, owner);
        return deployDictionaryUpgradeableEtherscanProxy({
            implementation: implementation,
            initData: initData
        });
    }
    function deployDictionaryUpgradeableEtherscanImpl() internal returns(address) {
        return address(new DictionaryUpgradeableEtherscanImpl());
    }
    function deployDictionaryUpgradeableEtherscanProxy(address implementation, bytes memory initData) internal returns(Dictionary) {
        return address(new DictionaryUpgradeableEtherscanProxy({
            implementation: implementation,
            _data: initData
        })).asDictionary();
    }

    // 2️⃣ Upgradeable Dictionary
    function deployDictionaryUpgradeable(address implementation, address owner) internal returns(Dictionary) {
        bytes memory initData = abi.encodeCall(DictionaryUpgradeableImpl.initialize, owner);
        return deployDictionaryUpgradeableProxy(implementation, initData);
    }
    function deployDictionaryUpgradeableImpl() internal returns(address) {
        return address(new DictionaryUpgradeableImpl());
    }
    function deployDictionaryUpgradeableProxy(address implementation, bytes memory initData) internal returns(Dictionary) {
        return address(new ERC1967Proxy({
            implementation: implementation,
            _data: initData
        })).asDictionary();
    }

    // 3️⃣🌟 Etherscan-verifiable Dictionary
    function deployDictionaryEtherscan(address owner) internal returns(Dictionary) {
        return address(new DictionaryEtherscan(owner)).asDictionary();
    }

    // 4️⃣ Dictionary
    function deployDictionary(address owner) internal returns(Dictionary) {
        return address(new DictionaryContract(owner)).asDictionary();
    }


    /**----------------------------
        🔂 Duplicate Dictionary
    ------------------------------*/
    function duplicate(Dictionary dictionary, string memory name) internal returns(Dictionary) {
        if (dictionary.toAddress().code.length == 0) DevUtils.revertWithDevEnvError("DuplicateDictionary_CannotDuplicateEmptyDictionary");
        return deployDictionary(name).duplicateOpsFrom(dictionary).assignLabel(name);
    }

    function duplicateOpsFrom(Dictionary toDictionary, Dictionary fromDictionary) internal returns(Dictionary) {
        address toAddr = toDictionary.toAddress();
        address fromAddr = fromDictionary.toAddress();

        bytes4[] memory _selectors = IDictionary(fromAddr).supportsInterfaces();
        for (uint i; i < _selectors.length; ++i) {
            bytes4 _selector = _selectors[i];
            if (_selector == bytes4(0)) continue;
            IDictionary(toAddr).setImplementation({
                functionSelector: _selector,
                implementation: IDictionary(fromAddr).getImplementation(_selector)
            });
        }

        return toDictionary;
    }


    /**----------------
        🧩 Set Op
    ------------------*/
    function set(Dictionary dictionary, Op memory op) internal returns(Dictionary) {
        IDictionary(dictionary.toAddress()).setImplementation({
            functionSelector: op.selector,
            implementation: op.implementation
        });
        return dictionary;
    }

    function set(Dictionary dictionary, BundleOpsInfo memory bundleOpsInfo) internal returns(Dictionary) {
        OpInfo[] memory opInfos = bundleOpsInfo.opInfos;
        for (uint i; i < opInfos.length; ++i) {
            dictionary.set(Op(opInfos[i].selector, opInfos[i].deployedContract));
        }
        if (dictionary.isEtherscanVerifiable()) {
            dictionary.upgradeFacade(bundleOpsInfo.facade);
        }
        return dictionary;
    }


    /**----------------------
        🖼 Upgrade Facade
    ------------------------*/
    function upgradeFacade(Dictionary dictionary, address newFacade) internal returns(Dictionary) {
        if (!dictionary.isEtherscanVerifiable()) DevUtils.revertWithDevEnvError("UpgradeFacade_NotEtherscanVerifiable");
        DictionaryUpgradeableEtherscanImpl(dictionary.toAddress()).upgradeFacade(newFacade);
        return dictionary;
    }


    /**------------------------------------------
        🔧 Helper Methods for type Dictionary
    --------------------------------------------*/
    function toAddress(Dictionary dictionary) internal pure returns(address) {
        return Dictionary.unwrap(dictionary);
    }

    function asDictionary(address addr) internal pure returns(Dictionary) {
        return Dictionary.wrap(addr);
    }

    function isEtherscanVerifiable(Dictionary dictionary) internal returns(bool) {
        (bool success,) = dictionary.toAddress().call(abi.encodeWithSignature("implementation()")); // TODO
        return success;
    }

    function isUUPS(Dictionary dictionary) internal returns(bool) {
        return UUPSUpgradeable(dictionary.toAddress()).proxiableUUID() == ERC1967Utils.IMPLEMENTATION_SLOT;
    }

    function exists(Dictionary dictionary) internal returns(bool) {
        return dictionary.toAddress().exists();
    }

    function assignLabel(Dictionary dictionary, string memory name) internal returns(Dictionary) {
        ForgeHelper.assignLabel(dictionary.toAddress(), name);
        return dictionary;
    }

    function assertSupports(Dictionary dictionary, bytes4 selector) internal returns(Dictionary) {
        // TODO change to IDictionary
        if (!DictionaryBase(dictionary.toAddress()).supportsInterface(selector)) {
            DevUtils.revertWithDevEnvError("Unsupport interface");
        }
        return dictionary;
    }

}

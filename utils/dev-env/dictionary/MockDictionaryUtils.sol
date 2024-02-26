// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// // UCS Dictionary
// import {DictionaryUpgradeableEtherscan as DictionaryUpgradeableEtherscanImpl} from "@ucs-contracts/src/dictionary/DictionaryUpgradeableEtherscan.sol";
// import {DictionaryUpgradeableEtherscanProxy} from "@ucs-contracts/src/dictionary/DictionaryUpgradeableEtherscanProxy.sol";
// import {DictionaryUpgradeable as DictionaryUpgradeableImpl} from "@ucs-contracts/src/dictionary/DictionaryUpgradeable.sol";
// import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

// TODO change to IDictionary Etherscan
import {DictionaryEtherscan} from "@ucs-contracts/src/dictionary/DictionaryEtherscan.sol";
// import {Dictionary} from "@ucs-contracts/src/dictionary/Dictionary.sol";

// TODO change to IDictionary
import {DictionaryBase} from "@ucs-contracts/src/dictionary/DictionaryBase.sol";

// import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

import {IDictionary} from "@ucs-contracts/src/dictionary/IDictionary.sol";
// import {ERC1967Utils} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Utils.sol";

import {DevUtils} from "dev-env/common/DevUtils.sol";
import {ForgeHelper, console2} from "dev-env/common/ForgeHelper.sol";

import {Dictionary, Proxy, Op, OpInfo, BundleOpsInfo, MockDictionary} from "dev-env/UCSDevEnv.sol";

import {MockDictionary as MockDictionaryContract} from "dev-env/test/mocks/MockDictionary.sol";

/***************************************************
    🤖📚 Mock Dictionary Primitive Utils
        🐣 Create Mock Dictionary
        🔧 Helper Methods for type MockDictionary
            🧩 Set Op
            🖼 Upgrade Facade
****************************************************/
library MockDictionaryUtils {
    using {DevUtils.exists} for address;
    using {asMockDictionary} for address;


    /**-----------------------------
        🐣 Create Mock Dictionary
    -------------------------------*/
    function createMockDictionary(address owner, Op[] memory ops) internal returns(MockDictionary) {
        return address(new MockDictionaryContract(owner, ops)).asMockDictionary();
    }


    /**----------------------------------------------
        🔧 Helper Methods for type MockDictionary
    ------------------------------------------------*/
    /*----- 🧩 Set Op -----*/
    function set(MockDictionary mockDictionary, Op memory op) internal returns(MockDictionary) {
        IDictionary(mockDictionary.toAddress()).setImplementation({
            functionSelector: op.selector,
            implementation: op.implementation
        });
        return mockDictionary;
    }

    /*----- 🖼 Upgrade Facade -----*/
    function upgradeFacade(MockDictionary mockDictionary, address newFacade) internal returns(MockDictionary) {
        DictionaryEtherscan(mockDictionary.toAddress()).upgradeFacade(newFacade);
        return mockDictionary;
    }


    function toAddress(MockDictionary mockDictionary) internal pure returns(address) {
        return MockDictionary.unwrap(mockDictionary);
    }

    function asMockDictionary(address addr) internal pure returns(MockDictionary) {
        return MockDictionary.wrap(addr);
    }

    function exists(MockDictionary mockDictionary) internal returns(bool) {
        return mockDictionary.toAddress().exists();
    }

    function assignLabel(MockDictionary mockDictionary, string memory name) internal returns(MockDictionary) {
        ForgeHelper.assignLabel(mockDictionary.toAddress(), name);
        return mockDictionary;
    }

    function assertSupports(MockDictionary mockDictionary, bytes4 selector) internal returns(MockDictionary) {
        // TODO change to IDictionary
        if (!DictionaryBase(mockDictionary.toAddress()).supportsInterface(selector)) {
            DevUtils.revertWithDevEnvError("Unsupport interface");
        }
        return mockDictionary;
    }

    // function isEtherscanVerifiable(Dictionary dictionary) internal returns(bool) {
    //     (bool success,) = dictionary.toAddress().call(abi.encodeWithSignature("implementation()")); // TODO
    //     return success;
    // }

    // function isUUPS(Dictionary dictionary) internal returns(bool) {
    //     return UUPSUpgradeable(dictionary.toAddress()).proxiableUUID() == ERC1967Utils.IMPLEMENTATION_SLOT;
    // }

}

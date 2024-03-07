// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "DevKit/common/Errors.sol";

// UCS Dictionary
import {DictionaryEtherscan} from "@ucs-contracts/src/dictionary/DictionaryEtherscan.sol";
import {IDictionary} from "@ucs-contracts/src/dictionary/IDictionary.sol";

import {IBeacon} from "@openzeppelin/contracts/proxy/beacon/IBeacon.sol";

import {DevUtils} from "DevKit/common/DevUtils.sol";
import {ForgeHelper, console2} from "DevKit/common/ForgeHelper.sol";
import {FuncInfo} from "../functions/FuncInfo.sol";
import {BundleInfo} from "../functions/BundleInfo.sol";
import {MockDictionary} from "./mocks/MockDictionary.sol";

import {ERC1967Utils} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Utils.sol";


/**---------------------------------
    📚 UCS Dictionary Primitive
-----------------------------------*/
using DictionaryUtils for Dictionary global;
struct Dictionary {
    address addr;
    DictionaryKind kind;
}
    using DictionaryKindUtils for DictionaryKind global;
    enum DictionaryKind {
        undefined,
        Verifiable,
        Mock
    }

library DictionaryUtils {
    using DevUtils for address;
    using DevUtils for bool;
    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        🚀 Deploy Dictionary
        🔂 Duplicate Dictionary
        🧩 Set Function
        🖼 Upgrade Facade
        🔧 Helper Methods for type Dictionary
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

    /**-------------------------
        🚀 Deploy Dictionary
    ---------------------------*/
    string constant safeDeploy_ = "Safe Deploy Dictionary";
    function safeDeploy(address owner) internal returns(Dictionary memory) {
        return deploy(owner.assertNotZeroAt(safeDeploy_));
    }
    function deploy(address owner) internal returns(Dictionary memory) {
        /// @dev Until Etherscan supports UCS, we are deploying contracts with additional features for Etherscan compatibility by default.
        return deployDictionaryVerifiable(owner);
    }
        function deployDictionaryVerifiable(address owner) internal returns(Dictionary memory) {
            return Dictionary({
                addr: address(new DictionaryEtherscan(owner)),
                kind: DictionaryKind.Verifiable
            });
        }

    /**----------------------------
        🔂 Duplicate Dictionary
    ------------------------------*/
    string constant duplicate_ = "Duplicate Dictionary";
    function safeDuplicate(Dictionary memory targetDictionary) internal returns(Dictionary memory) {
        return targetDictionary.assertNotEmptyAt(duplicate_).duplicate();
    }
    function duplicate(Dictionary memory targetDictionary) internal returns(Dictionary memory) {
        return deploy(ForgeHelper.msgSender())
                .duplicateFunctionsFrom(targetDictionary);
    }
        function duplicateFunctionsFrom(Dictionary memory toDictionary, Dictionary memory fromDictionary) internal returns(Dictionary memory) {
            address toAddr = toDictionary.toAddress();
            address fromAddr = fromDictionary.toAddress();

            bytes4[] memory _selectors = IDictionary(fromAddr).supportsInterfaces();
            for (uint i; i < _selectors.length; ++i) {
                bytes4 _selector = _selectors[i];
                if (_selector == bytes4(0)) continue; // TODO
                IDictionary(toAddr).setImplementation({
                    functionSelector: _selector,
                    implementation: IDictionary(fromAddr).getImplementation(_selector)
                });
            }

            return toDictionary;
        }


    /**--------------------
        🧩 Set Function
    ----------------------*/
    function set(Dictionary storage dictionary, FuncInfo memory functionInfo) internal returns(Dictionary storage) {
        IDictionary(dictionary.assertVerifiable("Set Function to Dictionary").toAddress()).setImplementation({
            functionSelector: functionInfo.selector,
            implementation: functionInfo.implementation
        });
        return dictionary;
    }


    /**------------------
        🧺 Set Bundle
    --------------------*/
    function set(Dictionary storage dictionary, BundleInfo memory bundleInfo) internal returns(Dictionary storage) {
        FuncInfo[] memory functionInfos = bundleInfo.functionInfos;

        for (uint i; i < functionInfos.length; ++i) {
            dictionary.set(functionInfos[i]);
        }

        if (dictionary.isVerifiable()) {
            dictionary.upgradeFacade(bundleInfo.facade);
        }

        return dictionary;
    }


    /**----------------------
        🖼 Upgrade Facade
    ------------------------*/
    function upgradeFacade(Dictionary storage dictionary, address newFacade) internal returns(Dictionary storage) {
        DictionaryEtherscan(dictionary.assertVerifiable("Upgrade Facade").toAddress()).upgradeFacade(newFacade);
        return dictionary;
    }


    /**------------------------------------------
        🔧 Helper Methods for type Dictionary
    --------------------------------------------*/
    function alloc(Dictionary storage target, Dictionary storage value) internal {
        target = value;
    }

    function toAddress(Dictionary memory dictionary) internal pure returns(address) {
        return dictionary.addr;
    }

    // function asDictionary(address addr) internal pure returns(Dictionary storage) {
    //     return Dictionary.wrap(addr);
    // }


    // function exists(Dictionary storage dictionary) internal returns(bool) {
    //     return dictionary.toAddress().exists();
    // }

    function assignLabel(Dictionary storage dictionary, string memory name) internal returns(Dictionary storage) {
        ForgeHelper.assignLabel(dictionary.toAddress(), name);
        return dictionary;
    }

    function assertSupports(Dictionary storage dictionary, bytes4 selector) internal returns(Dictionary storage) {
        if (!IDictionary(dictionary.toAddress()).supportsInterface(selector)) {
            throwError("Unsupport interface");
        }
        return dictionary;
    }

    function exists(Dictionary storage dictionary) internal returns(bool) {
        return dictionary.toAddress().isContract();
    }
    function assertExistsAt(Dictionary storage dictionary, string memory errorLocation) internal returns(Dictionary storage) {
        if (dictionary.toAddress().code.length == 0) throwError("Dictionary Not Exists");
        return dictionary;
    }

    function isNotEmpty(Dictionary memory dictionary) internal returns(bool) {
        return dictionary.toAddress().isContract();
    }
    function assertNotEmptyAt(Dictionary memory dictionary, string memory errorLocation) internal returns(Dictionary memory) {
        check(dictionary.isNotEmpty(), "Empty Dictionary", errorLocation);
        return dictionary;
    }

    function isVerifiable(Dictionary storage dictionary) internal returns(bool) {
        (bool success,) = dictionary.toAddress().call(abi.encodeWithSelector(IBeacon.implementation.selector));
        return success;
    }
    function assertVerifiable(Dictionary storage dictionary, string memory errorLocation) internal returns(Dictionary storage) {
        check(dictionary.isVerifiable(), "Dictionary Not Verifiable", errorLocation);
        return dictionary;
    }

    function isMock(Dictionary memory dictionary) internal returns(bool) {
        return dictionary.kind == DictionaryKind.Mock;
    }
    function isNotMock(Dictionary memory dictionary) internal returns(bool) {
        return dictionary.isMock().isNot();
    }

    // function isUUPS(Dictionary dictionary) internal returns(bool) {
    //     return UUPSUpgradeable(dictionary.toAddress()).proxiableUUID() == ERC1967Utils.IMPLEMENTATION_SLOT;
    // }


    /**------------------------------
        🤖 Create Mock Dictionary
    --------------------------------*/
    function createMockDictionary(address owner, FuncInfo[] memory functionInfos) internal returns(Dictionary memory) {
        return Dictionary({
            addr: address(new MockDictionary(owner, functionInfos)),
            kind: DictionaryKind.Mock
        });
    }


    // function toAddress(MockDictionary mockDictionary) internal pure returns(address) {
    //     return address(mockDictionary);
    // }

    // function asMockDictionary(address addr) internal pure returns(MockDictionary) {
    //     return MockDictionary(addr);
    // }

    // function asDictionary(MockDictionary mockDictionary) internal returns(Dictionary storage) {
    //     return mockDictionary.toAddress().asDictionary();
    // }

    // function exists(MockDictionary mockDictionary) internal returns(bool) {
    //     return mockDictionary.toAddress().isZero();
    // }
    // function assertExistsAt(MockDictionary mockDictionary, string memory errorLocation) internal returns(MockDictionary) {
    //     check(mockDictionary.exists(), "Mock Dictionary Not Exist", errorLocation);
    //     return mockDictionary;
    // }

    // function assignLabel(MockDictionary mockDictionary, string memory name) internal returns(MockDictionary) {
    //     ForgeHelper.assignLabel(mockDictionary.toAddress(), name);
    //     return mockDictionary;
    // }

    // function assertSupports(MockDictionary mockDictionary, bytes4 selector) internal returns(MockDictionary) {
    //     // TODO change to IDictionary
    //     if (!DictionaryEtherscan(mockDictionary.toAddress()).supportsInterface(selector)) {
    //         throwError("Unsupport interface");
    //     }
    //     return mockDictionary;
    // }
}

library DictionaryKindUtils {
    function isNotUndefined(DictionaryKind kind) internal returns(bool) {
        return kind != DictionaryKind.undefined;
    }
    function assertNotUndefinedAt(DictionaryKind kind, string memory errorLocation) internal returns(DictionaryKind) {
        check(kind.isNotUndefined(), "Undefined Dictionary Kind", errorLocation);
        return kind;
    }
}

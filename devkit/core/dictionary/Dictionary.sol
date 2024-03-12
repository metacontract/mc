// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Global Methods
import "@devkit/utils/GlobalMethods.sol"; // solhin-disable-line no-unused-import
// Utils
import {AddressUtils} from "@devkit/utils/AddressUtils.sol";
    using AddressUtils for address;
import {BoolUtils} from "@devkit/utils/BoolUtils.sol";
    using BoolUtils for bool;
import {Bytes4Utils} from "@devkit/utils/Bytes4Utils.sol";
    using Bytes4Utils for bytes4;
import {StringUtils} from "@devkit/utils/StringUtils.sol";
    using StringUtils for string;
import {ForgeHelper} from "@devkit/utils/ForgeHelper.sol";
// Debug
import {Debug} from "@devkit/debug/Debug.sol";
// Core
import {FuncInfo} from "@devkit/core/functions/FuncInfo.sol";
import {BundleInfo} from "@devkit/core/functions/BundleInfo.sol";
// Test
import {MockDictionary} from "@devkit/test/MockDictionary.sol";
// External Libs
import {DictionaryEtherscan} from "@ucs-contracts/src/dictionary/DictionaryEtherscan.sol";
import {IDictionary} from "@ucs-contracts/src/dictionary/IDictionary.sol";
import {IBeacon} from "@openzeppelin/contracts/proxy/beacon/IBeacon.sol";
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
    function __debug(string memory location) internal {
        Debug.start(location.append(" @ Dictionary Utils"));
    }

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
    function safeDeploy(address owner) internal returns(Dictionary memory) {
        __debug("Safe Deploy Dictionary");
        return deploy(owner.assertNotZero());
    }
    function deploy(address owner) internal returns(Dictionary memory) {
        __debug("Deploy Dictionary");
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
    function safeDuplicate(Dictionary memory targetDictionary) internal returns(Dictionary memory) {
        __debug("Safe Duplicate Dictionary");
        return targetDictionary.assertNotEmpty().duplicate();
    }
    function duplicate(Dictionary memory targetDictionary) internal returns(Dictionary memory) {
        __debug("Duplicate Dictionary");
        return deploy(ForgeHelper.msgSender())
                .duplicateFunctionsFrom(targetDictionary);
    }
        function duplicateFunctionsFrom(Dictionary memory toDictionary, Dictionary memory fromDictionary) internal returns(Dictionary memory) {
            __debug("Duplicate Functions from Dictionary");
            address toAddr = toDictionary.toAddress();
            address fromAddr = fromDictionary.toAddress();

            bytes4[] memory _selectors = IDictionary(fromAddr).supportsInterfaces();
            for (uint i; i < _selectors.length; ++i) {
                bytes4 _selector = _selectors[i];
                if (_selector.isEmpty()) continue;
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
        __debug("Set Function to Dictionary");
        IDictionary(dictionary.assertVerifiable().toAddress()).setImplementation({
            functionSelector: functionInfo.selector,
            implementation: functionInfo.implementation
        });
        return dictionary;
    }


    /**------------------
        🧺 Set Bundle
    --------------------*/
    function set(Dictionary storage dictionary, BundleInfo storage bundleInfo) internal returns(Dictionary storage) {
        __debug("Set Bundle to Dictionary");

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
        __debug("Upgrade Facade");
        DictionaryEtherscan(dictionary.assertVerifiable().toAddress()).upgradeFacade(newFacade);
        return dictionary;
    }


    /**------------------------------------------
        🔧 Helper Methods for type Dictionary
    --------------------------------------------*/
    function alloc(Dictionary storage target, Dictionary storage value) internal  {
        target = value;
    }

    function toAddress(Dictionary memory dictionary) internal  returns(address) {
        return dictionary.addr;
    }

    // function asDictionary(address addr) internal  returns(Dictionary storage) {
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
    function assertExists(Dictionary storage dictionary) internal returns(Dictionary storage) {
        if (dictionary.toAddress().code.length == 0) throwError("Dictionary Not Exists");
        return dictionary;
    }

    function isNotEmpty(Dictionary memory dictionary) internal returns(bool) {
        return dictionary.toAddress().isContract();
    }
    function assertNotEmpty(Dictionary memory dictionary) internal returns(Dictionary memory) {
        check(dictionary.isNotEmpty(), "Empty Dictionary");
        return dictionary;
    }

    function isVerifiable(Dictionary storage dictionary) internal returns(bool) {
        (bool success,) = dictionary.toAddress().call(abi.encodeWithSelector(IBeacon.implementation.selector));
        return success;
    }
    function assertVerifiable(Dictionary storage dictionary) internal returns(Dictionary storage) {
        check(dictionary.isVerifiable(), "Dictionary Not Verifiable");
        return dictionary;
    }

    function isMock(Dictionary memory dictionary) internal  returns(bool) {
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
        __debug("Create Mock Dictionary");
        return Dictionary({
            addr: address(new MockDictionary(owner, functionInfos)),
            kind: DictionaryKind.Mock
        });
    }


    // function toAddress(MockDictionary mockDictionary) internal  returns(address) {
    //     return address(mockDictionary);
    // }

    // function asMockDictionary(address addr) internal  returns(MockDictionary) {
    //     return MockDictionary(addr);
    // }

    // function asDictionary(MockDictionary mockDictionary) internal returns(Dictionary storage) {
    //     return mockDictionary.toAddress().asDictionary();
    // }

    // function exists(MockDictionary mockDictionary) internal returns(bool) {
    //     return mockDictionary.toAddress().isZero();
    // }
    // function assertExists(MockDictionary mockDictionary) internal returns(MockDictionary) {
    //     check(mockDictionary.exists(), "Mock Dictionary Not Exist");
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
    function assertNotUndefined(DictionaryKind kind) internal returns(DictionaryKind) {
        check(kind.isNotUndefined(), "Undefined Dictionary Kind");
        return kind;
    }
}

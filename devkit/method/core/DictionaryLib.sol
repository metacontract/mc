// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Validation
import {check} from "devkit/error/Validation.sol";
import {Params} from "devkit/debug/Params.sol";
// Utils
import {AddressUtils} from "devkit/utils/AddressUtils.sol";
    using AddressUtils for address;
import {BoolUtils} from "devkit/utils/BoolUtils.sol";
    using BoolUtils for bool;
import {Bytes4Utils} from "devkit/utils/Bytes4Utils.sol";
    using Bytes4Utils for bytes4;
import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;
import {ForgeHelper} from "devkit/utils/ForgeHelper.sol";
// Debug
import {Debug} from "devkit/debug/Debug.sol";
// Core
import {Function} from "devkit/core/Function.sol";
import {Bundle} from "devkit/core/Bundle.sol";
// Test
import {MockDictionary} from "devkit/test/MockDictionary.sol";
// External Libs
import {DictionaryEtherscan} from "@ucs.mc/dictionary/DictionaryEtherscan.sol";
import {IDictionary} from "@ucs.mc/dictionary/IDictionary.sol";
import {IBeacon} from "@oz.mc/proxy/beacon/IBeacon.sol";
import {ERC1967Utils} from "@oz.mc/proxy/ERC1967/ERC1967Utils.sol";


import {Dictionary, DictionaryKind} from "devkit/core/Dictionary.sol";
import {ProcessLib} from "devkit/method/debug/ProcessLib.sol";

/**------------------------
    📚 UCS Dictionary
--------------------------*/

/**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    << Primary >>
        🚀 Deploy Dictionary
        🔂 Duplicate Dictionary
        🧩 Set Function
        🪟 Upgrade Facade
        🤖 Create Mock Dictionary
    << Helper >>
        🧐 Inspectors & Assertions
        🐞 Debug
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
library DictionaryLib {
    /**-------------------------
        🚀 Deploy Dictionary
    ---------------------------*/
    function deploy(address owner) internal returns(Dictionary memory) {
        uint pid = ProcessLib.startDictionaryLibProcess("deploy");
        /// @dev Until Etherscan supports UCS, we are deploying contracts with additional features for Etherscan compatibility by default.
        return deployDictionaryVerifiable(owner).finishProcess(pid);
    }
        /**---------------------------
            Deploy Proxy Primitives
        -----------------------------*/
        function deployDictionaryVerifiable(address owner) internal returns(Dictionary memory) {
            return Dictionary({
                addr: address(new DictionaryEtherscan(owner)),
                kind: DictionaryKind.Verifiable
            });
        }

    function safeDeploy(address owner) internal returns(Dictionary memory) {
        uint pid = ProcessLib.startDictionaryLibProcess("safeDeploy");
        return deploy(owner.assertNotZero()).finishProcess(pid);
    }


    /**----------------------------
        🔂 Duplicate Dictionary
    ------------------------------*/
    function duplicate(Dictionary memory targetDictionary) internal returns(Dictionary memory) {
        uint pid = ProcessLib.startDictionaryLibProcess("duplicate");
        return deploy(ForgeHelper.msgSender())
                .duplicateFunctionsFrom(targetDictionary).finishProcess(pid);
    }
        function duplicateFunctionsFrom(Dictionary memory toDictionary, Dictionary memory fromDictionary) internal returns(Dictionary memory) {
            uint pid = ProcessLib.startDictionaryLibProcess("duplicateFunctionsFrom");
            address toAddr = toDictionary.addr;
            address fromAddr = fromDictionary.addr;

            bytes4[] memory _selectors = IDictionary(fromAddr).supportsInterfaces();
            for (uint i; i < _selectors.length; ++i) {
                bytes4 _selector = _selectors[i];
                if (_selector.isEmpty()) continue;
                IDictionary(toAddr).setImplementation({
                    functionSelector: _selector,
                    implementation: IDictionary(fromAddr).getImplementation(_selector)
                });
            }

            return toDictionary.finishProcess(pid);
        }
    function safeDuplicate(Dictionary memory targetDictionary) internal returns(Dictionary memory) {
        uint pid = ProcessLib.startDictionaryLibProcess("safeDuplicate");
        return targetDictionary.assertNotEmpty().duplicate().finishProcess(pid);
    }


    /**-----------------------------
        🧩 Set Function & Bundle
    -------------------------------*/
    function set(Dictionary memory dictionary, Function memory functionInfo) internal returns(Dictionary memory) {
        uint pid = ProcessLib.startDictionaryLibProcess("set", Params.append(functionInfo.name));
        IDictionary(dictionary.addr).setImplementation({
            functionSelector: functionInfo.selector,
            implementation: functionInfo.implementation
        });
        return dictionary.finishProcess(pid);
    }
    function set(Dictionary memory dictionary, Bundle storage bundleInfo) internal returns(Dictionary memory) {
        uint pid = ProcessLib.startDictionaryLibProcess("set", Params.append(bundleInfo.name));

        Function[] memory functionInfos = bundleInfo.functionInfos;

        for (uint i; i < functionInfos.length; ++i) {
            dictionary.set(functionInfos[i]);
        }

        // TODO Generate Facade
        // if (dictionary.isVerifiable()) {
        //     dictionary.upgradeFacade(bundleInfo.facade);
        // }

        return dictionary.finishProcess(pid);
    }


    /**----------------------
        🪟 Upgrade Facade
    ------------------------*/
    function upgradeFacade(Dictionary memory dictionary, address newFacade) internal returns(Dictionary memory) {
        uint pid = ProcessLib.startDictionaryLibProcess("upgradeFacade");
        DictionaryEtherscan(dictionary.assertVerifiable().addr).upgradeFacade(newFacade);
        return dictionary.finishProcess(pid);
    }


    /**------------------------------
        🤖 Create Mock Dictionary
    --------------------------------*/
    function createMockDictionary(address owner, Function[] memory functionInfos) internal returns(Dictionary memory) {
        uint pid = ProcessLib.startDictionaryLibProcess("createMockDictionary");
        return Dictionary({
            addr: address(new MockDictionary(owner, functionInfos)),
            kind: DictionaryKind.Mock
        }).finishProcess(pid);
    }



    /**-------------------------------
        🧐 Inspectors & Assertions
    ---------------------------------*/
    function exists(Dictionary storage dictionary) internal returns(bool) {
        return dictionary.addr.isContract();
    }
    function assertExists(Dictionary storage dictionary) internal returns(Dictionary storage) {
        check(dictionary.exists(), "Dictionary Not Exists");
        return dictionary;
    }

    function isNotEmpty(Dictionary memory dictionary) internal returns(bool) {
        return dictionary.addr.isContract();
    }
    function assertNotEmpty(Dictionary memory dictionary) internal returns(Dictionary memory) {
        check(dictionary.isNotEmpty(), "Empty Dictionary");
        return dictionary;
    }

    function isSupported(Dictionary memory dictionary, bytes4 selector) internal view returns(bool) {
        return IDictionary(dictionary.addr).supportsInterface(selector);
    }
    function assertSupports(Dictionary storage dictionary, bytes4 selector) internal returns(Dictionary storage) {
        check(dictionary.isSupported(selector), "Unsupported Selector");
        return dictionary;
    }

    function isVerifiable(Dictionary memory dictionary) internal returns(bool) {
        (bool success,) = dictionary.addr.call(abi.encodeWithSelector(IBeacon.implementation.selector));
        return success;
    }
    function assertVerifiable(Dictionary memory dictionary) internal returns(Dictionary memory) {
        check(dictionary.isVerifiable(), "Dictionary Not Verifiable");
        return dictionary;
    }

    function isMock(Dictionary memory dictionary) internal pure returns(bool) {
        return dictionary.kind == DictionaryKind.Mock;
    }
    function isNotMock(Dictionary memory dictionary) internal returns(bool) {
        return dictionary.isMock().isNot();
    }
    // function isUUPS(Dictionary dictionary) internal returns(bool) {
    //     return UUPSUpgradeable(dictionary.toAddress()).proxiableUUID() == ERC1967Utils.IMPLEMENTATION_SLOT;
    // }


    // function assignLabel(Dictionary storage dictionary, string memory name) internal returns(Dictionary storage) {
    //     ForgeHelper.assignLabel(dictionary.addr, name);
    //     return dictionary;
    // }
}

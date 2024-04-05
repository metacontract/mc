// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Validation
import {check} from "devkit/errors/Validation.sol";
// Utils
import {AddressUtils} from "../../utils/AddressUtils.sol";
    using AddressUtils for address;
import {BoolUtils} from "../../utils/BoolUtils.sol";
    using BoolUtils for bool;
import {Bytes4Utils} from "../../utils/Bytes4Utils.sol";
    using Bytes4Utils for bytes4;
import {StringUtils} from "../../utils/StringUtils.sol";
    using StringUtils for string;
import {ForgeHelper} from "../../utils/ForgeHelper.sol";
// Debug
import {Debug} from "../../debug/Debug.sol";
// Core
import {FuncInfo} from "../functions/FuncInfo.sol";
import {BundleInfo} from "../functions/BundleInfo.sol";
// Test
import {MockDictionary} from "../../test/MockDictionary.sol";
// External Libs
import {DictionaryEtherscan} from "@ucs.mc/dictionary/DictionaryEtherscan.sol";
import {IDictionary} from "@ucs.mc/dictionary/IDictionary.sol";
import {IBeacon} from "@oz.mc/proxy/beacon/IBeacon.sol";
import {ERC1967Utils} from "@oz.mc/proxy/ERC1967/ERC1967Utils.sol";


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
    string constant LIB_NAME = "Dictionary";

    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    << Primary >>
        🚀 Deploy Dictionary
        🔂 Duplicate Dictionary
        🧩 Set Function
        🖼 Upgrade Facade
        🤖 Create Mock Dictionary
    << Helper >>
        🧐 Inspectors & Assertions
        🐞 Debug
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/


    /**-------------------------
        🚀 Deploy Dictionary
    ---------------------------*/
    function deploy(address owner) internal returns(Dictionary memory) {
        uint pid = recordExecStart("deploy");
        /// @dev Until Etherscan supports UCS, we are deploying contracts with additional features for Etherscan compatibility by default.
        return deployDictionaryVerifiable(owner).recordExecFinish(pid);
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
        uint pid = recordExecStart("safeDeploy");
        return deploy(owner.assertNotZero()).recordExecFinish(pid);
    }


    /**----------------------------
        🔂 Duplicate Dictionary
    ------------------------------*/
    function duplicate(Dictionary memory targetDictionary) internal returns(Dictionary memory) {
        uint pid = recordExecStart("duplicate");
        return deploy(ForgeHelper.msgSender())
                .duplicateFunctionsFrom(targetDictionary).recordExecFinish(pid);
    }
        function duplicateFunctionsFrom(Dictionary memory toDictionary, Dictionary memory fromDictionary) internal returns(Dictionary memory) {
            uint pid = recordExecStart("duplicateFunctionsFrom");
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

            return toDictionary.recordExecFinish(pid);
        }
    function safeDuplicate(Dictionary memory targetDictionary) internal returns(Dictionary memory) {
        uint pid = recordExecStart("safeDuplicate");
        return targetDictionary.assertNotEmpty().duplicate().recordExecFinish(pid);
    }


    /**-----------------------------
        🧩 Set Function & Bundle
    -------------------------------*/
    function set(Dictionary memory dictionary, FuncInfo memory functionInfo) internal returns(Dictionary memory) {
        uint pid = recordExecStart("set");
        IDictionary(dictionary.addr).setImplementation({
            functionSelector: functionInfo.selector,
            implementation: functionInfo.implementation
        });
        return dictionary.recordExecFinish(pid);
    }
    function set(Dictionary memory dictionary, BundleInfo storage bundleInfo) internal returns(Dictionary memory) {
        uint pid = recordExecStart("set");

        FuncInfo[] memory functionInfos = bundleInfo.functionInfos;

        for (uint i; i < functionInfos.length; ++i) {
            dictionary.set(functionInfos[i]);
        }

        // TODO Generate Facade
        // if (dictionary.isVerifiable()) {
        //     dictionary.upgradeFacade(bundleInfo.facade);
        // }

        return dictionary.recordExecFinish(pid);
    }


    /**----------------------
        🖼 Upgrade Facade
    ------------------------*/
    function upgradeFacade(Dictionary memory dictionary, address newFacade) internal returns(Dictionary memory) {
        uint pid = recordExecStart("upgradeFacade");
        DictionaryEtherscan(dictionary.assertVerifiable().addr).upgradeFacade(newFacade);
        return dictionary.recordExecFinish(pid);
    }


    /**------------------------------
        🤖 Create Mock Dictionary
    --------------------------------*/
    function createMockDictionary(address owner, FuncInfo[] memory functionInfos) internal returns(Dictionary memory) {
        uint pid = recordExecStart("createMockDictionary");
        return Dictionary({
            addr: address(new MockDictionary(owner, functionInfos)),
            kind: DictionaryKind.Mock
        }).recordExecFinish(pid);
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


    /**----------------
        🐞 Debug
    ------------------*/
    /**
        Record Start
     */
    function recordExecStart(string memory funcName, string memory params) internal returns(uint) {
        return Debug.recordExecStart(LIB_NAME, funcName, params);
    }
    function recordExecStart(string memory funcName) internal returns(uint) {
        return recordExecStart(funcName, "");
    }
    function recordExecFinish(uint pid) internal {
        Debug.recordExecFinish(pid);
    }

    /**
        Record Finish
     */
    function recordExecFinish(Dictionary memory dictionary, uint pid) internal returns(Dictionary memory) {
        recordExecFinish(pid);
        return dictionary;
    }
    function recordExecFinishInStorage(Dictionary storage dictionary, uint pid) internal returns(Dictionary storage) {
        recordExecFinish(pid);
        return dictionary;
    }

    // function assignLabel(Dictionary storage dictionary, string memory name) internal returns(Dictionary storage) {
    //     ForgeHelper.assignLabel(dictionary.addr, name);
    //     return dictionary;
    // }
}

library DictionaryKindUtils {
    function isNotUndefined(DictionaryKind kind) internal pure returns(bool) {
        return kind != DictionaryKind.undefined;
    }
    function assertNotUndefined(DictionaryKind kind) internal returns(DictionaryKind) {
        check(kind.isNotUndefined(), "Undefined Dictionary Kind");
        return kind;
    }
}

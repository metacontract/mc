// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {ProcessLib} from "devkit/system/debug/Process.sol";
    using ProcessLib for Dictionary global;
import {Params} from "devkit/system/debug/Params.sol";
import {Inspector} from "devkit/types/Inspector.sol";
    using Inspector for Dictionary global;
    using Inspector for bytes4;
import {ForgeHelper} from "devkit/utils/ForgeHelper.sol";
// Validation
import {Validate} from "devkit/system/Validate.sol";
import {TypeGuard, TypeStatus} from "devkit/types/TypeGuard.sol";
    using TypeGuard for Dictionary global;

// Mock
import {DictionaryMock} from "devkit/mocks/DictionaryMock.sol";
// External Libs
import {IDictionary} from "@ucs.mc/dictionary/IDictionary.sol";
import {Dictionary as UCSDictionary} from "@ucs.mc/dictionary/Dictionary.sol";

// Core Types
import {Function} from "devkit/core/Function.sol";
import {Bundle} from "devkit/core/Bundle.sol";


/**====================
    📚 Dictionary
======================*/
using DictionaryLib for Dictionary global;
struct Dictionary {
    address addr;
    DictionaryKind kind;
    TypeStatus status;
}
library DictionaryLib {
    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        🚀 Deploy Dictionary
        🔂 Duplicate Dictionary
        🧩 Set Function or Bundle
        🪟 Upgrade Facade
        🤖 Create Dictionary Mock
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

    /**-------------------------
        🚀 Deploy Dictionary
    ---------------------------*/
    function deploy(address owner) internal returns(Dictionary memory) {
        uint pid = ProcessLib.startDictionaryLibProcess("deploy");
        Validate.MUST_AddressIsNotZero(owner);
        /// @dev Until Etherscan supports UCS, we are deploying contracts with additional features for Etherscan compatibility by default.
        return Dictionary({
            addr: address(new UCSDictionary(owner)),
            kind: DictionaryKind.Verifiable,
            status: TypeStatus.Building
        }).finishProcess(pid);
    }

    /**----------------------------
        🔂 Duplicate Dictionary
    ------------------------------*/
    function duplicate(Dictionary memory toDictionary, Dictionary memory fromDictionary) internal returns(Dictionary memory) {
        uint pid = ProcessLib.startDictionaryLibProcess("duplicate");
        Validate.MUST_haveContract(toDictionary);
        Validate.MUST_haveContract(fromDictionary);

        address toAddr = toDictionary.addr;
        address fromAddr = fromDictionary.addr;

        bytes4[] memory _selectors = IDictionary(fromAddr).supportsInterfaces();
        for (uint i; i < _selectors.length; ++i) {
            bytes4 _selector = _selectors[i];
            if (_selector.isEmpty()) continue;
            toDictionary.set(_selector, IDictionary(fromAddr).getImplementation(_selector));
        }

        return toDictionary.finishProcess(pid);
    }
    function duplicate(Dictionary memory fromDictionary) internal returns(Dictionary memory) {
        return duplicate(deploy(ForgeHelper.msgSender()), fromDictionary);
    }

    /**-----------------------------
        🧩 Set Function or Bundle
    -------------------------------*/
    function set(Dictionary memory dictionary, bytes4 selector, address implementation) internal returns(Dictionary memory) {
        uint pid = ProcessLib.startDictionaryLibProcess("set", Params.append(selector, implementation));
        Validate.MUST_haveContract(dictionary);
        Validate.MUST_Bytes4NotEmpty(selector);
        Validate.MUST_AddressIsContract(implementation);
        IDictionary(dictionary.addr).setImplementation({
            functionSelector: selector,
            implementation: implementation
        });
        return dictionary.finishProcess(pid);
    }
    function set(Dictionary memory dictionary, Function memory func) internal returns(Dictionary memory) {
        uint pid = ProcessLib.startDictionaryLibProcess("set", Params.append(func.name));
        return set(dictionary, func.selector, func.implementation).finishProcess(pid);
    }
    function set(Dictionary memory dictionary, Bundle storage bundle) internal returns(Dictionary memory) {
        uint pid = ProcessLib.startDictionaryLibProcess("set", Params.append(bundle.name));

        Function[] memory functions = bundle.functions;

        for (uint i; i < functions.length; ++i) {
            set(dictionary, functions[i]);
        }

        // TODO Generate Facade
        // if (dictionary.isVerifiable()) {
        //     dictionary.upgradeFacade(bundle.facade);
        // }

        return dictionary.finishProcess(pid);
    }

    /**----------------------
        🪟 Upgrade Facade
    ------------------------*/
    function upgradeFacade(Dictionary memory dictionary, address newFacade) internal returns(Dictionary memory) {
        uint pid = ProcessLib.startDictionaryLibProcess("upgradeFacade");
        Validate.MUST_AddressIsContract(newFacade);
        Validate.MUST_Verifiable(dictionary);
        IDictionary(dictionary.addr).upgradeFacade(newFacade);
        return dictionary.finishProcess(pid);
    }

    /**------------------------------
        🤖 Create Dictionary Mock
    --------------------------------*/
    function createMock(address owner, Function[] memory functions) internal returns(Dictionary memory) {
        uint pid = ProcessLib.startDictionaryLibProcess("createMock");
        return Dictionary({
            addr: address(new DictionaryMock(owner, functions)),
            kind: DictionaryKind.Mock,
            status: TypeStatus.Building
        }).finishProcess(pid);
    }

}


/**--------------------
    Dictionary Kind
----------------------*/
enum DictionaryKind {
    undefined,
    Verifiable,
    Mock
}
using Inspector for DictionaryKind global;

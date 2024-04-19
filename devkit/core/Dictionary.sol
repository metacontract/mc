// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {ProcessLib, params} from "devkit/system/debug/Process.sol";
import {Inspector} from "devkit/types/Inspector.sol";
import {TypeGuard, TypeStatus} from "devkit/types/TypeGuard.sol";
// Validation
import {Validate} from "devkit/system/Validate.sol";
// Util
import {ForgeHelper} from "devkit/utils/ForgeHelper.sol";

// External Libs
import {IDictionary} from "@ucs.mc/dictionary/IDictionary.sol";
import {Dictionary as UCSDictionary} from "@ucs.mc/dictionary/Dictionary.sol";
// Mock
import {DictionaryMock} from "devkit/mocks/DictionaryMock.sol";

// Core Types
import {Function} from "devkit/core/Function.sol";
import {Bundle} from "devkit/core/Bundle.sol";


//////////////////////////////////////////////////
//  📚 Dictionary   //////////////////////////////
    using DictionaryLib for Dictionary global;
    using ProcessLib for Dictionary global;
    using Inspector for Dictionary global;
    using TypeGuard for Dictionary global;
//////////////////////////////////////////////////
struct Dictionary {
    address addr;
    DictionaryKind kind;
    TypeStatus status;
}
library DictionaryLib {
    using Inspector for bytes4;
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
    function deploy(address owner) internal returns(Dictionary memory dictionary) {
        uint pid = dictionary.startProcess("deploy", params(owner));
        Validate.MUST_AddressIsNotZero(owner);
        dictionary.startBuilding();
        dictionary.addr = address(new UCSDictionary(owner));
        dictionary.kind = DictionaryKind.Verifiable;
        dictionary.finishBuilding();
        return dictionary.finishProcess(pid);
    }

    /**----------------------------
        🔂 Duplicate Dictionary
    ------------------------------*/
    function duplicate(Dictionary memory toDictionary, Dictionary memory fromDictionary) internal returns(Dictionary memory) {
        uint pid = toDictionary.startProcess("duplicate", params(toDictionary, fromDictionary));
        Validate.MUST_Completed(toDictionary);
        Validate.MUST_Completed(fromDictionary);

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
        uint pid = dictionary.startProcess("set", params(selector, implementation));
        Validate.MUST_Completed(dictionary);
        Validate.MUST_Bytes4NotEmpty(selector);
        Validate.MUST_AddressIsContract(implementation);
        IDictionary(dictionary.addr).setImplementation({
            functionSelector: selector,
            implementation: implementation
        });
        return dictionary.finishProcess(pid);
    }
    function set(Dictionary memory dictionary, Function memory func) internal returns(Dictionary memory) {
        uint pid = dictionary.startProcess("set", params(func));
        return set(dictionary, func.selector, func.implementation).finishProcess(pid);
    }
    function set(Dictionary memory dictionary, Bundle storage bundle) internal returns(Dictionary memory) {
        uint pid = dictionary.startProcess("set", params(bundle));

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
        uint pid = dictionary.startProcess("upgradeFacade", params(dictionary, newFacade));
        Validate.MUST_AddressIsContract(newFacade);
        Validate.MUST_Verifiable(dictionary);
        IDictionary(dictionary.addr).upgradeFacade(newFacade);
        return dictionary.finishProcess(pid);
    }

    /**------------------------------
        🤖 Create Dictionary Mock
    --------------------------------*/
    function createMock(address owner, Function[] memory functions) internal returns(Dictionary memory dictionary) {
        uint pid = dictionary.startProcess("createMock", params(functions));
        for (uint i; i < functions.length; ++i) {
            Validate.MUST_Completed(functions[i]);
        }
        dictionary.startBuilding();
        dictionary.addr = address(new DictionaryMock(owner, functions));
        dictionary.kind = DictionaryKind.Mock;
        dictionary.finishBuilding();
        return dictionary.finishProcess(pid);
    }

    /**
        Load
     */
    function load(address dictionary) internal returns(Dictionary memory _dictionary) {
        uint pid = _dictionary.startProcess("load", params(dictionary));
        Validate.MUST_AddressIsNotZero(dictionary);
        // TODO Validate
        _dictionary.startBuilding();
        _dictionary.addr = dictionary;
        _dictionary.kind = DictionaryKind.Verifiable;
        _dictionary.finishBuilding();
        return _dictionary.finishProcess(pid);
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

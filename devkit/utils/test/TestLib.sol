// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**--------------------------
    Apply Support Methods
----------------------------*/

// Core Type
import {Proxy} from "devkit/core/Proxy.sol";


/**===============
    🏠 Proxy
=================*/
library TestLib {
    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        🚀 Deploy Proxy
        🧪 Test Utils
        🤖 Create Mock Proxy
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

    /**-------------------
        🧪 Test Utils
    ---------------------*/
    function loadDictionary(Proxy storage proxy) internal returns(Dictionary storage) {
        return ForgeHelper.loadAddress(proxy.addr, ERC7546Utils.DICTIONARY_SLOT).asDictionary();
    }

    function changeDictionary(Proxy storage proxy) internal {}

    function injectCode(address target, bytes memory runtimeBytecode) internal {
        // vm.assume(runtimeBytecode.length > 0);
        vm.etch(target, runtimeBytecode);
    }

    function injectDictionary(address target, address dictionary) internal {
        injectAddressToStorage(target, ERC7546Utils.DICTIONARY_SLOT, dictionary);
    }

    function injectAddressToStorage(address target, bytes32 slot, address addr) internal {
        vm.store(target, slot, bytes32(uint256(uint160(addr))));
    }

}

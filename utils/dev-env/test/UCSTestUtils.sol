// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "dev-env/UCSDevEnv.sol";

// import {UCSDevEnv} from "dev-env/UCSDevEnv.sol";
// import {MockProxy, MockProxyUtils} from "dev-env/test/MockUtils.sol";
// import {MockProxy as MockProxyContract} from "dev-env/test/mocks/MockProxy.sol";
import {ForgeHelper, vm, console2} from "dev-env/common/ForgeHelper.sol";

import {ERC7546Utils} from "@ucs-contracts/src/proxy/ERC7546Utils.sol";

library UCSTestUtils {
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

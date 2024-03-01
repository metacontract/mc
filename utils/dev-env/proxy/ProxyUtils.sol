// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// import {DictionaryUpgradeableEtherscan} from "@ucs-contracts/src/dictionary/DictionaryUpgradeableEtherscan.sol";
// import {DictionaryUpgradeableEtherscanProxy} from "@ucs-contracts/src/dictionary/DictionaryUpgradeableEtherscanProxy.sol";
// import {DictionaryBase} from "@ucs-contracts/src/dictionary/DictionaryBase.sol";
// import {IDictionary} from "@ucs-contracts/src/dictionary/IDictionary.sol";
import {ERC7546Utils} from "@ucs-contracts/src/proxy/ERC7546Utils.sol";
import {ERC7546Proxy} from "@ucs-contracts/src/proxy/ERC7546Proxy.sol";
import {ERC7546ProxyEtherscan} from "@ucs-contracts/src/proxy/ERC7546ProxyEtherscan.sol";

// // Ops
import {InitSetAdminOp} from "../../../src/ops/InitSetAdminOp.sol";

import {StdOpsUtils} from "dev-env/ops/StdOpsUtils.sol";
import {StdOpsArgs} from "dev-env/ops/StdOpsArgs.sol";

import {ForgeHelper, console2} from "dev-env/common/ForgeHelper.sol";
import {DevUtils} from "dev-env/common/DevUtils.sol";
import {Proxy, Dictionary} from "dev-env/UCSDevEnv.sol";
import {DictionaryUtils} from "dev-env/dictionary/DictionaryUtils.sol";

/********************************************
    🏠 Proxy Primitive Utils
        🐣 Deploy Proxy
        🔧 Helper Methods for type Proxy
*********************************************/
library ProxyUtils {
    using {DictionaryUtils.asDictionary} for address;
    using {ProxyUtils.asProxy} for address;
    using {DevUtils.exists} for address;


    /**---------------------
        🐣 Deploy Proxy
    -----------------------*/
    function deployProxy(Dictionary dictionary) internal returns(Proxy) {
        return deployProxy("PROXY", dictionary);
    }

    function deployProxy(string memory name, Dictionary dictionary) internal returns(Proxy) {
        return deployProxy(name, dictionary, ForgeHelper.msgSender());
    }

    function deployProxy(string memory name, Dictionary dictionary, address owner) internal returns(Proxy) {
        dictionary.assertSupports(InitSetAdminOp.initSetAdmin.selector);
        bytes memory initData = StdOpsArgs.initSetAdminBytes(owner);
        // bytes memory initData = StdOpsUtils.getCalldataInitSetAdmin(owner);
        return deployProxy(name, dictionary, initData);
    }

    function deployProxy(string memory name, Dictionary dictionary, bytes memory initData) internal returns(Proxy) {
        Proxy proxy;

        if (dictionary.isEtherscanVerifiable()) {
            proxy = deployProxyEtherscan(dictionary, initData);
        } else {
            proxy = deployProxyContract(dictionary, initData);
        }

        return proxy.assignLabel(name);
    }

        /**---------------------------
            Deploy Proxy Primitives
        -----------------------------*/
        function deployProxyEtherscan(Dictionary dictionary, bytes memory initData) internal returns(Proxy) {
            return address(new ERC7546ProxyEtherscan(dictionary.toAddress(), initData)).asProxy();
        }

        function deployProxyContract(Dictionary dictionary, bytes memory initData) internal returns(Proxy) {
            return address(new ERC7546Proxy(dictionary.toAddress(), initData)).asProxy();
        }


    /**------------------------------------
        🔧 Helper Methods for type Proxy
    --------------------------------------*/
    function toAddress(Proxy proxy) internal pure returns(address) {
        return Proxy.unwrap(proxy);
    }

    function asProxy(address addr) internal pure returns(Proxy) {
        return Proxy.wrap(addr);
    }

    function getDictionary(Proxy proxy) internal returns(Dictionary) {
        return ForgeHelper.loadAddress(proxy.toAddress(), ERC7546Utils.DICTIONARY_SLOT).asDictionary();
    }

    function changeDictionary(Proxy proxy) internal {}

    function exists(Proxy proxy) internal returns(bool) {
        return proxy.toAddress().exists();
    }

    function assignLabel(Proxy proxy, string memory name) internal returns(Proxy) {
        ForgeHelper.assignLabel(proxy.toAddress(), name);
        return proxy;
    }

}

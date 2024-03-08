// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "DevKit/common/Errors.sol";

import {ERC7546Utils} from "@ucs-contracts/src/proxy/ERC7546Utils.sol";
import {ERC7546Proxy} from "@ucs-contracts/src/proxy/ERC7546Proxy.sol";
import {ERC7546ProxyEtherscan} from "@ucs-contracts/src/proxy/ERC7546ProxyEtherscan.sol";

// Functions
import {InitSetAdmin} from "~/std/functions/InitSetAdmin.sol";

import {MCStdFuncs} from "../functions/MCStdFuncs.sol";

import {ForgeHelper, console2} from "DevKit/common/ForgeHelper.sol";
import {DevUtils} from "DevKit/common/DevUtils.sol";
import {Dictionary, DictionaryUtils} from "../dictionary/Dictionary.sol";
import {FuncInfo} from "DevKit/functions/FuncInfo.sol";

import {SimpleMockProxy} from "./mocks/SimpleMockProxy.sol";

/**---------------------------
    🏠 UCS Proxy Primitive
-----------------------------*/
using ProxyUtils for Proxy global;
struct Proxy {
    address addr;
    ProxyKind kind;
}
    using ProxyKindUtils for ProxyKind global;
    enum ProxyKind {
        undefined,
        Normal,
        Verifiable,
        Mock
    }

library ProxyUtils {
    using DevUtils for address;
    using DevUtils for bool;
    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        🚀 Deploy Proxy
        🔧 Helper Methods for type Proxy
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

    /**---------------------
        🚀 Deploy Proxy
    -----------------------*/
    function deploy(Dictionary storage dictionary, bytes memory initData) internal returns(Proxy memory) {
        return dictionary.isVerifiable() ?
                    deployProxyVerifiable(dictionary, initData) :
                    deployProxy(dictionary, initData);
    }
        /**---------------------------
            Deploy Proxy Primitives
        -----------------------------*/
        function deployProxyVerifiable(Dictionary storage dictionary, bytes memory initData) internal returns(Proxy memory) {
            return Proxy({
                addr: address(new ERC7546ProxyEtherscan(dictionary.toAddress(), initData)),
                kind: ProxyKind.Verifiable
            });
        }

        function deployProxy(Dictionary storage dictionary, bytes memory initData) internal returns(Proxy memory) {
            return Proxy({
                addr: address(new ERC7546Proxy(dictionary.toAddress(), initData)),
                kind: ProxyKind.Normal
            });
        }


    /**------------------------------------
        🔧 Helper Methods for type Proxy
    --------------------------------------*/
    function alloc(Proxy storage target, Proxy storage value) internal {
        target = value;
    }

    function toAddress(Proxy memory proxy) internal pure returns(address) {
        return proxy.addr;
    }

    // function asProxy(address addr) internal pure returns(Proxy storage) {
    //     return Proxy.wrap(addr);
    // }

    // function loadDictionary(Proxy storage proxy) internal returns(Dictionary storage) {
    //     return ForgeHelper.loadAddress(proxy.toAddress(), ERC7546Utils.DICTIONARY_SLOT).asDictionary();
    // }

    function changeDictionary(Proxy storage proxy) internal {}

    function exists(Proxy storage proxy) internal returns(bool) {
        return proxy.toAddress().isContract();
    }
    function assertExists(Proxy storage proxy) internal returns(Proxy storage) {
        check(proxy.exists(), "Proxy Not Exist");
        return proxy;
    }

    function isNotEmpty(Proxy memory proxy) internal returns(bool) {
        return proxy.toAddress().isContract();
    }
    function assertNotEmpty(Proxy memory proxy) internal returns(Proxy memory) {
        check(proxy.isNotEmpty(), "Empty Proxy");
        return proxy;
    }

    function isMock(Proxy memory proxy) internal returns(bool) {
        return proxy.kind == ProxyKind.Mock;
    }
    function isNotMock(Proxy memory proxy) internal returns(bool) {
        return proxy.isMock().isNot();
    }

    function assignLabel(Proxy storage proxy, string memory name) internal returns(Proxy storage) {
        ForgeHelper.assignLabel(proxy.toAddress(), name);
        return proxy;
    }

    /**-------------------------
        🤖 Create Mock Proxy
    ---------------------------*/
    function createSimpleMockProxy(FuncInfo[] memory functionInfos) internal returns(Proxy memory) {
        return Proxy({
            addr: address(new SimpleMockProxy(functionInfos)),
            kind: ProxyKind.Mock
        });
    }

}

library ProxyKindUtils {
    function isNotUndefined(ProxyKind kind) internal returns(bool) {
        return kind != ProxyKind.undefined;
    }
    function assertNotUndefined(ProxyKind kind) internal returns(ProxyKind) {
        check(kind.isNotUndefined(), "Undefined Proxy Kind");
        return kind;
    }
}

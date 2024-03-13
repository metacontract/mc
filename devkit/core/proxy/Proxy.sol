// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Global Methods
import "@devkit/utils/GlobalMethods.sol";
// Utils
import {AddressUtils} from "@devkit/utils/AddressUtils.sol";
    using AddressUtils for address;
import {BoolUtils} from "@devkit/utils/BoolUtils.sol";
    using BoolUtils for bool;
import {StringUtils} from "@devkit/utils/StringUtils.sol";
    using StringUtils for string;
import {ForgeHelper} from "@devkit/utils/ForgeHelper.sol";
// Core
// import {MCStdFuncs} from "@devkit/core/functions/MCStdFuncs.sol";
import {Dictionary} from "@devkit/core/dictionary/Dictionary.sol";
import {FuncInfo} from "@devkit/core/functions/FuncInfo.sol";
// Test
import {SimpleMockProxy} from "@devkit/test/SimpleMockProxy.sol";
// External Lib
import {ERC7546Utils} from "@ucs-contracts/src/proxy/ERC7546Utils.sol";
import {ERC7546Proxy} from "@ucs-contracts/src/proxy/ERC7546Proxy.sol";
import {ERC7546ProxyEtherscan} from "@ucs-contracts/src/proxy/ERC7546ProxyEtherscan.sol";

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
    string constant LIB_NAME = "Proxy";
    function __recordExecStart(string memory funcName, string memory params) internal returns(uint) {
        return Debug.recordExecStart(LIB_NAME, funcName, params);
    }
    function __recordExecStart(string memory funcName) internal returns(uint) {
        return __recordExecStart(funcName, "");
    }
    function __recordExecFinish(uint pid) internal {
        Debug.recordExecFinish(pid);
    }
    function __recordExecFinish(Proxy memory proxy, uint pid) internal returns(Proxy memory) {
        __recordExecFinish(pid);
        return proxy;
    }

    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        🚀 Deploy Proxy
        🔧 Helper Methods for type Proxy
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

    /**---------------------
        🚀 Deploy Proxy
    -----------------------*/
    function deploy(Dictionary storage dictionary, bytes memory initData) internal returns(Proxy memory proxy) {
        uint pid = __recordExecStart("deploy");
        proxy = dictionary.isVerifiable() ?
                    deployProxyVerifiable(dictionary, initData) :
                    deployProxy(dictionary, initData);
        return proxy.__recordExecFinish(pid);
    }
        /**---------------------------
            Deploy Proxy Primitives
        -----------------------------*/
        function deployProxyVerifiable(Dictionary storage dictionary, bytes memory initData) internal returns(Proxy memory) {
            return Proxy({
                addr: address(new ERC7546ProxyEtherscan(dictionary.addr, initData)),
                kind: ProxyKind.Verifiable
            });
        }

        function deployProxy(Dictionary storage dictionary, bytes memory initData) internal returns(Proxy memory) {
            return Proxy({
                addr: address(new ERC7546Proxy(dictionary.addr, initData)),
                kind: ProxyKind.Normal
            });
        }


    /**------------------------------------
        🔧 Helper Methods for type Proxy
    --------------------------------------*/
    function alloc(Proxy storage target, Proxy storage value) internal {
        target = value;
    }

    function toAddress(Proxy memory proxy) internal  returns(address) {
        return proxy.addr;
    }

    // function asProxy(address addr) internal  returns(Proxy storage) {
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
        uint pid = __recordExecStart("createSimpleMockProxy");
        return Proxy({
            addr: address(new SimpleMockProxy(functionInfos)),
            kind: ProxyKind.Mock
        }).__recordExecFinish(pid);
    }

}

library ProxyKindUtils {
    function isNotUndefined(ProxyKind kind) internal pure returns(bool) {
        return kind != ProxyKind.undefined;
    }
    function assertNotUndefined(ProxyKind kind) internal returns(ProxyKind) {
        check(kind.isNotUndefined(), "Undefined Proxy Kind");
        return kind;
    }
}

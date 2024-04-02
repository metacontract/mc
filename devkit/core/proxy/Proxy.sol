// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Global Methods
import "../../utils/GlobalMethods.sol";
// Utils
import {AddressUtils} from "../../utils/AddressUtils.sol";
    using AddressUtils for address;
import {BoolUtils} from "../../utils/BoolUtils.sol";
    using BoolUtils for bool;
import {StringUtils} from "../../utils/StringUtils.sol";
    using StringUtils for string;
import {ForgeHelper} from "../../utils/ForgeHelper.sol";
// Core
// import {MCStdFuncs} from "../../core/functions/MCStdFuncs.sol";
import {Dictionary} from "../dictionary/Dictionary.sol";
import {FuncInfo} from "../functions/FuncInfo.sol";
// Test
import {SimpleMockProxy} from "../../test/SimpleMockProxy.sol";
// External Lib
import {ERC7546Utils} from "@ucs.mc/proxy/ERC7546Utils.sol";
import {ERC7546Proxy} from "@ucs.mc/proxy/ERC7546Proxy.sol";
import {ERC7546ProxyEtherscan} from "@ucs.mc/proxy/ERC7546ProxyEtherscan.sol";


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

    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    << Primary >>
        🚀 Deploy Proxy
        🤖 Create Mock Proxy
    << Helper >>
        🧪 Test Utils
        🐞 Debug
        🧐 Inspectors & Assertions
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/


    /**---------------------
        🚀 Deploy Proxy
    -----------------------*/
    function deploy(Dictionary storage dictionary, bytes memory initData) internal returns(Proxy memory proxy) {
        uint pid = recordExecStart("deploy");
        // Note Temporarily disable (see details in https://github.com/metacontract/mc/issues/16)
        // proxy = dictionary.isVerifiable() ?
        //             deployProxyVerifiable(dictionary, initData) :
        //             deployProxy(dictionary, initData);
        proxy = deployProxyVerifiable(dictionary, initData);
        return proxy.recordExecFinish(pid);
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

    function safeDeploy(Dictionary storage dictionary, bytes memory initData) internal returns(Proxy memory) {
        uint pid = recordExecStart("safeDeploy");
        return deploy(dictionary.assertExists(), initData).recordExecFinish(pid);
    }


    /**-------------------------
        🤖 Create Mock Proxy
    ---------------------------*/
    function createSimpleMockProxy(FuncInfo[] memory functionInfos) internal returns(Proxy memory) {
        uint pid = recordExecStart("createSimpleMockProxy");
        return Proxy({
            addr: address(new SimpleMockProxy(functionInfos)),
            kind: ProxyKind.Mock
        }).recordExecFinish(pid);
    }



    /**-------------------
        🧪 Test Utils
    ---------------------*/
    // function loadDictionary(Proxy storage proxy) internal returns(Dictionary storage) {
    //     return ForgeHelper.loadAddress(proxy.addr, ERC7546Utils.DICTIONARY_SLOT).asDictionary();
    // }

    // function changeDictionary(Proxy storage proxy) internal {}


    /**-------------------------------
        🧐 Inspectors & Assertions
    ---------------------------------*/
    function exists(Proxy storage proxy) internal returns(bool) {
        return proxy.addr.isContract();
    }
    function assertExists(Proxy storage proxy) internal returns(Proxy storage) {
        check(proxy.exists(), "Proxy Not Exist");
        return proxy;
    }

    function isNotEmpty(Proxy memory proxy) internal returns(bool) {
        return proxy.addr.isContract();
    }
    function assertNotEmpty(Proxy memory proxy) internal returns(Proxy memory) {
        check(proxy.isNotEmpty(), "Empty Proxy");
        return proxy;
    }

    function isMock(Proxy memory proxy) internal pure returns(bool) {
        return proxy.kind == ProxyKind.Mock;
    }
    function isNotMock(Proxy memory proxy) internal returns(bool) {
        return proxy.isMock().isNot();
    }

    function assignLabel(Proxy storage proxy, string memory name) internal returns(Proxy storage) {
        ForgeHelper.assignLabel(proxy.addr, name);
        return proxy;
    }


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

    /**
        Record Finish
     */
    function recordExecFinish(uint pid) internal {
        Debug.recordExecFinish(pid);
    }
    function recordExecFinish(Proxy memory proxy, uint pid) internal returns(Proxy memory) {
        recordExecFinish(pid);
        return proxy;
    }
    function recordExecFinishInStorage(Proxy storage proxy, uint pid) internal returns(Proxy storage) {
        recordExecFinish(pid);
        return proxy;
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

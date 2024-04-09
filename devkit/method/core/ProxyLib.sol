// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Errors & Debug
import {check} from "devkit/error/Validation.sol";
import {Debug} from "devkit/debug/Debug.sol";
// Utils
import {AddressUtils} from "devkit/utils/AddressUtils.sol";
    using AddressUtils for address;
import {BoolUtils} from "devkit/utils/BoolUtils.sol";
    using BoolUtils for bool;
import {StringUtils} from "devkit/utils/StringUtils.sol";
    using StringUtils for string;
import {ForgeHelper} from "devkit/utils/ForgeHelper.sol";
// Core
// import {MCStdFuncs} from "devkit/core/functions/MCStdFuncs.sol";
import {Dictionary} from "devkit/core/Dictionary.sol";
import {Function} from "devkit/core/Function.sol";
// Test
import {SimpleMockProxy} from "devkit/test/SimpleMockProxy.sol";
// External Lib
import {ERC7546Utils} from "@ucs.mc/proxy/ERC7546Utils.sol";
import {ERC7546Proxy} from "@ucs.mc/proxy/ERC7546Proxy.sol";
import {ERC7546ProxyEtherscan} from "@ucs.mc/proxy/ERC7546ProxyEtherscan.sol";


import {Proxy, ProxyKind} from "devkit/core/Proxy.sol";
import {ProcessLib} from "devkit/method/debug/ProcessLib.sol";

/**---------------
    🏠 Proxy
-----------------*/

/**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    << Primary >>
        🚀 Deploy Proxy
        🤖 Create Mock Proxy
    << Helper >>
        🧪 Test Utils
        🐞 Debug
        🧐 Inspectors & Assertions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
library ProxyLib {


    /**---------------------
        🚀 Deploy Proxy
    -----------------------*/
    function deploy(Dictionary memory dictionary, bytes memory initData) internal returns(Proxy memory proxy) {
        uint pid = ProcessLib.startProxyLibProcess("deploy");
        // Note Temporarily disable (see details in https://github.com/metacontract/mc/issues/16)
        // proxy = dictionary.isVerifiable() ?
        //             deployProxyVerifiable(dictionary, initData) :
        //             deployProxy(dictionary, initData);
        proxy = deployProxyVerifiable(dictionary, initData);
        return proxy.finishProcess(pid);
    }
        /**---------------------------
            Deploy Proxy Primitives
        -----------------------------*/
        function deployProxyVerifiable(Dictionary memory dictionary, bytes memory initData) internal returns(Proxy memory) {
            return Proxy({
                addr: address(new ERC7546ProxyEtherscan(dictionary.addr, initData)),
                kind: ProxyKind.Verifiable
            });
        }

        function deployProxy(Dictionary memory dictionary, bytes memory initData) internal returns(Proxy memory) {
            return Proxy({
                addr: address(new ERC7546Proxy(dictionary.addr, initData)),
                kind: ProxyKind.Normal
            });
        }

    function safeDeploy(Dictionary storage dictionary, bytes memory initData) internal returns(Proxy memory) {
        uint pid = ProcessLib.startProxyLibProcess("safeDeploy");
        return deploy(dictionary.assertExists(), initData).finishProcess(pid);
    }


    /**-------------------------
        🤖 Create Mock Proxy
    ---------------------------*/
    function createSimpleMockProxy(Function[] memory functionInfos) internal returns(Proxy memory) {
        uint pid = ProcessLib.startProxyLibProcess("createSimpleMockProxy");
        return Proxy({
            addr: address(new SimpleMockProxy(functionInfos)),
            kind: ProxyKind.Mock
        }).finishProcess(pid);
    }



    /**-------------------
        🧪 Test Utils
    ---------------------*/
    // function loadDictionary(Proxy storage proxy) internal returns(Dictionary storage) {
    //     return ForgeHelper.loadAddress(proxy.addr, ERC7546Utils.DICTIONARY_SLOT).asDictionary();
    // }

    // function changeDictionary(Proxy storage proxy) internal {}

}

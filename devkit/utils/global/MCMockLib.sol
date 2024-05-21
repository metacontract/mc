// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;
// Validation
import {Validator} from "devkit/system/Validator.sol";

import {MCDevKit} from "devkit/MCDevKit.sol";
import {System} from "devkit/system/System.sol";
// Utils
import {param} from "devkit/system/Tracer.sol";
import {ForgeHelper} from "devkit/utils/ForgeHelper.sol";
// Core
//  functions
import {Bundle} from "devkit/core/Bundle.sol";
import {Function} from "devkit/core/Function.sol";
//  proxy
import {Proxy, ProxyLib} from "devkit/core/Proxy.sol";
//  dictionary
import {Dictionary, DictionaryLib} from "devkit/core/Dictionary.sol";


/*************************************
 *  🎭 Mock
 *      🌞 Mocking Meta Contract
 *      🏠 Mocking Proxy
 *      📚 Mocking Dictionary
**************************************/
library MCMockLib {

    /**-----------------------------
        🌞 Mocking Meta Contract
    -------------------------------*/


    /**---------------------
        🏠 Mocking Proxy
    -----------------------*/
    function createMockProxy(MCDevKit storage mc, Bundle storage bundle, bytes memory initData) internal returns(Proxy storage mockProxy) {
        uint pid = mc.startProcess("createMockProxy", param(bundle, initData));
        Validator.MUST_Completed(bundle);
        Proxy memory _mockProxy = ProxyLib.createSimpleMock(bundle.functions);
        mockProxy = mc.proxy.register(mc.proxy.genUniqueMockName(bundle.name), _mockProxy);
        mc.finishProcess(pid);
    }
    function createMockProxy(MCDevKit storage mc, Bundle storage bundle) internal returns(Proxy storage mockProxy) {
        uint pid = mc.startProcess("createMockProxy", param(bundle));
        mockProxy = mc.createMockProxy(bundle, "");
        mc.finishProcess(pid);
    }
    function createMockProxy(MCDevKit storage mc, bytes memory initData) internal returns(Proxy storage mockProxy) {
        uint pid = mc.startProcess("createMockProxy", param(initData));
        mockProxy = mc.createMockProxy(mc.bundle.findCurrent(), initData);
        mc.finishProcess(pid);
    }
    function createMockProxy(MCDevKit storage mc) internal returns(Proxy storage mockProxy) {
        uint pid = mc.startProcess("createMockProxy");
        mockProxy = mc.createMockProxy(mc.bundle.findCurrent(), "");
        mc.finishProcess(pid);
    }


    /**-------------------------
        📚 Mocking Dictionary
    ---------------------------*/
    function createMockDictionary(MCDevKit storage mc, Bundle storage bundle, address owner) internal returns(Dictionary storage mockDictionary) {
        uint pid = mc.startProcess("createMockDictionary", param(bundle, owner));
        Validator.MUST_Completed(bundle);
        Validator.SHOULD_OwnerIsNotZeroAddress(owner);
        Dictionary memory _mockDictionary = DictionaryLib
                                                .createMock(bundle, owner)
                                                .assignName(mc.dictionary.genUniqueMockName(bundle.name));
        mockDictionary = mc.dictionary.register(_mockDictionary);
        mc.finishProcess(pid);
    }
    // With Default Value
    function createMockDictionary(MCDevKit storage mc) internal returns(Dictionary storage mockDictionary) {
        uint pid = mc.startProcess("createMockDictionary");
        mockDictionary = mc.createMockDictionary(mc.bundle.findCurrent(), ForgeHelper.msgSender());
        mc.finishProcess(pid);
    }
    function createMockDictionary(MCDevKit storage mc, Bundle storage bundle) internal returns(Dictionary storage mockDictionary) {
        uint pid = mc.startProcess("createMockDictionary", param(bundle));
        mockDictionary = mc.createMockDictionary(bundle, ForgeHelper.msgSender());
        mc.finishProcess(pid);
    }
    function createMockDictionary(MCDevKit storage mc, address owner) internal returns(Dictionary storage mockDictionary) {
        uint pid = mc.startProcess("createMockDictionary", param(owner));
        mockDictionary = mc.createMockDictionary(mc.bundle.findCurrent(), owner);
        mc.finishProcess(pid);
    }

}

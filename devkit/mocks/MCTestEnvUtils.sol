// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCTestEnv, Proxy, MockProxy, MockDictionary, FunctionInfo} from "DevKit/MCDevKit.sol";
import {ForgeHelper, vm, console2} from "DevKit/common/ForgeHelper.sol";
import {DevUtils} from "DevKit/common/DevUtils.sol";
import {MockProxyUtils} from "./MockProxyUtils.sol";
import {MockDictionaryUtils} from "./MockDictionaryUtils.sol";

import {ERC7546Utils} from "@ucs-contracts/src/proxy/ERC7546Utils.sol";

/******************************************
    🧪 Test Environment Utils
        🏠 for Mock Proxy
        📚 for Mock Dictionary

*******************************************/
library MCTestEnvUtils {
    /**----------------------
        📥 Safe Add Mock
    ------------------------*/
    string constant safeAdd = "Safe Add Mock to DevKitEnv";
    function safeAdd(MCTestEnv storage test, string memory name, MockProxy mockProxy) internal returns(MCTestEnv storage) {
        test.mockProxies[name.safeCalcHashAt(safeAdd)] = mockProxy.assertExistsAt(safeAdd);
        return test;
    }
    function safeAdd(MCTestEnv storage test, string memory name, MockDictionary mockDictionary) internal returns(MCTestEnv storage) {
        test.mockDictionaries[name.safeCalcHashAt(safeAdd)] = mockDictionary.assertExistsAt(safeAdd);
        return test;
    }




}

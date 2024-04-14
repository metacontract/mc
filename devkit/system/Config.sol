// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ForgeHelper} from "devkit/utils/ForgeHelper.sol";
import {LogLevel} from "devkit/system/debug/Debugger.sol";


/**----------------------
    📝 Configuration
------------------------*/
using ConfigLib for Configuration global;
/// @custom:storage-location erc7201:mc.devkit.config
struct Configuration {
    bool DEBUG_MODE;
    LogLevel DEFAULT_LOG_LEVEL;
    bool RECORD_EXECUTION_PROCESS;

    bool SETUP_STD_FUNCS;

    string DEFAULT_DICTIONARY_NAME;
    string DEFAULT_DICTIONARY_DUPLICATED_NAME;
    string DEFAULT_DICTIONARY_MOCK_NAME;
    string DEFAULT_PROXY_NAME;
    string DEFAULT_PROXY_MOCK_NAME;
    string DEFAULT_BUNDLE_NAME;
    string DEFAULT_FUNCTION_NAME;

    ScanRange SCAN_RANGE;
}
    struct ScanRange { uint128 START; uint128 END; }

function Config() pure returns(Configuration storage ref) {
    assembly { ref.slot := 0x43faf0b0e69b78a7870a9a7da6e0bf9d6f14028444e1b48699a33401cb840400 }
}

/**===============\
|   📝 Config     |
\================*/
library ConfigLib {
    function load(Configuration storage config) internal {
        config.DEBUG_MODE = true;
        config.DEFAULT_LOG_LEVEL = LogLevel.Warn;
        config.RECORD_EXECUTION_PROCESS = true;

        config.SETUP_STD_FUNCS = true;

        config.DEFAULT_DICTIONARY_NAME = "Dictionary";
        config.DEFAULT_DICTIONARY_DUPLICATED_NAME = "DuplicatedDictionary";
        config.DEFAULT_DICTIONARY_MOCK_NAME = "MockDictionary";
        config.DEFAULT_PROXY_NAME = "Proxy";
        config.DEFAULT_PROXY_MOCK_NAME = "MockProxy";
        config.DEFAULT_BUNDLE_NAME = "Bundle";
        config.DEFAULT_FUNCTION_NAME = "Function";

        config.SCAN_RANGE.START = 1;
        config.SCAN_RANGE.END = 5;
    }

    function defaultOwner(Configuration storage) internal returns(address) {
        return ForgeHelper.msgSender();
    }

    function defaultName(Configuration storage) internal pure returns(string memory) {
        return "ProjectName"; // TODO
    }

    // function defaultProxyName(MCDevKit storage mc) internal returns(string memory) {
    //     return mc.proxy.genUniqueName();
    // }
    // function defaultMockProxyName(MCDevKit storage mc) internal returns(string memory) {
    //     return mc.proxy.genUniqueMockName();
    // }

    // function defaultDictionaryName(MCDevKit storage mc) internal returns(string memory) {
    //     return mc.dictionary.genUniqueName();
    // }
    // function defaultDuplicatedDictionaryName(MCDevKit storage mc) internal returns(string memory) {
    //     return mc.dictionary.genUniqueDuplicatedName();
    // }
    // function defaultMockDictionaryName(MCDevKit storage mc) internal returns(string memory) {
    //     return mc.dictionary.genUniqueMockName();
    // }

    // function defaultFunctionInfos(MCDevKit storage mc) internal returns(Function[] storage) {
    //     return mc.functions.std.allFunctions.functions;
    // }
    // function defaultBundleName(MCDevKit storage mc) internal returns(string memory) {
    //     return mc.functions.genUniqueBundleName();
    // }

    function defaultInitData(Configuration storage) internal pure returns(bytes memory) {
        return "";
    }
}

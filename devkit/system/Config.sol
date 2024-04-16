// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ForgeHelper, vm} from "devkit/utils/ForgeHelper.sol";
import {Logger} from "devkit/system/debug/Logger.sol";

import {stdToml} from "forge-std/StdToml.sol";
    using stdToml for string;
import {Parser} from "devkit/types/Parser.sol";
    using Parser for string;

/**----------------------
    📝 Config
------------------------*/
using ConfigLib for ConfigState global;
/// @custom:storage-location erc7201:mc.devkit.config
struct ConfigState {
    SetupConfig SETUP;
    DebugConfig DEBUG;
    NamingConfig DEFAULT_NAME;
    ScanRange SCAN_RANGE;
}
    struct SetupConfig {
        bool STD_FUNCS;
    }
    struct DebugConfig {
        bool MODE;
        bool RECORD_EXECUTION_PROCESS;
        Logger.LogLevel DEFAULT_LOG_LEVEL;
    }
    struct NamingConfig {
        string DICTIONARY;
        string DICTIONARY_DUPLICATED;
        string DICTIONARY_MOCK;
        string PROXY;
        string PROXY_MOCK;
        string BUNDLE;
        string FUNCTION;
    }
    struct ScanRange { uint128 START; uint128 END; }

/**===============\
|   📝 Config     |
\================*/
library ConfigLib {
    function load(ConfigState storage config) internal {
        string memory toml = vm.readFile(string.concat(vm.projectRoot(), "/mc.toml"));
        // Setup Config
        config.SETUP.STD_FUNCS = toml.readBool(".setup.STD_FUNCS");
        // Debug Config
        config.DEBUG.MODE = toml.readBool(".debug.MODE");
        config.DEBUG.RECORD_EXECUTION_PROCESS = toml.readBool(".debug.RECORD_EXECUTION_PROCESS");
        config.DEBUG.DEFAULT_LOG_LEVEL = toml.readString(".debug.DEFAULT_LOG_LEVEL").toLogLevel();
        // Naming Config
        config.DEFAULT_NAME.DICTIONARY = toml.readString(".naming.DEFAULT_DICTIONARY");
        config.DEFAULT_NAME.DICTIONARY_DUPLICATED = toml.readString(".naming.DEFAULT_DICTIONARY_DUPLICATED");
        config.DEFAULT_NAME.DICTIONARY_MOCK = toml.readString(".naming.DEFAULT_DICTIONARY_MOCK");
        config.DEFAULT_NAME.PROXY = toml.readString(".naming.DEFAULT_PROXY");
        config.DEFAULT_NAME.PROXY_MOCK = toml.readString(".naming.DEFAULT_PROXY_MOCK");
        config.DEFAULT_NAME.BUNDLE = toml.readString(".naming.DEFAULT_BUNDLE");
        config.DEFAULT_NAME.FUNCTION = toml.readString(".naming.DEFAULT_FUNCTION");
        // Scan Range
        config.SCAN_RANGE.START = uint128(toml.readUint(".scan_range.START"));
        config.SCAN_RANGE.END = uint128(toml.readUint(".scan_range.END"));
    }

    function defaultOwner(ConfigState storage) internal returns(address) {
        return ForgeHelper.msgSender();
    }

    function defaultName(ConfigState storage) internal pure returns(string memory) {
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

    function defaultInitData(ConfigState storage) internal pure returns(bytes memory) {
        return "";
    }
}

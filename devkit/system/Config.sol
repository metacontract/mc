// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {ForgeHelper, vm} from "devkit/utils/ForgeHelper.sol";
    using ForgeHelper for string;
import {Logger} from "devkit/system/Logger.sol";
import {Validator} from "devkit/system/Validator.sol";

import {Parser} from "devkit/types/Parser.sol";
    using Parser for string;

/**----------------------
    📝 Config
------------------------*/
using ConfigLib for ConfigState global;

/**===============\
|   📝 Config     |
\================*/
/// @custom:storage-location erc7201:mc.devkit.config
struct ConfigState {
    SetupConfig SETUP;
    SystemConfig SYSTEM;
    NamingConfig DEFAULT_NAME;
}
    struct SetupConfig {
        bool STD_FUNCS;
    }
    struct SystemConfig {
        Logger.Level LOG_LEVEL;
        uint SCAN_RANGE;
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

library ConfigLib {
    function load(ConfigState storage config) internal {
        loadFromLibMC(config);
        loadFromProjectRoot(config);
    }

    function loadFromLibMC(ConfigState storage config) internal {
        string memory path = string.concat(vm.projectRoot(), "/lib/mc/mc.toml");
        if (Validator.SHOULD_FileExists(path)) config.loadFrom(path);
    }
    function loadFromProjectRoot(ConfigState storage config) internal {
        string memory path = string.concat(vm.projectRoot(), "/mc.toml");
        if (Validator.SHOULD_FileExists(path)) config.loadFrom(path);
    }

    function loadFrom(ConfigState storage config, string memory path) internal {
        string memory toml = vm.readFile(path);
        // Setup
        config.SETUP.STD_FUNCS = toml.readBoolOr(".setup.STD_FUNCS", config.SETUP.STD_FUNCS);
        // System
        config.SYSTEM.LOG_LEVEL = toml.readLogLevelOr(".system.LOG_LEVEL", config.SYSTEM.LOG_LEVEL);
        config.SYSTEM.SCAN_RANGE = toml.readUintOr(".system.SCAN_RANGE", config.SYSTEM.SCAN_RANGE);
        // Naming
        config.DEFAULT_NAME.DICTIONARY = toml.readStringOr(".naming.DEFAULT_DICTIONARY", "config.DEFAULT_NAME.DICTIONARY");
        config.DEFAULT_NAME.DICTIONARY_DUPLICATED = toml.readStringOr(".naming.DEFAULT_DICTIONARY_DUPLICATED", "config.DEFAULT_NAME.DICTIONARY_DUPLICATED");
        config.DEFAULT_NAME.DICTIONARY_MOCK = toml.readStringOr(".naming.DEFAULT_DICTIONARY_MOCK", "config.DEFAULT_NAME.DICTIONARY_MOCK");
        config.DEFAULT_NAME.PROXY = toml.readStringOr(".naming.DEFAULT_PROXY", "config.DEFAULT_NAME.PROXY");
        config.DEFAULT_NAME.PROXY_MOCK = toml.readStringOr(".naming.DEFAULT_PROXY_MOCK", "config.DEFAULT_NAME.PROXY_MOCK");
        config.DEFAULT_NAME.BUNDLE = toml.readStringOr(".naming.DEFAULT_BUNDLE", "config.DEFAULT_NAME.BUNDLE");
        config.DEFAULT_NAME.FUNCTION = toml.readStringOr(".naming.DEFAULT_FUNCTION", "config.DEFAULT_NAME.FUNCTION");
    }

}

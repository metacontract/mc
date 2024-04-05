// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ForgeHelper} from "./utils/ForgeHelper.sol";
import {LogLevel} from "./debug/Debug.sol";
// import {MCDevKit} from "./MCDevKit.sol";
// import {Function} from "./ucs/functions/Function.sol";

/**===============\
|   📝 Config     |
\================*/
library Config {
    bool constant DEBUG_MODE = false;
    LogLevel constant DEFAULT_LOG_LEVEL = LogLevel.Warn;

    bool constant USE_DEPLOYED_STD = false; // TODO

    string constant DEFAULT_DICTIONARY_NAME = "Dictionary";
    string constant DEFAULT_DICTIONARY_DUPLICATED_NAME = "DuplicatedDictionary";
    string constant DEFAULT_DICTIONARY_MOCK_NAME = "MockDictionary";
    string constant DEFAULT_PROXY_NAME = "Proxy";
    string constant DEFAULT_PROXY_MOCK_NAME = "MockProxy";
    string constant DEFAULT_BUNDLE_NAME = "Bundle";

    struct ScanRange { uint128 start; uint128 end; }
    function SCAN_RANGE() internal pure returns(ScanRange memory) {
        return ScanRange(1, 5);
    }




    function defaultOwner() internal returns(address) {
        return ForgeHelper.msgSender();
    }

    function defaultName() internal pure returns(string memory) {
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
    //     return mc.functions.std.allFunctions.functionInfos;
    // }
    // function defaultBundleName(MCDevKit storage mc) internal returns(string memory) {
    //     return mc.functions.genUniqueBundleName();
    // }

    function defaultInitData() internal pure returns(bytes memory) {
        return "";
    }
}

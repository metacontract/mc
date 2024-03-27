// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {LogLevel} from "./debug/Debug.sol";

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
}

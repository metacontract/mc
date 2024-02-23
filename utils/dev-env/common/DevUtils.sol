// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {console2, StdStyle} from "dev-env/common/ForgeHelper.sol";

//============================================
//  📚 Development Utils
//      🔢 Utils for Primitives
//      📊 Utils for Logging
//      🚨 Utils for Errors & Assertions
library DevUtils {

    /**---------------------------
        🔢 Utils for Primitives
    -----------------------------*/
    function getHash(string memory name) internal pure returns(bytes32) {
        return keccak256(abi.encode(name));
    }

    function isEqual(string memory a, string memory b) internal pure returns(bool) {
        return keccak256(abi.encode(a)) == keccak256(abi.encode(b));
    }

    function exists(address addr) internal returns(bool) {
        return addr != address(0) && addr.code.length != 0;
    }


    /**-------------------------
        📊 Utils for Logging
    ---------------------------*/
    using StdStyle for string;

    /// @dev for settings
    /// 7201:ucs.settings.log
    bytes32 constant SETTINGS_LOG_TRANSIENT_SLOT = 0xbde0fdc5ed1ea0336c91994660ac4a36d1b140bbccd99d8aa6d980b60a25d200;
    function toggleLog() internal {
        assembly {
            switch tload(SETTINGS_LOG_TRANSIENT_SLOT)
            case 0 {
                tstore(SETTINGS_LOG_TRANSIENT_SLOT, 1)
            }
            default {
                tstore(SETTINGS_LOG_TRANSIENT_SLOT, 0)
            }
        }
    }
    function shouldLog() internal returns(bool flag) {
        assembly {
            flag := tload(SETTINGS_LOG_TRANSIENT_SLOT)
        }
    }
    function log(string memory message) internal {
        if (shouldLog()) {
            console2.log(message);
        }
    }
    function logProcess(string memory message) internal {
        log(message.underline());
    }


    /**-------------------------------------
        🚨 Utils for Errors & Assertions
    ---------------------------------------*/
    function revertWithDevEnvError(string memory errorString) internal {
        console2.log("UCS DevEnv Error:", errorString.red());
        revert(errorString);
    }

    function assertNotEmpty(string memory keyword) internal returns(string memory) {
        if (bytes(keyword).length == 0) {
            revertWithDevEnvError("Empty Keyword");
        }
        return keyword;
    }

    function assertNotEmpty(bytes4 selector) internal returns(bytes4) {
        if (selector == bytes4(0)) {
            revertWithDevEnvError("Empty Selector");
        }
        return selector;
    }

    function assertContractExists(address contractAddr) internal returns(address) {
        if (!exists(contractAddr)) {
            revertWithDevEnvError("Contract does not exist");
        }
        return contractAddr;
    }
}

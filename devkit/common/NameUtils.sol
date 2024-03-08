// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ForgeHelper, console2, StdStyle, vm} from "DevKit/common/ForgeHelper.sol";
import {ERC7546Utils} from "@ucs-contracts/src/proxy/ERC7546Utils.sol";
import {DevUtils} from "./DevUtils.sol";


//============================================
//  📚 Name Utils
//      🔢 Utils for Primitives
//      📊 Utils for Logging
//      🚨 Utils for Errors & Assertions
library NameUtils {
    using DevUtils for *;
    using StdStyle for string;


    /**---------------------------
        🔢 Utils for Primitives
    -----------------------------*/
    function toBundleHash(string memory name) internal returns(bytes32) {
        return name.safeCalcHash();
    }

}

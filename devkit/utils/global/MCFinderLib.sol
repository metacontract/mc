// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {MCDevKit} from "devkit/MCDevKit.sol";
// Core
//  functions
import {Bundle} from "devkit/core/Bundle.sol";
import {Function} from "devkit/core/Function.sol";
//  proxy
import {Proxy} from "devkit/core/Proxy.sol";
//  dictionary
import {Dictionary} from "devkit/core/Dictionary.sol";


/********************************************
 *  🔍 Finder
 *      🏠 Find Current Proxy Address
 *      📚 Find Current Dictionary Address
*********************************************/
library MCFinderLib {

    /**----------------------------------
        🏠 Find Current Proxy Address
    ------------------------------------*/
    function toProxyAddress(MCDevKit storage mc) internal returns(address) {
        return mc.proxy.findCurrent().addr;
    }

    /**----------------------------------------
        📚 Find Current Dictionary Address
    ------------------------------------------*/
    function toDictionaryAddress(MCDevKit storage mc) internal returns(address) {
        return mc.dictionary.findCurrent().addr;
    }

}

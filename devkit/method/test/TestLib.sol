// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**--------------------------
    Apply Support Methods
----------------------------*/

// Core Type
import {Proxy} from "devkit/core/Proxy.sol";


/**===============
    🏠 Proxy
=================*/
library TestLib {
    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        🚀 Deploy Proxy
        🧪 Test Utils
        🤖 Create Mock Proxy
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

    /**-------------------
        🧪 Test Utils
    ---------------------*/
    function loadDictionary(Proxy storage proxy) internal returns(Dictionary storage) {
        return ForgeHelper.loadAddress(proxy.addr, ERC7546Utils.DICTIONARY_SLOT).asDictionary();
    }

    function changeDictionary(Proxy storage proxy) internal {}

}

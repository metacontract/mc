// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Errors & Debug
import {check} from "devkit/error/Validation.sol";
// Core Type
import {ProxyKind} from "devkit/core/Proxy.sol";

/**---------------
    🏠 Proxy
-----------------*/
library ProxyKindLib {
    function isNotUndefined(ProxyKind kind) internal pure returns(bool) {
        return kind != ProxyKind.undefined;
    }
    function assertNotUndefined(ProxyKind kind) internal returns(ProxyKind) {
        check(kind.isNotUndefined(), "Undefined Proxy Kind");
        return kind;
    }
}

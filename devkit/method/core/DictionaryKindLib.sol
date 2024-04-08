// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {check} from "devkit/error/Validation.sol";
import {DictionaryKind} from "devkit/core/Dictionary.sol";

/**------------------------
    📚 Dictionary Kind
--------------------------*/
library DictionaryKindLib {
    function isNotUndefined(DictionaryKind kind) internal pure returns(bool) {
        return kind != DictionaryKind.undefined;
    }
    function assertNotUndefined(DictionaryKind kind) internal returns(DictionaryKind) {
        check(kind.isNotUndefined(), "Undefined Dictionary Kind");
        return kind;
    }
}

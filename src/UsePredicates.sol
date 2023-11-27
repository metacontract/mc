// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

abstract contract UsePredicates {
    modifier predicates() {
        __pre_conditions__();
        _;
        __post_conditions__();
    }

    function __pre_conditions__() internal virtual;
    function __post_conditions__() internal virtual;
}

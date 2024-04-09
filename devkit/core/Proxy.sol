// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Methods
import {ProxyLib} from "devkit/method/core/ProxyLib.sol";
import {ProxyKindLib} from "devkit/method/core/ProxyKindLib.sol";
import {ProcessLib} from "devkit/method/debug/ProcessLib.sol";
import {Inspector} from "devkit/method/inspector/Inspector.sol";


/**===============
    🏠 Proxy
=================*/
struct Proxy {
    address addr;
    ProxyKind kind;
}
using ProxyLib for Proxy global;
//  Support Methods
using ProcessLib for Proxy global;
using Inspector for Proxy global;


    /**---------------
        Proxy Kind
    -----------------*/
    enum ProxyKind {
        undefined,
        Normal,
        Verifiable,
        Mock
    }
    using ProxyKindLib for ProxyKind global;

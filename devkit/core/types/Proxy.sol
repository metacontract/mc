// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {ProcessLib} from "devkit/core/method/debug/ProcessLib.sol";
    using ProcessLib for Proxy global;
import {Inspector} from "devkit/core/method/inspector/Inspector.sol";
    using Inspector for Proxy global;
    using Inspector for ProxyKind global;
// Validation
import {Require} from "devkit/error/Require.sol";// Core Type
import {TypeGuard, TypeStatus} from "devkit/core/types/TypeGuard.sol";
    using TypeGuard for Proxy global;

// Mock
import {ProxySimpleMock} from "devkit/mocks/ProxySimpleMock.sol";
// External Lib
import {ERC7546ProxyEtherscan} from "@ucs.mc/proxy/ERC7546ProxyEtherscan.sol";

// Core Types
import {Dictionary} from "devkit/core/types/Dictionary.sol";
import {Function} from "devkit/core/types/Function.sol";


/**===============
    🏠 Proxy
=================*/
using ProxyLib for Proxy global;
struct Proxy {
    address addr;
    ProxyKind kind;
    TypeStatus status;
}
library ProxyLib {
    /**~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        🚀 Deploy Proxy
        🤖 Create Mock Proxy
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

    /**---------------------
        🚀 Deploy Proxy
    -----------------------*/
    function deploy(Dictionary memory dictionary, bytes memory initData) internal returns(Proxy memory proxy) {
        uint pid = ProcessLib.startProxyLibProcess("deploy");
        Require.notEmpty(dictionary);
        return Proxy({
            addr: address(new ERC7546ProxyEtherscan(dictionary.addr, initData)),
            kind: ProxyKind.Verifiable,
            status: TypeStatus.Building
        }).finishProcess(pid);
    }

    /**--------------------------
        🤖 Create Mock Proxy
    ----------------------------*/
    function createSimpleMockProxy(Function[] memory functions) internal returns(Proxy memory) {
        uint pid = ProcessLib.startProxyLibProcess("createSimpleMockProxy");
        return Proxy({
            addr: address(new ProxySimpleMock(functions)),
            kind: ProxyKind.Mock,
            status: TypeStatus.Building
        }).finishProcess(pid);
    }
}


/**---------------
    Proxy Kind
-----------------*/
enum ProxyKind {
    undefined,
    Normal,
    Verifiable,
    Mock
}

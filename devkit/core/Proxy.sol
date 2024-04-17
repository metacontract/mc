// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {ProcessLib} from "devkit/system/debug/Process.sol";
    using ProcessLib for Proxy global;
import {Inspector} from "devkit/types/Inspector.sol";
    using Inspector for Proxy global;
    using Inspector for ProxyKind global;
// Validation
import {Validate} from "devkit/system/Validate.sol";
import {TypeGuard, TypeStatus} from "devkit/types/TypeGuard.sol";
    using TypeGuard for Proxy global;

// External Lib Contract
import {Proxy as UCSProxy} from "@ucs.mc/proxy/Proxy.sol";
// Mock Contract
import {ProxySimpleMock} from "devkit/mocks/ProxySimpleMock.sol";

// Core Types
import {Dictionary} from "devkit/core/Dictionary.sol";
import {Function} from "devkit/core/Function.sol";


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

    /**---------------------
        🚀 Deploy Proxy
    -----------------------*/
    function deploy(Dictionary memory dictionary, bytes memory initData) internal returns(Proxy memory) {
        uint pid = ProcessLib.startProxyLibProcess("deploy");
        Validate.MUST_Completed(dictionary);
        Proxy memory proxy;
        proxy.startBuilding();
        proxy.addr = address(new UCSProxy(dictionary.addr, initData));
        proxy.kind = ProxyKind.Verifiable;
        proxy.finishBuilding();
        return proxy.finishProcess(pid);
    }

    /**--------------------------
        🤖 Create Proxy Mock
    ----------------------------*/
    function createSimpleMock(Function[] memory functions) internal returns(Proxy memory) {
        uint pid = ProcessLib.startProxyLibProcess("createSimpleMock");
        for (uint i; i < functions.length; ++i) {
            Validate.MUST_Completed(functions[i]);
        }
        Proxy memory proxy;
        proxy.startBuilding();
        proxy.addr = address(new ProxySimpleMock(functions));
        proxy.kind = ProxyKind.Mock;
        proxy.finishBuilding();
        return proxy.finishProcess(pid);
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

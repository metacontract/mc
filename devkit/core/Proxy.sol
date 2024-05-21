// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;
/**---------------------
    Support Methods
-----------------------*/
import {Tracer, param} from "devkit/system/Tracer.sol";
import {Inspector} from "devkit/types/Inspector.sol";
import {TypeGuard, TypeStatus} from "devkit/types/TypeGuard.sol";
// Validation
import {Validator} from "devkit/system/Validator.sol";

// External Lib Contract
import {Proxy as UCSProxy} from "@ucs.mc/proxy/Proxy.sol";
// Mock Contract
import {SimpleMockProxy} from "devkit/test/mocks/SimpleMockProxy.sol";

// Core Types
import {Dictionary} from "devkit/core/Dictionary.sol";
import {Function} from "devkit/core/Function.sol";


///////////////////////////////////////////
//  🏠 Proxy   ////////////////////////////
    using ProxyLib for Proxy global;
    using Tracer for Proxy global;
    using Inspector for Proxy global;
    using TypeGuard for Proxy global;
///////////////////////////////////////////
struct Proxy {
    address addr;
    ProxyKind kind;
    TypeStatus status;
}
library ProxyLib {
    /**---------------------
        🚀 Deploy Proxy
    -----------------------*/
    function deploy(Dictionary memory dictionary, bytes memory initData) internal returns(Proxy memory proxy) {
        uint pid = proxy.startProcess("deploy", param(dictionary, initData));
        Validator.MUST_Completed(dictionary);
        proxy.startBuilding();
        proxy.addr = address(new UCSProxy(dictionary.addr, initData));
        proxy.kind = ProxyKind.Verifiable;
        proxy.finishBuilding();
        return proxy.finishProcess(pid);
    }

    /**--------------------------
        🤖 Create Proxy Mock
    ----------------------------*/
    function createSimpleMock(Function[] memory functions) internal returns(Proxy memory mockProxy) {
        uint pid = mockProxy.startProcess("createSimpleMock", param(functions));
        for (uint i; i < functions.length; ++i) {
            Validator.MUST_Completed(functions[i]);
        }
        mockProxy.startBuilding();
        mockProxy.addr = address(new SimpleMockProxy(functions));
        mockProxy.kind = ProxyKind.Mock;
        mockProxy.finishBuilding();
        return mockProxy.finishProcess(pid);
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
using Inspector for ProxyKind global;

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
/**---------------------
    Support Methods
-----------------------*/
import {ProcessLib} from "devkit/system/debug/ProcessLib.sol";
    using ProcessLib for Proxy global;
import {Inspector} from "devkit/types/Inspector.sol";
    using Inspector for Proxy global;
    using Inspector for ProxyKind global;
// Validation
import {Validate} from "devkit/system/validate/Validate.sol";
import {TypeGuard, TypeStatus} from "devkit/types/TypeGuard.sol";
    using TypeGuard for Proxy global;

// External Lib Contract
import {ERC7546ProxyEtherscan} from "@ucs.mc/proxy/ERC7546ProxyEtherscan.sol";
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
        Validate.MUST_haveContract(dictionary);
        return Proxy({
            addr: address(new ERC7546ProxyEtherscan(dictionary.addr, initData)),
            kind: ProxyKind.Verifiable,
            status: TypeStatus.Building
        }).finishProcess(pid);
    }

    /**--------------------------
        🤖 Create Proxy Mock
    ----------------------------*/
    function createSimpleMock(Function[] memory functions) internal returns(Proxy memory) {
        uint pid = ProcessLib.startProxyLibProcess("createSimpleMock");
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

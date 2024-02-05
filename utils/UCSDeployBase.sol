// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {CommonBase} from "forge-std/Base.sol";

import {DictionaryUpgradeable} from "@ucs-contracts/src/dictionary/DictionaryUpgradeable.sol";
import {DictionaryUpgradeableEtherscan} from "@ucs-contracts/src/dictionary/DictionaryUpgradeableEtherscan.sol";
import {DictionaryUpgradeableEtherscanProxy} from "@ucs-contracts/src/dictionary/DictionaryUpgradeableEtherscanProxy.sol";
import {DictionaryBase} from "@ucs-contracts/src/dictionary/DictionaryBase.sol";
import {ERC7546Proxy} from "@ucs-contracts/src/proxy/ERC7546Proxy.sol";
import {ERC7546ProxyEtherscan} from "@ucs-contracts/src/proxy/ERC7546ProxyEtherscan.sol";

import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

import {InitSetAdminOp} from "../src/ops/InitSetAdminOp.sol";
import {SetImplementationOp} from "../src/ops/SetImplementationOp.sol";
import {CloneOp} from "../src/ops/CloneOp.sol";
import {GetDepsOp} from "../src/ops/GetDepsOp.sol";
import {DefaultOpsFacade, DefaultOpsFacadeV2} from "../src/interfaces/IDefaultOps.sol";

abstract contract UCSDeployBase is CommonBase {
    struct Op {
        bytes4 selector;
        address implementation;
    }

    address deployer;
    uint256 deployerKey;


    /**************************************
        🛠 Environment Helper Functions
    **************************************/
    function getPrivateKey(string memory keyword) internal view returns(uint256) {
        return uint256(vm.envBytes32(keyword));
    }

    function getAddressOr(string memory keyword, address addr) internal view returns(address) {
        return vm.envOr(keyword, addr);
    }

    function tryGetDeployedContract(string memory envKey) public returns(bool success, address deployedContract) {
        deployedContract = vm.envOr(envKey, address(0));
        if (deployedContract.code.length != 0) success = true;
    }


    /**********************************
    🎁 Easy to use functions
        - newProxy() -> address proxy
        - replicate(targetDictionary) -> address proxy, address dictionary
        - upgradeOps(proxy, ops)
        - upgradeFacade(proxy, newFacade)
    **********************************/
    function newProxy() public returns(address) {
        return getOrDeployProxy();
    }

    function replicate(address targetDictionary) public returns(address proxy, address dictionary) {
        dictionary = replicateDictionaryUpgradeableEtherscan(targetDictionary);
        proxy = deployProxyWithDictionaryEtherscan(dictionary);
    }

    function upgradeOps(address proxy, Op[] memory ops) public {}
    function upgradeFacade(address proxy, address newFacade) public {}


    /**********************************
        📃 Get or Deploy Contracts
            - Proxy
            - Dictionary
            - Ops
    **********************************/

    /**----------------
        Proxy
    -------------------
        < Deploy >
            1️⃣ ERC7546Proxy
          * 2️⃣ ERC7546Proxy with Etherscan-compatibility (default)
            3️⃣ ERC7546Proxy with DictionaryEtherscan
     */

    // 1️⃣
    /// @dev Until Etherscan supports UCS, we are deploying contracts with additional features for Etherscan compatibility by default.
    function getOrDeployProxy() public returns(address) {
        return getOrDeployProxyEtherscan();
    }

    function deployProxy() public returns(address) {}

    // 2️⃣
    function getOrDeployProxyEtherscan() public returns(address proxyEtherscan) {
        (bool success, address deployedContract) = tryGetDeployedContract("PROXY_ETHERSCAN");
        if (success) return deployedContract;
        return deployProxyEtherscan();
    }

    function deployProxyEtherscan() public returns(address) {
        return address(new ERC7546ProxyEtherscan({
            dictionary: deployDictionaryUpgradeableEtherscan(),
            _data: initSetAdminData(deployer)
        }));
    }

    // 3️⃣
    function deployProxyWithDictionaryEtherscan(address dictionaryEtherscan) public returns(address) {
        return address(new ERC7546ProxyEtherscan({
            dictionary: dictionaryEtherscan,
            _data: initSetAdminData(deployer)
        }));
    }


    /**----------------
        Dictionary
    -------------------
        < Deploy >
            [Immutable]
                1️⃣ Dictionary
              * 2️⃣ DictionaryEtherscan (default)
            [Upgradeable]
                3️⃣ Dictionary Upgradeable using UUPS
             ** 4️⃣ Dictionary Upgradeable with Etherscan-compatibility (default)
                    - ERC1967Proxy
                    - Dictionary Upgradeable Etherscan Implementation
        < Replicate >
     */

    // 1️⃣
    function getOrDeployDictionary() public returns(address) {}
    function deployDictionary() internal returns(address) {}

    // 2️⃣
    function getOrDeployDictionaryEtherscan() public returns(address) {}
    function deployDictionaryEtherscan() internal returns(address) {}

    // 3️⃣
    /// @dev Until Etherscan supports UCS natively, we are deploying contracts with additional features for Etherscan compatibility by default.
    function getOrDeployDictionaryUpgradeable() public returns(address) {
        return getOrDeployDictionaryUpgradeableEtherscan();
    }

    function deployDictionaryUpgradeable() public returns(address) {}

    // 4️⃣
    function getOrDeployDictionaryUpgradeableEtherscan() public returns(address) {
        (bool success, address deployedContract) = tryGetDeployedContract("DICTIONARY_UPGRADEABLE_ETHERSCAN");
        if (success) return deployedContract;
        return deployDictionaryUpgradeableEtherscan();
    }

    function deployDictionaryUpgradeableEtherscan() public returns(address dictionaryUpgradeableEtherscan) {
        dictionaryUpgradeableEtherscan = address(new DictionaryUpgradeableEtherscanProxy({
            implementation: getOrDeployDictionaryUpgradeableEtherscanImpl(),
            _data: initializeDictionaryUpgradeableEtherscanData(deployer)
        }));

        setDefaultOps(dictionaryUpgradeableEtherscan);
        setDefaultFacade(dictionaryUpgradeableEtherscan);
    }

    function getOrDeployDictionaryUpgradeableEtherscanImpl() public returns(address) {
        (bool success, address deployedContract) = tryGetDeployedContract("DICTIONARY_UPGRADEABLE_ETHERSCAN_IMPL");
        if (success) return deployedContract;
        return deployDictionaryUpgradeableEtherscanImpl();
    }

    function deployDictionaryUpgradeableEtherscanImpl() public returns(address) {
        return address(new DictionaryUpgradeableEtherscan());
    }

    // Replicate
    function replicateDictionaryUpgradeableEtherscan(address targetDictionary) public returns(address dictionary) {
        dictionary = address(new DictionaryUpgradeableEtherscanProxy({
            implementation: getOrDeployDictionaryUpgradeableEtherscanImpl(),
            _data: initializeDictionaryUpgradeableEtherscanData(deployer)
        }));
        copyOps({from: targetDictionary, to: dictionary});
    }

    function copyOps(address from, address to) public {
        bytes4[] memory _selectors = DictionaryBase(from).supportsInterfaces();
        for (uint i; i < _selectors.length; ++i) {
            bytes4 _selector = _selectors[i];
            if (_selector == bytes4(0)) continue;
            DictionaryBase(to).setImplementation({
                functionSelector: _selector,
                implementation: DictionaryBase(from).getImplementation(_selector)
            });
        }
    }


    /**----------------
        Ops
    -------------------
        < Deploy >
            - DefaultOps
            - GetDepsOp
            - CloneOp
        < Setup >
            - SetOps
                - SetDefaultOps
                    - InitSetAdminOp
                - SetEtherscanOps
                    - GetDepsOp
            - SetFacade (for etherscan-compatibility)
     */

    // SetOps
    function setDefaultOps(address dictionary) public {
        Op[] memory ops = new Op[](1);
        ops[0] = getOrCreateInitSetAdminOp();
        setOps(dictionary, ops);
    }

    function setEtherscanOps(address dictionary) public {
        Op[] memory ops = new Op[](1);
        ops[0] = getOrCreateGetDepsOp();
        setOps(dictionary, ops);
    }

    function setOps(address dictionary, Op[] memory ops) public {
        for (uint i; i < ops.length; ++i) {
            DictionaryBase(dictionary).setImplementation(ops[i].selector, ops[i].implementation);
        }
    }

    // Getter for initData
    function initSetAdminData(address admin) internal pure returns(bytes memory) {
        return abi.encodeWithSelector(InitSetAdminOp.initSetAdmin.selector, admin);
    }

    function initializeDictionaryUpgradeableEtherscanData(address admin) public pure returns(bytes memory) {
        return abi.encodeWithSelector(DictionaryUpgradeableEtherscan.initialize.selector, admin);
    }

    // Facade
    function setDefaultFacade(address dictionary) public {
        DictionaryUpgradeableEtherscan(dictionary).upgradeFacade(getOrCreateDefaultOpsFacade());
    }

    function upgradeDefaultFacadeToV2(address dictionary) public {
        DictionaryUpgradeableEtherscan(dictionary).upgradeFacade(getOrCreateDefaultOpsFacadeV2());
    }

    function getOrCreateDefaultOpsFacade() internal returns(address instance) {
        string memory envKey = "DEFAULT_OPS_FACADE";
        instance = vm.envOr(envKey, address(0));
        if (instance.code.length != 0) return instance;
        instance = address(new DefaultOpsFacade());
    }

    function getOrCreateDefaultOpsFacadeV2() public returns(address instance) {
        string memory envKey = "DEFAULT_OPS_FACADE_V2";
        instance = vm.envOr(envKey, address(0));
        if (instance.code.length != 0) return instance;
        instance = address(new DefaultOpsFacadeV2());
    }

    // Ops
    function getOrCreateInitSetAdminOp() internal returns(Op memory op) {
        string memory envKey = "INIT_SET_ADMIN_OP";
        op.selector = InitSetAdminOp.initSetAdmin.selector;
        op.implementation = vm.envOr(envKey, address(0));
        if (op.implementation.code.length != 0) return op;
        op.implementation = address(new InitSetAdminOp());
    }

    function getOrCreateGetDepsOp() internal returns(Op memory op) {
        string memory envKey = "GET_DEPS_OP";
        op.selector = GetDepsOp.getDeps.selector;
        op.implementation = vm.envOr(envKey, address(0));
        if (op.implementation.code.length != 0) return op;
        op.implementation = address(new GetDepsOp());
    }

    function getOrCreateSetImplementationOp() internal returns(Op memory op) {
        string memory envKey = "SET_IMPLEMENTATION_OP";
        op.selector = SetImplementationOp.setImplementation.selector;
        op.implementation = vm.envOr(envKey, address(0));
        if (op.implementation.code.length != 0) return op;
        op.implementation = address(new SetImplementationOp());
    }

}

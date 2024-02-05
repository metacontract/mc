// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {CommonBase} from "forge-std/Base.sol";

import {DictionaryUpgradeableEtherscan} from "@ucs-contracts/src/dictionary/DictionaryUpgradeableEtherscan.sol";
import {DictionaryUpgradeableEtherscanProxy} from "@ucs-contracts/src/dictionary/DictionaryUpgradeableEtherscanProxy.sol";
import {DictionaryBase} from "@ucs-contracts/src/dictionary/DictionaryBase.sol";
import {ERC7546Proxy} from "@ucs-contracts/src/proxy/ERC7546Proxy.sol";
import {ERC7546ProxyEtherscan} from "@ucs-contracts/src/proxy/ERC7546ProxyEtherscan.sol";

import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

import {InitSetAdminOp} from "../src/ops/InitSetAdminOp.sol";
import {GetDepsOp} from "../src/ops/GetDepsOp.sol";
import {CloneOp} from "../src/ops/CloneOp.sol";
import {SetImplementationOp} from "../src/ops/SetImplementationOp.sol";

import {DefaultOpsFacade} from "../src/interfaces/facades/DefaultOpsFacade.sol";

abstract contract UCSDeployBase is CommonBase {
    enum OpName {
        InitSetAdmin,
        GetDeps,
        Clone,
        SetImplementation
    }

    struct Op {
        bytes4 selector;
        address implementation;
    }

    mapping(OpName => Op) public ops;
    OpName[] public defaultOps;

    address deployer;
    uint256 deployerKey;

    constructor() {
        ops[OpName.InitSetAdmin] = getOrCreateInitSetAdminOp();
        ops[OpName.GetDeps] = getOrCreateGetDepsOp();
        ops[OpName.Clone] = getOrCreateCloneOp();
        ops[OpName.SetImplementation] = getOrCreateSetImplementationOp();
        defaultOps.push(OpName.InitSetAdmin);
        defaultOps.push(OpName.GetDeps);
    }

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
        - newProxyWithOwnedDictionary(targetDictionary) -> address proxy, address dictionary
        - setOps(dictionary, opNames)
        - upgradeFacade(dictionary, newFacade)
    **********************************/
    function newProxy() public returns(address) {
        return getOrDeployProxy();
    }

    function newProxyWithOwnedDictionary(address targetDictionary) public returns(address proxy, address dictionary) {
        dictionary = cloneOwnedDictionaryUpgradeableEtherscan(targetDictionary);
        proxy = deployProxyWithDictionaryEtherscan(dictionary);
    }


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
            dictionary: getOrDeployDefaultDictionaryUpgradeableEtherscan(),
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
        < Clone Owned >
     */

    /** < Deploy > */
    // 1️⃣
    function getOrDeployDictionary() public returns(address) {}
    function deployDictionary() internal returns(address) {}

    // 2️⃣
    function getOrDeployDictionaryEtherscan() public returns(address) {}
    function deployDictionaryEtherscan() internal returns(address) {}

    // 3️⃣
    /// @dev Until Etherscan supports UCS natively, we are deploying contracts with additional features for Etherscan compatibility by default.
    function getOrDeployDictionaryUpgradeable() public returns(address) {
        (bool success, address deployedContract) = tryGetDeployedContract("DICTIONARY_UPGRADEABLE");
        if (success) return deployedContract;
        return deployDictionaryUpgradeable();
    }

    function deployDictionaryUpgradeable() public returns(address) {
        return deployDictionaryUpgradeableEtherscan();
    }

    // 4️⃣ Proxy
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
    }

    function initializeDictionaryUpgradeableEtherscanData(address admin) public pure returns(bytes memory) {
        return abi.encodeWithSelector(DictionaryUpgradeableEtherscan.initialize.selector, admin);
    }

    function getOrDeployDefaultDictionaryUpgradeableEtherscan() public returns(address) {
        (bool success, address deployedContract) = tryGetDeployedContract("DEFAULT_DICTIONARY_UPGRADEABLE_ETHERSCAN");
        if (success) return deployedContract;
        return deployDeafultDictionaryUpgradeableEtherscan();
    }

    function deployDeafultDictionaryUpgradeableEtherscan() public returns(address dictionaryUpgradeableEtherscan) {
        dictionaryUpgradeableEtherscan = deployDictionaryUpgradeableEtherscan();

        setDefaultOpsAndFacade(dictionaryUpgradeableEtherscan);
    }

    // 4️⃣ Implementation
    function getOrDeployDictionaryUpgradeableEtherscanImpl() public returns(address) {
        (bool success, address deployedContract) = tryGetDeployedContract("DICTIONARY_UPGRADEABLE_ETHERSCAN_IMPL");
        if (success) return deployedContract;
        return deployDictionaryUpgradeableEtherscanImpl();
    }

    function deployDictionaryUpgradeableEtherscanImpl() public returns(address) {
        return address(new DictionaryUpgradeableEtherscan());
    }

    // < Clone Owned >
    function cloneOwnedDictionaryUpgradeableEtherscan(address targetDictionary) public returns(address dictionary) {
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
        < Enable Ops >
        < Disable Ops >
        < Setup >
            - SetDefaultOpsAndFacade
        < Get or Create Standard Ops >
            - InitSetAdmin
            - GetDeps
            - Clone
            - SetImplementation
     */

    // SetOps
    function setOps(address dictionary, OpName[] memory opNames) public {
        for (uint i; i < opNames.length; ++i) {
            Op memory _op = ops[opNames[i]];
            DictionaryBase(dictionary).setImplementation(_op.selector, _op.implementation);
        }
    }

    function setDefaultOpsAndFacade(address dictionary) public {
        // Set default ops
        setOps(dictionary, defaultOps);

        // Set default facade
        upgradeFacade(dictionary, getOrCreateDefaultOpsFacade());
    }

    // Facade
    function upgradeFacade(address dictionary, address newFacade) public {
        DictionaryUpgradeableEtherscan(dictionary).upgradeFacade(newFacade);
    }

    function getOrCreateDefaultOpsFacade() internal returns(address instance) {
        string memory envKey = "DEFAULT_OPS_FACADE";
        instance = vm.envOr(envKey, address(0));
        if (instance.code.length != 0) return instance;
        instance = address(new DefaultOpsFacade());
    }

    // Ops
    // InitSetAdmin
    function getOrCreateInitSetAdminOp() internal returns(Op memory op) {
        string memory envKey = "INIT_SET_ADMIN_OP";
        op.selector = InitSetAdminOp.initSetAdmin.selector;
        op.implementation = vm.envOr(envKey, address(0));
        if (op.implementation.code.length != 0) return op;
        op.implementation = createInitSetAdminOp();
    }

    function createInitSetAdminOp() internal returns(address) {
        return address(new InitSetAdminOp());
    }

    function initSetAdminData(address admin) internal pure returns(bytes memory) {
        return abi.encodeWithSelector(InitSetAdminOp.initSetAdmin.selector, admin);
    }

    // GetDeps
    function getOrCreateGetDepsOp() internal returns(Op memory op) {
        string memory envKey = "GET_DEPS_OP";
        op.selector = GetDepsOp.getDeps.selector;
        op.implementation = vm.envOr(envKey, address(0));
        if (op.implementation.code.length != 0) return op;
        op.implementation = createGetDepsOp();
    }

    function createGetDepsOp() internal returns(address) {
        return address(new GetDepsOp());
    }

    // Clone
    function getOrCreateCloneOp() internal returns(Op memory op) {
        string memory envKey = "CLONE_OP";
        op.selector = CloneOp.clone.selector;
        op.implementation = vm.envOr(envKey, address(0));
        if (op.implementation.code.length != 0) return op;
        op.implementation = createCloneOp();
    }

    function createCloneOp() internal returns(address) {
        return address(new CloneOp());
    }

    // SetImplementation
    function getOrCreateSetImplementationOp() internal returns(Op memory op) {
        string memory envKey = "SET_IMPLEMENTATION_OP";
        op.selector = SetImplementationOp.setImplementation.selector;
        op.implementation = vm.envOr(envKey, address(0));
        if (op.implementation.code.length != 0) return op;
        op.implementation = createSetImplementation();
    }

    function createSetImplementation() internal returns(address) {
        return address(new SetImplementationOp());
    }

}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {ERC7546Clones} from "@ucs-contracts/src/ERC7546Clones.sol";
import {DictionaryUpgradeable} from "@ucs-contracts/src/dictionary/DictionaryUpgradeable.sol";
import {DictionaryEtherscan} from "@ucs-contracts/src/dictionary/DictionaryEtherscan.sol";
import {DictionaryBase} from "@ucs-contracts/src/dictionary/DictionaryBase.sol";
import {ERC7546Proxy} from "@ucs-contracts/src/proxy/ERC7546Proxy.sol";
import {ERC7546ProxyEtherscan} from "@ucs-contracts/src/proxy/ERC7546ProxyEtherscan.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {InitSetAdminOp} from "./ops/InitSetAdminOp.sol";
import {SetImplementationOp} from "./ops/SetImplementationOp.sol";

struct DefaultOps {
    Op[] ops;
    address facade;
}

struct Op {
    bytes4 selector;
    address implementation;
}

/**
 * UCS Deployer Contract v0.1.0
 */
contract UCSDeployer {
    event DictionaryDeployed(address dictionary);
    event ProxyDeployed(address proxy);
    event Created(address proxy, address dictionary, address[] ops);

    address public dictionaryUpgradeableImpl;
    DefaultOps public defaultOps;

    constructor(
        address dictionaryUpgradeableImpl_,
        DefaultOps memory defaultOps_
    ) {
        dictionaryUpgradeableImpl = dictionaryUpgradeableImpl_;
        for (uint i; i < defaultOps_.ops.length; ++i) {
            defaultOps.ops.push(defaultOps_.ops[i]);
        }
        defaultOps.facade = defaultOps_.facade;
    }

    /**
        1. Deploy UCS Proxy with New DictionaryEtherscan
     */
    function createWithNewDictionaryEtherscan(
        Op[] memory ops,
        address facade,
        address admin
    ) public returns(address proxy, address dictionary) {
        dictionary = _deployDictionaryEtherscan(ops, facade, address(this));
        proxy = _deployProxyEtherscan(dictionary, admin);
        _transferDictionaryOwnership(dictionary, proxy);
    }

    function createWithNewDictionaryEtherscan(
        Op[] memory ops,
        address facade
    ) public returns(address proxy, address dictionary) {
        return createWithNewDictionaryEtherscan(ops, facade, msg.sender);
    }

    function createWithNewDictionaryEtherscan() public returns(address proxy, address dictionary) {
        return createWithNewDictionaryEtherscan(defaultOps.ops, defaultOps.facade, msg.sender);
    }

    /**
        2. Deploy UCS Proxy with New DictionaryUpgradeable
     */
    function createWithNewDictionaryUpgradeable(
        Op[] memory ops,
        address admin
    ) public returns(address proxy, address dictionary) {
        dictionary = _deployDictionaryUpgradeable(ops, address(this));
        proxy = _deployProxy(dictionary, admin);
        _transferDictionaryOwnership(dictionary, proxy);
    }

    function createWithNewDictionaryUpgradeable(
        Op[] memory ops
    ) public returns(address proxy, address dictionary) {
        return createWithNewDictionaryUpgradeable(ops, msg.sender);
    }

    function createWithNewDictionaryUpgradeable() public returns(address proxy, address dictionary) {
        return createWithNewDictionaryUpgradeable(defaultOps.ops, msg.sender);
    }

    /**
        3. Deploy UCS Proxy with Existing DictionaryEtherscan
     */
    function createWithDictionaryEtherscan(
        address dictionary,
        address admin
    ) public returns(address) {
        return _deployProxyEtherscan(dictionary, admin);
    }

    function createWithDictionaryEtherscan(
        address dictionary
    ) public returns(address proxy) {
        return createWithDictionaryEtherscan(dictionary, msg.sender);
    }

    /**
        4. Deploy UCS Proxy with Existing DictionaryUpgradeable
     */
    function createWithDictionaryUpgradeable(
        address dictionary,
        address admin
    ) public returns(address) {
        return _deployProxy(dictionary, admin);
    }

    function createWithDictionaryUpgradeable(
        address dictionary
    ) public returns(address) {
        return createWithDictionaryUpgradeable(dictionary, msg.sender);
    }

    /**
        5. Deploy UCS Proxy with Owned DictionaryEtherscan
     */
    function createAndReplicateDictionaryEtherscan(
        address targetDictionary,
        address admin
    ) public returns(address proxy, address dictionary) {
        dictionary = _replicateDictionaryEtherscan(targetDictionary);
        proxy = _deployProxyEtherscan(dictionary, admin);
        _transferDictionaryOwnership(dictionary, proxy);
    }

    function createAndReplicateDictionaryEtherscan(
        address targetDictionary
    ) public returns(address proxy, address dictionary) {
        return createAndReplicateDictionaryEtherscan(targetDictionary, msg.sender);
    }

    /**
        6. Deploy UCS Proxy with Owned DictionaryUpgradeable
     */
    function createAndReplicateDictionaryUpgradeable(
        address targetDictionary,
        address admin
    ) public returns(address proxy, address dictionary) {
        dictionary = _replicateDictionaryUpgradeable(targetDictionary);
        proxy = _deployProxy(dictionary, admin);
        _transferDictionaryOwnership(dictionary, proxy);
    }

    function createAndReplicateDictionaryUpgradeable(
        address targetDictionary
    ) public returns(address proxy, address dictionary) {
        return createAndReplicateDictionaryUpgradeable(targetDictionary, msg.sender);
    }

    /****************
        Internals
     ****************/
    function _deployDictionaryEtherscan(Op[] memory _ops, address _facade, address _admin) internal returns(address _dictionary) {
        _dictionary = _createDictionaryEtherscan(_admin);
        _setOps(_dictionary, _ops);
        DictionaryEtherscan(_dictionary).upgradeFacade(_facade);
        // emit DictionaryDeployed(dictionary);
    }

    function _createDictionaryEtherscan(address _admin) internal returns(address) {
        return address(new DictionaryEtherscan(_admin));
    }

    function _deployDictionaryUpgradeable(Op[] memory _ops, address _admin) internal returns(address _dictionary) {
        _dictionary = _createDictionaryUpgradeableProxy(_admin);
        _setOps(_dictionary, _ops);
        // emit DictionaryDeployed(dictionary);
    }

    function _createDictionaryUpgradeableProxy(address _admin) internal returns(address) {
        return address(new ERC1967Proxy({
            implementation: dictionaryUpgradeableImpl,
            _data: abi.encodeWithSelector(DictionaryUpgradeable.initialize.selector, _admin)
        }));
    }

    function _setOps(address _dictionary, Op[] memory _ops) internal {
        for (uint i; i < _ops.length; ++i) {
            DictionaryBase(_dictionary).setImplementation(_ops[i].selector, _ops[i].implementation);
        }
    }

    function _deployProxyEtherscan(address _dictionary, address _admin) internal returns(address _proxy) {
        _proxy = address(new ERC7546ProxyEtherscan({
            dictionary: _dictionary,
            _data: abi.encodeWithSelector(InitSetAdminOp.initSetAdmin.selector, _admin)
        }));
        // emit ProxyDeployed(proxy);
    }

    function _deployProxy(address _dictionary, address _admin) internal returns(address _proxy) {
        _proxy = address(new ERC7546Proxy({
            dictionary: _dictionary,
            _data: abi.encodeWithSelector(InitSetAdminOp.initSetAdmin.selector, _admin)
        }));
        // emit ProxyDeployed(proxy);
    }

    function _replicateDictionaryEtherscan(address _targetDictionary) internal returns(address _dictionary) {
        _dictionary = _createDictionaryEtherscan(address(this));
        _copyOpsInDictionary({_from: _targetDictionary, _to: _dictionary});
    }

    function _replicateDictionaryUpgradeable(address _targetDictionary) internal returns(address _dictionary) {
        _dictionary = _createDictionaryUpgradeableProxy(address(this));
        _copyOpsInDictionary({_from: _targetDictionary, _to: _dictionary});
    }

    function _copyOpsInDictionary(address _from, address _to) internal {
        bytes4[] memory _selectors = DictionaryBase(_from).supportsInterfaces();
        for (uint i; i < _selectors.length; ++i) {
            bytes4 _selector = _selectors[i];
            if (_selector == bytes4(0)) continue;
            DictionaryBase(_to).setImplementation({
                functionSelector: _selector,
                implementation: DictionaryBase(_from).getImplementation(_selector)
            });
        }
    }

    function _transferDictionaryOwnership(address _dictionary, address _newAdmin) internal virtual {
        Ownable(_dictionary).transferOwnership(_newAdmin);
    }

    // TODO CreateX: https://github.com/pcaversaccio/createx 0xba5Ed099633D3B313e4D5F7bdc1305d3c28ba5Ed
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {DictionaryEtherscan} from "@ucs-contracts/src/dictionary/DictionaryEtherscan.sol";
import {ERC7546ProxyEtherscan} from "@ucs-contracts/src/proxy/ERC7546ProxyEtherscan.sol";
import {UCS} from "./UCS.sol";
import {FacadeDefaultOps} from "./interfaces/IDefaultOps.sol";
import {InitSetAdminOp} from "./ops/InitSetAdminOp.sol";

/**
 * UCS Create Contract v0.1.0
 */
contract UCSEtherscan is UCS {

    constructor(address dictionaryImpl, address initSetAdminOp, address setImplementationOp) UCS(dictionaryImpl, initSetAdminOp, setImplementationOp) {}

    function create(OpsType[] memory opsTypes, address admin) public override returns (address proxy) {
        // Deploy dictionary
        address _dictionary = address(new DictionaryEtherscan(address(this)));

        // Set Ops
        _setOps(_dictionary, opsTypes);

        // Set Facade
        _setFacade(_dictionary, opsTypes);

        // Deploy proxy
        proxy = _deployProxy(_dictionary, admin);

        // Transfer Dictionary's Ownership to proxy
        _transferDictionaryOwnership(_dictionary, proxy);
    }

    function _setFacade(address _dictionary, OpsType[] memory _opsTypes) internal {
        // Generate Facade: TODO
        address _newFacade = address(new FacadeDefaultOps());

        // Set Facade to the Dictionary
        DictionaryEtherscan(_dictionary).upgradeFacade(_newFacade);
    }

    function _deployProxy(address _dictionary, address _admin) internal override returns (address proxy) {
        proxy = address(new ERC7546ProxyEtherscan({
            dictionary: _dictionary,
            _data: abi.encodeWithSelector(InitSetAdminOp.initSetAdmin.selector, _admin)
        }));
        emit ProxyDeployed(proxy);
        // return ERC7546Clones.clone({
        //     dictionary: _dictionary,
        //     initData: abi.encodeWithSelector(InitSetAdminOp.initSetAdmin.selector, _admin)
        // });
    }

    function _transferDictionaryOwnership(address _dictionary, address _newAdmin) internal override {
        DictionaryEtherscan(_dictionary).transferOwnership(_newAdmin);
    }

}

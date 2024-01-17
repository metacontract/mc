// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {DictionaryUpgradeableEtherscan} from "@ucs-contracts/src/dictionary/DictionaryUpgradeableEtherscan.sol";
import {UCS} from "./UCS.sol";

/**
 * UCS Create Contract v0.1.0
 */
contract UCSEtherscan is UCS {

    function create(OpsType[] memory opsTypes, address admin) public override returns (address proxy) {
        // Deploy dictionary
        address _dictionary = _deployDictionary();

        // Set Ops
        _setOps(_dictionary, opsTypes);

        // Set Facade
        _setFacade();

        // Deploy proxy
        proxy = _deployProxy(_dictionary, admin);

        // Transfer Dictionary's Ownership to proxy
        _transferDictionaryOwnership(_dictionary, proxy);
    }

    function _setFacade(address _dictionary, OpsType[] memory _opsTypes) internal {
        // Generate Facade: TODO
        address _newFacade = address(new FacadeDefaultOps());

        // Set Facade to the Dictionary
        DictionaryUpgradeableEtherscan(_dictionary).setFa
    }
}

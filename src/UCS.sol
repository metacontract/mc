// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {ERC7546Clones} from "@ucs-contracts/ERC7546Clones.sol";
import {DictionaryUpgradeable} from "@ucs-contracts/dictionary/DictionaryUpgradeable.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {InitSetAdminOp} from "./ops/InitSetAdminOp.sol";

/**
 * UCS Create Contract v0.1.0
 */
contract UCS {
    enum OpsType {
        CloneOps,
        DAOOps
    }

    struct OpsData {
        bytes4 selector;
        address implementation;
    }

    mapping(OpsType => OpsData[]) public ops;

    /// @custom:storage-location erc7201:UCS.Create
    struct UCSStorage {
        address dictionaryImpl;
        address setAdminImpl;
    }

    bytes32 constant UCS_STORAGE_LOCATION = 0xf41184843362f551510bc0981514a9c4fd04b0389ced9eaf31ab37d09f68f95d;

    function $UCS() internal pure returns (UCSStorage storage $) {
        assembly {
            $.slot := UCS_STORAGE_LOCATION
        }
    }

    constructor(address dictionaryImpl, address setAdminImpl) {
        $UCS().dictionaryImpl = dictionaryImpl;
        $UCS().setAdminImpl = setAdminImpl;
    }

    function create(OpsType[] calldata opsTypes, address admin) public returns (address dictionary, address proxy) {
        // Deploy dictionary
        dictionary = address(new ERC1967Proxy($UCS().dictionaryImpl, abi.encodeWithSelector(DictionaryUpgradeable.initialize.selector, address(this))));

        DictionaryUpgradeable(dictionary).setImplementation(InitSetAdminOp.initSetAdmin.selector, $UCS().setAdminImpl);

        for (uint i; i < opsTypes.length; ++i) {
            if (opsTypes[i] == OpsType.CloneOps) {
                for (uint j; j < ops[OpsType.CloneOps].length; ++j) {
                    DictionaryUpgradeable(dictionary).setImplementation(ops[OpsType.CloneOps][j].selector, ops[OpsType.CloneOps][j].implementation);
                }
            }
        }

        proxy = ERC7546Clones.clone({
            _dictionary: dictionary,
            _initData: abi.encodeWithSelector(InitSetAdminOp.initSetAdmin.selector, admin)
        });
    }
}

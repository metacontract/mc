// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {ERC7546Clones} from "@ucs-contracts/ERC7546Clones.sol";
import {DictionaryUpgradeable} from "@ucs-contracts/dictionary/DictionaryUpgradeable.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {InitSetAdminOp} from "./ops/InitSetAdminOp.sol";
import {SetImplementationOp} from "./ops/SetImplementationOp.sol";
import {CloneOp} from "./ops/CloneOp.sol";

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
        address initSetAdminOp;
        address setImplementationOp;
    }

    bytes32 constant UCS_STORAGE_LOCATION = 0xf41184843362f551510bc0981514a9c4fd04b0389ced9eaf31ab37d09f68f95d;

    function $UCS() internal pure returns (UCSStorage storage $) {
        assembly {
            $.slot := UCS_STORAGE_LOCATION
        }
    }

    constructor(address dictionaryImpl, address initSetAdminOp, address setImplementationOp) {
        $UCS().dictionaryImpl = dictionaryImpl;
        $UCS().initSetAdminOp = initSetAdminOp;
        $UCS().setImplementationOp =setImplementationOp;
    }

    function create() public returns (address proxy) {
        OpsType[] memory _opsTypes = new OpsType[](1);
        _opsTypes[0] = OpsType.CloneOps;
        address _admin = msg.sender;

        create(_opsTypes, _admin);
    }

    function create(OpsType[] memory opsTypes) public returns (address proxy) {
        address _admin = msg.sender;

        create(opsTypes, _admin);
    }

    function create(OpsType[] memory opsTypes, address admin) public returns (address proxy) {
        // Deploy dictionary
        address _dictionary = _deployDictionary();

        // Set Ops
        _setOps(_dictionary, opsTypes);

        // Deploy proxy
        proxy = _deployProxy(_dictionary, admin);

        // Transfer Dictionary's Ownership to proxy
        _transferDictionaryOwnership(_dictionary, proxy);
    }

    function _deployDictionary() internal returns (address) {
        return address(new ERC1967Proxy($UCS().dictionaryImpl, abi.encodeWithSelector(DictionaryUpgradeable.initialize.selector, address(this))));
    }

    function _setOps(address _dictionary, OpsType[] memory _opsTypes) internal {
        DictionaryUpgradeable(_dictionary).setImplementation(InitSetAdminOp.initSetAdmin.selector, $UCS().initSetAdminOp);
        DictionaryUpgradeable(_dictionary).setImplementation(SetImplementationOp.setImplementation.selector, $UCS().setImplementationOp);

        for (uint i; i < _opsTypes.length; ++i) {
            if (_opsTypes[i] == OpsType.CloneOps) {
                for (uint j; j < ops[OpsType.CloneOps].length; ++j) {
                    DictionaryUpgradeable(_dictionary).setImplementation(ops[OpsType.CloneOps][j].selector, ops[OpsType.CloneOps][j].implementation);
                }
            }
        }
    }

    function _deployProxy(address _dictionary, address _admin) internal returns (address) {
        return ERC7546Clones.clone({
            dictionary: _dictionary,
            initData: abi.encodeWithSelector(InitSetAdminOp.initSetAdmin.selector, _admin)
        });
    }

    function _transferDictionaryOwnership(address _dictionary, address _newAdmin) internal {
        DictionaryUpgradeable(_dictionary).transferOwnership(_newAdmin);
    }

    struct SetOpsArgs {
        OpsType opsType;
        bytes4 selector;
        address implementation;
    }
    function setOps(SetOpsArgs[] calldata args) public {
        for (uint i; i < args.length; ++i) {
            ops[args[i].opsType].push(OpsData({
                selector: args[i].selector,
                implementation: args[i].implementation
            }));
        }
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {DictionaryUpgradeableEtherscan} from "@ucs-contracts/src/dictionary/DictionaryUpgradeableEtherscan.sol";

import {UCS} from "../src/UCS.sol";
import {InitSetAdminOp} from "../src/ops/InitSetAdminOp.sol";
import {SetImplementationOp} from "../src/ops/SetImplementationOp.sol";
import {CloneOp} from "../src/ops/CloneOp.sol";

library UCSEtherscanDeploySequence {

    function deployUCSEtherscan() internal returns (address ucs) {
        // Deploy deps
        address dictionaryImpl = address(new DictionaryUpgradeableEtherscan());
        address initSetAdminOp = address(new InitSetAdminOp());
        address setImplementationOp = address(new SetImplementationOp());

        // Deploy UCS create contract
        ucs = address(new UCS(dictionaryImpl, initSetAdminOp, setImplementationOp));

        // Set CloneOp
        address cloneOp = address(new CloneOp());
        UCS.SetOpsArgs[] memory _setOpsArgsList = new UCS.SetOpsArgs[](1);
        _setOpsArgsList[0] = UCS.SetOpsArgs({
            opsType: UCS.OpsType.CloneOps,
            selector: CloneOp.clone.selector,
            implementation: cloneOp
        });
        UCS(ucs).setOps(_setOpsArgsList);
    }
}

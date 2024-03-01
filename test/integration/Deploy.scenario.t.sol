// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {console2} from "forge-std/console2.sol";
import {UCSTest} from "../../utils/UCSTest.sol";
import {CloneOp} from "src/ops/CloneOp.sol";

contract DeployScenarioTest is UCSTest {
    function setUp() public startPrankWithDeployer {
        address proxy = ucs .deploy("MyProxy")
                            .set(ucs.ops.stdOps.clone)
                            .getProxy().toAddress();
        CloneOp(proxy).clone("");
        // address proxy = ucs .findDictionary("Default")
        //                     .deployProxy("MyProxy");
        // address proxy = ucs .deployDictionary("Default")
        //                     .deployProxy("MyProxy");
    }

    function test_Success_DeployNewProxy() public {
        // address proxy = newProxy();
    }
}

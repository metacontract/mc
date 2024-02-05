// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {console2} from "forge-std/console2.sol";
import {UCSTestBase} from "../../utils/UCSTestBase.sol";

contract DeployScenarioTest is UCSTestBase {
    function setUp() public startPrankWithDeployer() {}

    function test_Success_DeployNewProxy() public {
        address proxy = newProxy();
    }
}

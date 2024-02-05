// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {UCSScriptBase} from "../utils/UCSScriptBase.sol";

contract UCSDeployScript is UCSScriptBase {
    function setUp() public startBroadcastWithDeployerPrivKey {}
}

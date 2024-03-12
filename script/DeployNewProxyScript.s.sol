// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCScript} from "@devkit/MCScript.sol";
// import {IClone} from "@mc-std/interfaces/functions/IClone.sol";

contract DeployNewProxyScript is MCScript {
    function run() public startBroadcastWithDeployerPrivKey {
        // address proxy = newProxy();
        // address dictionary = getDictionary(proxy);
        // opNames.push(OpName.Clone);
        // setOps(dictionary, mc.opNames);
        // ICloneOp(proxy).clone("");
    }
}

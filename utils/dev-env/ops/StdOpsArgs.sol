// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {console2} from "dev-env/common/ForgeHelper.sol";
import {DevUtils} from "dev-env/common/DevUtils.sol";
import {StdOps, OpInfo} from "dev-env/UCSDevEnv.sol";

// Ops
import {InitSetAdminOp} from "src/ops/InitSetAdminOp.sol";
import {GetDepsOp} from "src/ops/GetDepsOp.sol";
import {CloneOp} from "src/ops/CloneOp.sol";
import {SetImplementationOp} from "src/ops/SetImplementationOp.sol";
import {StdOpsFacade} from "src/interfaces/facades/StdOpsFacade.sol";
import {DefaultOpsFacade} from "src/interfaces/facades/DefaultOpsFacade.sol";

/****************************************************
    🧩 Std Ops Primitive Utils for Arguments
*****************************************************/
library StdOpsArgs {
    function initSetAdminBytes(address admin) internal view returns(bytes memory) {
        return abi.encodeCall(InitSetAdminOp.initSetAdmin, admin);
    }

}

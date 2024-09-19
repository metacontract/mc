// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

// 💬 ABOUT
// Meta Contract's default Script based on Forge Std Script

// 🛠 FORGE STD INTERFACE
import {VmSafe} from "forge-std/Vm.sol";

// 📦 BOILERPLATE
import {MCScriptBase} from "./MCBase.sol";

// ⭐️ MC SCRIPT
abstract contract MCScript is MCScriptBase {
    function _saveAddrToEnv(address addr, string memory envKeyBase) internal {
        if (!vm.isContext(VmSafe.ForgeContext.ScriptBroadcast)) return;

        uint256 _chainId;
        assembly {
            _chainId := chainid()
        }
        string memory _chainIdString = vm.toString(_chainId);

        vm.writeLine(
            string.concat(vm.projectRoot(), "/.env"),
            string.concat(
                envKeyBase,
                _chainIdString,
                "=",
                vm.toString(address(addr))
            )
        );
    }
}

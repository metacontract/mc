// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Forge-std
import {Vm, VmSafe} from "forge-std/Vm.sol";
import {stdToml} from "forge-std/StdToml.sol";
// MC Devkit
import {Logger} from "devkit/system/Logger.sol";
import {Parser} from "devkit/types/Parser.sol";

// Constants
/// @dev address(uint160(uint256(keccak256("hevm cheat code"))));
Vm constant vm = Vm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

function loadAddressFrom(string memory envKey) view returns(address) {
    return ForgeHelper.loadAddressFromEnv(envKey);
}

/**************************************
    🛠 Helper Methods for Forge Std
**************************************/
library ForgeHelper {
    using stdToml for string;
    using Parser for string;

    /**-------------------
        🔧 Env File
    ---------------------*/
    function getPrivateKey(string memory envKey) internal view returns(uint256) {
        return uint256(vm.envBytes32(envKey));
    }

    function loadAddressFromEnv(string memory envKey) internal view returns(address) {
        return vm.envOr(envKey, address(0));
    }

    // TODO: check version
    function canGetDeployedContract(string memory envKey) internal view returns(bool) {
        if (vm.envOr(envKey, address(0)).code.length != 0) return true;
        return false;
    }


    /**------------------
        📍 Address
    --------------------*/
    function loadAddress(address target, bytes32 slot) internal view returns(address) {
        return address(uint160(uint256(vm.load(target, slot))));
    }

    function assumeAddressIsNotReserved(address addr) internal pure {
        vm.assume(
            addr != address(1) &&
            addr != address(2) &&
            addr != address(3) &&
            addr != address(4) &&
            addr != address(5) &&
            addr != address(6) &&
            addr != address(7) &&
            addr != address(8) &&
            addr != address(9) &&
            addr != 0x4e59b44847b379578588920cA78FbF26c0B4956C &&
            addr != 0x7109709ECfa91a80626fF3989D68f67F5b1DD12D &&
            addr != 0x000000000000000000636F6e736F6c652e6c6f67
        );
    }


    /**----------------
        📓 Context
    ------------------*/
    function msgSender() internal returns(address) {
        (VmSafe.CallerMode callerMode_, address msgSender_,) = vm.readCallers();
        if (callerMode_ == VmSafe.CallerMode.None) return address(this);
        return msgSender_;
    }


    /**---------------
        🏷️ Label
    -----------------*/
    function assignLabel(address addr, string memory name) internal returns(address) {
        vm.label(addr, name);
        return addr;
    }

    function getLabel(address addr) internal view returns(string memory) {
        return vm.getLabel(addr);
    }

    /**--------------
        📂 TOML
    ----------------*/
    function readBoolOr(string memory toml, string memory key, bool or) internal returns(bool) {
        return vm.keyExistsToml(toml, key) ? toml.readBool(key) : or ;
    }
    function readStringOr(string memory toml, string memory key, string memory or) internal returns(string memory) {
        return vm.keyExistsToml(toml, key) ? toml.readString(key) : or ;
    }
    function readUintOr(string memory toml, string memory key, uint or) internal returns(uint) {
        return vm.keyExistsToml(toml, key) ? toml.readUint(key) : or ;
    }
    function readLogLevelOr(string memory toml, string memory key, Logger.Level or) internal returns(Logger.Level) {
        return vm.keyExistsToml(toml, key) ? toml.readString(key).toLogLevel() : or ;
    }

    /**------------------
        📡 Broadcast
    --------------------*/
    function pauseBroadcast() internal {
        (VmSafe.CallerMode mode,,) = vm.readCallers();
        if (mode == VmSafe.CallerMode.RecurrentBroadcast) vm.stopBroadcast();
    }
    function resumeBroadcast() internal {
        (VmSafe.CallerMode mode,,) = vm.readCallers();
        if (mode == VmSafe.CallerMode.RecurrentBroadcast) vm.startBroadcast(getPrivateKey("DEPLOYER_PRIV_KEY")); // Without CALL TODO
    }

}

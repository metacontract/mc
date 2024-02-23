// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Vm} from "forge-std/Vm.sol";
import {console2} from "forge-std/console2.sol";
import {StdStyle} from "forge-std/StdStyle.sol";

// Constants
/// @dev address(uint160(uint256(keccak256("hevm cheat code"))));
Vm constant vm = Vm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

/**************************************
    🛠 Helper Methods for Forge Std
**************************************/
library ForgeHelper {
    function getPrivateKey(string memory keyword) internal view returns(uint256) {
        return uint256(vm.envBytes32(keyword));
    }

    function getAddressOrZero(string memory keyword) internal view returns(address) {
        return getAddressOr(keyword, address(0));
    }

    function getAddressOr(string memory keyword, address addr) internal view returns(address) {
        return vm.envOr(keyword, addr);
    }

    function tryGetDeployedContract(string memory keyword) internal returns(bool success, address deployedContract) {
        deployedContract = getAddressOrZero(keyword);
        if (deployedContract.code.length != 0) success = true;
    }

    // backlog: checkLatest Op?
    function canGetDeployedContract(string memory keyword) internal returns(bool) {
        if (vm.envOr(keyword, address(0)).code.length != 0) return true;
        return false;
    }

    function assumeAddressIsNotReserved(address addr) internal {
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

    function assignLabel(address addr, string memory name) internal returns(address) {
        vm.label(addr, name);
        return addr;
    }

    function loadAddress(address target, bytes32 slot) internal returns(address) {
        return address(uint160(uint256(vm.load(target, slot))));
    }

    function msgSender() internal returns(address msgSender) {
        (,msgSender,) = vm.readCallers();
    }

}

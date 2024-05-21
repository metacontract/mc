// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/console.sol";
import "forge-std/Script.sol";

contract ERC7201Calc is Script {
    function run() public {
        try vm.prompt("storage location") returns (string memory storage_location) {
            run(storage_location);
        } catch (bytes memory) {
            console.log("Error, you might need to run `foundryup`.");
        }
    }

    function run(string memory storage_location) public view {
        bytes32 res = keccak256(abi.encode(uint256(keccak256(abi.encodePacked(storage_location))) - 1)) & ~bytes32(uint256(0xff));
        console.logBytes32(res);
    }
}

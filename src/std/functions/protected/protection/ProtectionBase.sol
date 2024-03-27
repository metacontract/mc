// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

abstract contract ProtectionBase {
    /// @dev Write your own reusable protection (e.g., for DAO, for AA wallets, for onlyOwner, for token holders and stakers)

    // NOTE: The `initializer` modifier in this sample code does not actually perform any checks. Please DO NOT use it as is in production.
    modifier initializer() {
        _;
    }
}

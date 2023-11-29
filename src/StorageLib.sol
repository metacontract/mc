// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

library StorageLib {
    /*********************
        OwnerStorage
     ********************/
    /// @custom:storage-location erc7201:ucs.operation.Owner
    struct OwnerStorage {
        address owner;
    }
    bytes32 internal constant OWNER_STORAGE_LOCATION = 0xf14ccab36e70fe6703d70047fd9f791010c6456c7ac5d1945a4518f360bd1fe3;

    function $Owner() internal pure returns (OwnerStorage storage $) {
        assembly { $.slot := OWNER_STORAGE_LOCATION }
    }
}

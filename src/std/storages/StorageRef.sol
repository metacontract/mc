// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import {
    StorageSchema,
    ADMIN_STORAGE_LOCATION,
    CLONES_STORAGE_LOCATION,
    PROPOSAL_STORAGE_LOCATION,
    MEMBER_STORAGE_LOCATION,
    FEATURE_TOGGLE_STORAGE_LOCATION,
    INITIALIZATION_STORAGE_LOCATION
} from "./StorageSchema.sol";

/**
 * StorageRef v0.1.0
 */
library StorageRef {
    function Admin() internal pure returns (StorageSchema.AdminStorage storage ref) {
        assembly { ref.slot := ADMIN_STORAGE_LOCATION }
    }

    function Clones() internal pure returns (StorageSchema.ClonesStorage storage ref) {
        assembly { ref.slot := CLONES_STORAGE_LOCATION }
    }

    function Proposal() internal pure returns (StorageSchema.ProposalStorage storage ref) {
        assembly { ref.slot := PROPOSAL_STORAGE_LOCATION }
    }

    function Member() internal pure returns (StorageSchema.MemberStorage storage ref) {
        assembly { ref.slot := MEMBER_STORAGE_LOCATION }
    }

    function FeatureToggle() internal pure returns (StorageSchema.FeatureToggleStorage storage ref) {
        assembly { ref.slot := FEATURE_TOGGLE_STORAGE_LOCATION }
    }

    function Initialization() internal pure returns (StorageSchema.InitializationStorage storage ref) {
        assembly { ref.slot := INITIALIZATION_STORAGE_LOCATION }
    }

}

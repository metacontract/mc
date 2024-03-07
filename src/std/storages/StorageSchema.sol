// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

bytes32 constant ADMIN_STORAGE_LOCATION = 0xc87a8b268af18cef58a28e8269c607186ac6d26eb9fb11e976ba7fc83fbc5b00;
bytes32 constant CLONES_STORAGE_LOCATION = 0x17185741da5b9e949c020a46d4a02b1d6934675af587f69cbadf1932701e4b00;
bytes32 constant PROPOSAL_STORAGE_LOCATION = 0x45b916c98aa7f2144e93d3db7f57085183272dde7ad2a807f6e0da02b595f700;
bytes32 constant MEMBER_STORAGE_LOCATION = 0xb02ea24c1f86ea07e6c09d7d408e6de4225369a86f387a049c2d2fcaeb5d4c00;
bytes32 constant FEATURE_TOGGLE_STORAGE_LOCATION = 0xfbe5942bf8b77a2e1fdda5ac4fad2514a8894a997001808038d8cb6785c1d500;
bytes32 constant INITIALIZATION_STORAGE_LOCATION = 0x3a761698c158d659b37261358fd236b3bd53eb7608e16317044a5253fc82ad00;

/**
 * StorageSchema v0.1.0
 */
library StorageSchema {
     /// @custom:storage-location erc7201:mc.std.admin
    struct AdminStorage {
        address admin;
    }

    /// @custom:storage-location erc7201:mc.std.clones
    struct ClonesStorage {
        address dictionary;
    }

    /// @custom:storage-location erc7201:mc.std.proposal
    struct ProposalStorage {
        Proposal[] proposals;
    }
        struct Proposal {
            ProposalHeader header;
            ProposalBody[] bodies;
        }
            struct ProposalHeader {
                ProposalType proposalType;
            }
            enum ProposalType {
                Undefined,
                MEMBERSHIP_STOCK_TOKEN_RULE,
                MEMBERSHIP_REPS_MAJORITY_RULE,
                LEGISLATION
            }
            struct ProposalBody {
                uint80 forkRefIndex;
                string overview;
                Op[] ops;
            }
            struct Op {
                bytes data;
            }

    /// @custom:storage-location erc7201:mc.std.member
    struct MemberStorage {
        address[] members;
    }

    /// @custom:storage-location erc7201:mc.std.featureToggle
    struct FeatureToggleStorage {
        mapping(bytes4 selector => bool) disabledFeature;
    }

    /// @custom:storage-location erc7201:mc.std.initializer
    struct InitializationStorage {
        uint64 initialized;
        bool initializing;
    }

}

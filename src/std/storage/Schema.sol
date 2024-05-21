// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

/**
 * Storage Schema v0.1.0
 */
interface Schema {
     /// @custom:storage-location erc7201:mc.std.admin
    struct $Admin {
        address admin;
    }

    /// @custom:storage-location erc7201:mc.std.clone
    struct $Clone {
        address dictionary;
    }

    /// @custom:storage-location erc7201:mc.std.proposal
    struct $Proposal {
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
    struct $Member {
        address[] members;
    }

    /// @custom:storage-location erc7201:mc.std.featureToggle
    struct $FeatureToggle {
        mapping(bytes4 selector => bool) disabledFeature;
    }

    /// @custom:storage-location erc7201:mc.std.initializer
    struct $Initialization {
        uint64 initialized;
        bool initializing;
    }

}

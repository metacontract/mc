// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

/**
 * StorageLib v0.1.0
 */
library StorageLib {
    /*********************
     *  OwnerStorage
     *  @custom:storage-location erc7201:UDS.Operation.Owner
     ********************/
    struct OwnerStorage {
        address owner;
    }
    bytes32 internal constant OWNER_STORAGE_LOCATION = 0xf14ccab36e70fe6703d70047fd9f791010c6456c7ac5d1945a4518f360bd1fe3;

    function $Owner() internal pure returns (OwnerStorage storage $) {
        assembly { $.slot := OWNER_STORAGE_LOCATION }
    }

    /*********************
     *  ProposalStorage
     *  @custom:storage-location erc7201:UDS.Operation.Proposal
     ********************/
    struct ProposalStorage {
        Proposal[] proposals;
    }
    bytes32 internal constant PROPOSAL_STORAGE_LOCATION = 0xf14ccab36e70fe6703d70047fd9f791010c6456c7ac5d1945a4518f360bd1fe3;

    function $Proposal() internal pure returns (ProposalStorage storage $) {
        assembly { $.slot := PROPOSAL_STORAGE_LOCATION }
    }

    /*********************
     *  MemberStorage
     *  @custom:storage-location erc7201:UDS.Operation.Member
     ********************/
    struct MemberStorage {
        address[] members;
    }
    bytes32 internal constant MEMBER_STORAGE_LOCATION = 0xf14ccab36e70fe6703d70047fd9f791010c6456c7ac5d1945a4518f360bd1fe3;

    function $Member() internal pure returns (MemberStorage storage $) {
        assembly { $.slot := MEMBER_STORAGE_LOCATION }
    }
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

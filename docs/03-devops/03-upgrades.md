---
title: "Upgrades"
version: 0.1.0
lastUpdated: 2024-09-09
author: Meta Contract DevOps Team
scope: devops
type: guide
tags: [upgrades, smart-contracts, blockchain, foundry, metacontract]
relatedDocs: ["01-tdd.md", "02-deployment.md", "04-ci-cd.md"]
changeLog:
  - version: 0.1.0
    date: 2024-09-09
    description: Initial version of the upgrades guide
---

# Upgrades

This guide outlines the upgrade mechanisms available in Meta Contract and how to safely implement contract upgrades using Foundry.

## Table of Contents

1. [Understanding Meta Contract Upgrades](#understanding-meta-contract-upgrades)
2. [Preparing for an Upgrade](#preparing-for-an-upgrade)
3. [Implementing the Upgrade](#implementing-the-upgrade)
4. [Testing Upgraded Contracts](#testing-upgraded-contracts)
5. [Deploying the Upgrade](#deploying-the-upgrade)
6. [Post-Upgrade Verification](#post-upgrade-verification)
7. [Security Considerations](#security-considerations)
8. [Best Practices](#best-practices)

## Understanding Meta Contract Upgrades

Meta Contract uses a unique upgradeability system that allows for:

1. **Function-Level Upgrades**: Ability to upgrade specific functions without affecting the entire contract.
2. **Storage Layout Preservation**: Ensures that existing storage is not corrupted during upgrades.
3. **Upgrade Access Control**: Restricts who can perform upgrades to maintain security.

## Preparing for an Upgrade

1. **Identify the Need**: Determine which functions or components need upgrading.
2. **Design the Upgrade**: Plan the changes, ensuring they don't conflict with existing storage layout.
3. **Create New Implementation**: Write the new implementation contract with the upgraded functions.

## Implementing the Upgrade

Use Foundry and Meta Contract's DevKit to create and test the upgrade:

1. Create a new implementation contract:

    ```solidity
    // File: src/voting-system/functions/VoteV2.sol

    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.24;

    import {Storage, Schema} from "bundle/voting-system/storages/Storage.sol";

    contract VoteV2 {
        // Implementation
        function vote(uint256 proposalId) public {
            Schema.Proposal storage $proposal = Storage.Proposals().getProposal(proposalId);

            // Check if the proposal exists
            if (!$proposal.exists()) revert VotingSystemErrors.ProposalNotFound();

            // Check if the voter has already voted
            if ($proposal.hasVoted(msg.sender)) revert VotingSystemErrors.AlreadyVoted();

            // Record the vote
            $proposal.setVote(msg.sender, true);

            // Emit event
            emit VoteCast(proposalId, msg.sender);
        }
    }

    // Unit Testing
    import {MCTest} from "@devkit/Flattened.sol";
    import {VotingSystemErrors} from "bundle/voting-system/interfaces/VotingSystemErrors.sol";
    import {VotingSystemEvents} from "bundle/voting-system/interfaces/VotingSystemEvents.sol";

    contract VoteV2Test is MCTest {
        function setUp() public {
            address _voteV2 = address(new VoteV2());
            _use(Vote.vote.selector, _voteV2);
        }

        function test_vote_success() public {
            // Setup: Create a proposal
            uint256 proposalId = 1;
            Storage.Proposals().createProposal(proposalId, Schema.Proposal({exists: true, ...}));

            // Test: Expect VoteCast event
            vm.expectEmit();
            emit VoteCast(proposalId, address(this));

            // Action: Cast a vote
            Vote(target).vote(proposalId);

            // Assert: Check that the vote was recorded
            assertTrue(Storage.Proposals().getProposal(proposalId).hasVoted(address(this)));
        }

        function test_vote_alreadyVoted() public {
            // Setup: Create a proposal and record a vote
            uint256 proposalId = 1;
            Storage.Proposals().createProposal(proposalId, Schema.Proposal({exists: true, ...}));
            Storage.Proposals().setVote(proposalId, address(this), true);

            // Test: Expect revert
            vm.expectRevert(VotingSystemErrors.AlreadyVoted.selector);

            // Action: Attempt to vote again
            Vote(target).vote(proposalId);
        }
    }
    ```

2. Create an upgrade script:

    ```solidity
    // scripts/Upgrade.s.sol

    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.24;

    import {MCScript} from "@devkit/Flattened.sol";
    import {VotingSystemUpgrader} from "script/VotingSystemUpgrader.sol";

    contract UpgradeVoteToV2Script is MCScript {
        function run() public startBroadcastWith("DEPLOYER_PRIV_KEY") {
            address votingSystem = vm.envAddress("VOTING_SYSTEM_PROXY_ADDR");
            VotingSystemUpgrader.upgradeVoteToV2(mc, votingSystem);
        }
    }
    ```

    ```solidity
    // script/VotingSystemUpgrader.s.sol

    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.24;

    import {VoteV2} from "bundle/voting-system/functions/VoteV2.sol";
    import {VotingSystemFacade} from "bundle/voting-system/interfaces/VotingSystemFacade.sol";

    library VotingSystemUpgrader {
        /**
        * @dev Upgrade the VotingSystem contract
        * @param mc MCDevKit storage reference
        * @return votingSystem Address of the deployed VotingSystem proxy
        */
        function upgradeVoteToV2(MCDevKit storage mc, address votingSystem) internal {
            Dictionary memory _dictionary = mc.loadDictionary("Dictionary", mc.getDictionaryAddress(votingSystem));
            address _voteV2_ = address(new VoteV2());
            _dictionary.set(VoteV2.vote.selector, _voteV2);

            // Upgrade facade if needed
            _dictionary.upgradeFacade(address(new VotingSystemFacade()));
        }
    }
    ```

<!-- ## Testing Upgraded Contracts

1. Write tests for the new implementation:

    ```solidity
    // test/MyContractV2.t.sol
    pragma solidity ^0.8.13;

    import "forge-std/Test.sol";
    import "../contracts/MyContractV2.sol";

    contract MyContractV2Test is Test {
        MyContractV2 public myContract;

        function setUp() public {
            myContract = new MyContractV2();
            myContract.initializer();
        }

        function testNewFunction() public {
            assertEq(myContract.newFunction(), "This is a new function");
        }

        function testUpgradedExistingFunction() public {
            assertEq(myContract.existingFunction(), 42);
        }
    }
    ```

2. Run the tests:

    ```bash
    forge test
    ``` -->

## Deploying the Upgrade

1. Run and check the result the upgrade script using Foundry in the local environment with on-chain state:
    ```bash
    forge script UpgradeVoteToV2Script --rpc-url <YOUR_RPC_URL>
    ```

2. Run the script with sending transactions
    ```bash
    forge script UpgradeVoteToV2Script --rpc-url <YOUR_RPC_URL> --broadcast
    ```

## Post-Upgrade Verification

1. **Functional Testing**: Verify that new functions work and existing functions haven't been adversely affected.
2. **Storage Integrity**: Ensure that existing data in the contract has been preserved.
3. **Event Monitoring**: Check for successful upgrade events emitted by the dictionary contract.
4. **Documentation Update**: Update project documentation to reflect the changes in the new version.

By following this guide, you can safely plan, implement, and deploy upgrades to your Meta Contract projects using Foundry.

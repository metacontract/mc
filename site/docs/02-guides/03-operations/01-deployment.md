---
keywords: [deployment, smart-contracts, blockchain, foundry, metacontract]
tags: [deployment, smart-contracts, blockchain, foundry, metacontract]
last_update:
  date: 2024-10-28
  author: Meta Contract DevOps Team
---

# Deployment

This guide outlines the best practices and strategies for deploying Meta Contract projects to various blockchain networks using Foundry.

## Table of Contents

1. [Pre-Deployment Checklist](#pre-deployment-checklist)
2. [Deployment Process](#deployment-process)
3. [Post-Deployment Steps](#post-deployment-steps)
4. [Security Considerations](#security-considerations)
5. [Gas Optimization](#gas-optimization)

## Pre-Deployment Checklist

Before deploying your Meta Contract project, ensure you've completed the following:

1. **Code Review**: Conduct thorough code reviews, including peer reviews and potentially external audits.
2. **Testing**: Complete all unit and integration tests with high coverage using Foundry.
3. **Gas Optimization**: Perform gas optimization to ensure efficient contract execution.
4. **Documentation**: Prepare comprehensive documentation for your contract's functions and usage.

## Deployment Process

### 1. Choose the Deployment Network

- **Testnet Deployment**: Always deploy to a testnet (e.g., Sepolia, Holesky) before mainnet deployment.
- **Mainnet Deployment**: Only deploy to mainnet after thorough testing and auditing.

### 2. Prepare Deployment Scripts

Use Foundry's `script` feature and mc's custom script template to create deployment scripts:

```solidity
// script/DeployVotingSystem.s.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCScript} from "@mc-devkit/Flattened.sol";
import {VotingSystemDeployer} from "script/VotingSystemDeployer.sol";

contract DeployVotingSystemScript is MCScript {
    function run() public startBroadcastWith("DEPLOYER_PRIV_KEY") {
        VotingSystemDeployer.deploy(mc, deployer);
    }
}
```

```solidity
// script/VotingSystemDeployer.s.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {VotingSystemFacade} from "bundle/voting-system/interfaces/VotingSystemFacade.sol";

library VotingSystemDeployer {
    string internal constant BUNDLE_NAME = "VotingSystem";

    /**
     * @dev Deploys the VotingSystem contract
     * @param mc MCDevKit storage reference
     * @return votingSystem Address of the deployed VotingSystem proxy
     */
    function deploy(MCDevKit storage mc, address initialMember) internal returns(address votingSystem) {
        mc.init(BUNDLE_NAME);

        address _vote = address(new Vote());
        _use(Vote.vote.selector, _vote);
        address _tally = address(new Tally());
        _use(Tally.tally.selector, _tally);

        mc.useFacade(address(new VotingSystemFacade())); // for Etherscan proxy read/write

        return mc.deploy(
            abi.encodeCall(Initialize.initialize, (initialMember))
        ).toProxyAddress();
    }
}
```

### 3. Deploy the Contract

1. Run and check the result the deployment script using Foundry in the local environment with on-chain state:
    ```bash
    forge script DeployVotingSystemScript --rpc-url <YOUR_RPC_URL>
    ```

2. Run the script with sending transactions
    ```bash
    forge script DeployVotingSystemScript --rpc-url <YOUR_RPC_URL> --broadcast --verify
    ```

### 4. Verify Contract Source Code

Foundry automatically verifies the contract if the `--verify` flag is used during deployment. If manual verification is needed:

```bash
forge verify-contract <DEPLOYED_CONTRACT_ADDRESS> src/MyContract.sol:MyContract
```

## Post-Deployment Steps

1. **Functional Testing**: Perform thorough testing on the deployed contract to ensure all functions work as expected.
2. **Monitoring Setup**: Implement monitoring solutions to track contract interactions and events.
3. **Documentation Update**: Update your project documentation with the deployed contract addresses and any network-specific information.

## Security Considerations

- **Private Key Management**: Use secure methods to manage private keys, such as hardware wallets or key management services.
- **Multisig Wallets**: Consider using multisig wallets for contract ownership and management of valuable assets.
- **Gradual Rollout**: For high-value contracts, consider a gradual rollout strategy to minimize potential risks.

## Gas Optimization

Foundry provides tools for gas optimization:

1. Use `forge snapshot` to track gas usage over time.
2. Implement gas optimizations in your contract code.
3. Use Foundry's gas reports to identify high-gas-usage functions:
    ```bash
    forge test --gas-report
    ```

By following this deployment guide, you can ensure a smooth and secure deployment process for your Meta Contract projects using Foundry.

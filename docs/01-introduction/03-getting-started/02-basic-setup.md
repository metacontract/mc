---
title: "Basic Setup"
version: 0.1.0
lastUpdated: 2024-09-06
author: Meta Contract Development Team
scope: dev
type: guide
tags: [setup, configuration, development-environment]
relatedDocs: ["01-installation.md", "../../02-tutorials/01-simple-dao.md"]
changeLog:
  - version: 0.1.0
    date: 2024-09-06
    description: Initial version of the basic setup guide
---

# Basic Setup

This guide will walk you through the process of setting up your development environment for working with Meta Contract.

## Prerequisites

Before proceeding with the setup, ensure you have completed the [installation process](01-installation.md) for Meta Contract.

## Development Environment Setup

### 1. Code Editor Configuration

We recommend using Visual Studio Code (VSCode) with the following extensions:

- [Solidity by Juan Blanco](https://github.com/juanfranblanco/vscode-solidity)

To install these extensions:

1. Open Cursor/VSCode
2. Go to the Extensions view
3. Search for and install each extension

### 2. Configuring Foundry

Meta Contract uses Foundry as its development framework. To configure Foundry for your project:

1. Create a [foundry.toml](https://github.com/metacontract/template/blob/main/foundry.toml) file in your project root if it doesn't exist already:

```toml
[profile.default]
src = "src"
out = "out"
libs = ["lib"]
fs_permissions = [{ access = "read", path = "./mc.toml" }, { access = "read", path = "./lib/mc/mc.toml" }]
```

This configuration file specifies:
- `src`: The directory containing your source files
- `out`: The directory where compiled artifacts will be stored
- `libs`: The directory containing your project dependencies
- `fs_permissions`: Permissions for reading specific files (in this case, MC configuration files)

### 3. Setting Up Environment Variables

Create a `.env` file in your project root to store sensitive information:

[Example .env file](https://github.com/metacontract/template/blob/main/.env.sample)

```
# Signer
DEPLOYER_ADDR=
DEPLOYER_PRIV_KEY=

# External services
RPC_URL=https://your-mainnet-rpc-url
SEPOLIA_RPC_URL=https://your-sepolia-rpc-url
VERIFIER=etherscan-api-endpoint
ETHERSCAN_API_KEY=your-etherscan-api-key
```

These environment variables are used for:
- `DEPLOYER_ADDR` and `DEPLOYER_PRIV_KEY`: The address and private key of the account used for deploying contracts
- `RPC_URL` and `SEPOLIA_RPC_URL`: RPC endpoints for interacting with the Ethereum mainnet and Sepolia testnet
- `VERIFIER` and `ETHERSCAN_API_KEY`: Used for contract verification on Etherscan

Make sure to add `.env` to your `.gitignore` file to prevent accidentally committing sensitive information.

### 4. Project Structure

Organize your project files as follows:

```
your-project/
├── src/
│   ├── [bundle name]
│   │   ├── storages
│   │   │   │── Schema.sol
│   │   │   └── Storage.sol
│   │   ├── interfaces
│   │   │   └── [e.g. Facade, IBundle, IFunctions, IErrors, IEvents files]
│   │   ├── functions
│   │   │   └── MyFunction.sol
│   ├── [other bundle directories if needed]
│   └── [shared utilities directory]
├── test/
│   └── MyContract.t.sol
├── script/
│   └── Deploy.s.sol
├── lib/
├── foundry.toml
├── .env
└── .gitignore
```

## Verifying the Setup

To ensure your setup is correct:

1. Build example counter contracts and run tests:

```bash
forge test
```

If this command executes without errors, your basic setup is complete and working correctly.

## Next Steps

Now that your development environment is set up, you're ready to start building with Meta Contract:

1. Explore the [Simple DAO Tutorial](../../02-tutorials/01-simple-dao.md) for a hands-on introduction to Meta Contract development.
2. Review the [MC DevKit Usage Guide](../../05-resources/03-devkit/01-usage.md) to learn about the development tools available.
3. Check out the [Best Practices](../../05-resources/05-best-practices/01-ai-tdd.md) for tips on efficient Meta Contract development.

For any issues or questions, reach out to our [community support channels](https://github.com/orgs/metacontract/discussions).

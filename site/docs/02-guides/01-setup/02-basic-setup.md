---
keywords: [setup, configuration, development-environment]
tags: [setup, configuration, development-environment]
last_update:
  date: 2024-10-28
  author: Meta Contract Development Team
---

# Basic Setup

This guide will walk you through the process of setting up your development environment for working with Meta Contract.

## Prerequisites

Before proceeding with the setup, ensure you have completed the [installation process](01-installation.md) for Meta Contract.

## Development Environment Setup

### 1. Code Editor Configuration

We recommend using [Cursor](https://www.cursor.sh/) / [Visual Studio Code (VSCode)](https://code.visualstudio.com/) with the following extensions:

- [Hardhat VSCode Extension](https://marketplace.visualstudio.com/items?itemName=NomicFoundation.hardhat-solidity) (Extension ID: `nomicfoundation.hardhat-solidity`)

  To install this extensions:
  1. Open Cursor/VSCode
  2. Go to the Extensions view
  3. Search for and install extension

  See details in [official instruction](https://marketplace.visualstudio.com/items?itemName=NomicFoundation.hardhat-solidity#installation).

:::info
[Solidity by Juan Blanco](https://github.com/juanfranblanco/vscode-solidity) is also very useful, but in the current version, it does not integrate well with the remappings that foundry uses by default, resulting in continuous import errors.
:::

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

Now that your development environment is set up, you're ready to start building with Meta Contract 🚀🚀🚀

- Refer to the [Development Guide](../02-development/), [Operation Guide](../03-operation/) and [Middleware Guide](../04-middleware/) for best practices and tips.
- Find implementation examples in the [Examples](../04-examples/) section.
- Check out the [MC DevKit API Reference](../../03-api/) for detailed information about the development tools available.

For any issues or questions, reach out to our [community support channels](https://github.com/metacontract/mc/discussions).

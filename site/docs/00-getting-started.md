---
sidebar_label: Getting Started
keywords: [meta-contract, installation, setup, development-environment]
tags: [meta-contract, installation, setup, development-environment]
last_update:
  date: 2024-10-26
  author: Meta Contract Development Team
---

# Meta Contract

Meta Contract is a Foundry-based smart contract framework designed to create flexible, upgradeable, and scalable blockchain applications. It implements the UCS (Upgradeable Clone for Scalable Contracts) architecture, providing developers with powerful tools to build and maintain complex decentralized systems.

:::caution
Please note that as it is still in the development version, there may be potentially breaking changes made without notice. Use it with caution.
:::

## Quick Start

Just run this:

```bash
forge init <project-name> -t metacontract/template
```

After the installation, run the following command to test the _Counter_ sample project and see how it works:

```bash
cd <project-name>
forge test
```

If you want to learn more about meta contract installation, please refer to [installation guide](./02-guides/01-setup/01-installation.md).

## Features

- **Upgradeability 🔄**: Meta Contracts can be upgraded without changing their address, allowing for seamless improvements and bug fixes.
- **Modularity 🗂️**: The framework separates contract logic into distinct, manageable components, enhancing code organization and reusability.
- **Scalability 📈**: Meta Contracts are designed to handle growth efficiently, making them suitable for large-scale applications.
- **Flexibility ⚙️**: Developers can easily extend and customize Meta Contracts to suit specific project needs.
- **Testability ✅**: The modular structure of Meta Contracts facilitates comprehensive testing, including unit tests for individual functions and integration tests for the entire system.

## Documentation Overview

This documentation is structured to guide you through the Meta Contract framework:

1. **[Concepts](./01-concepts/index.md)**: Understand the fundamental concepts and architecture of Meta Contract.
2. **[Guides](./02-guides/index.md)**: Learn about best practices for development, deployment, and operations.
3. **[API Reference](./03-api/index.md)**: Explore the API details and usage of the Meta Contract DevKit.
4. **[Examples](./04-examples/index.md)**: Review examples of various use cases.

Each section provides detailed information to help you effectively use and understand the Meta Contract framework. For more information, follow the links to each section.

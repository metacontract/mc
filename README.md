# Meta Contract ![Solidity][solidity-shield] [![License:MIT][license-shield]](./LICENSE)
<!-- [![CI][ci-shield]][ci-url] -->

[solidity-shield]: https://img.shields.io/badge/Built_with-Solidity-rgb(85,84,217)
[license-shield]: https://img.shields.io/badge/license-MIT-blue.svg
[ci-shield]: https://img.shields.io/github/actions/workflow/status/metacontract/mc/ci.yml?branch=main&label=build
[ci-url]: https://github.com/metacontract/mc/actions/workflows/ci.yml

Meta Contract is a Foundry-based smart contract framework designed to create flexible, upgradeable, and scalable blockchain applications. It implements the UCS ([ERC-7546: Upgradeable Clone for Scalable Contracts](https://eips.ethereum.org/EIPS/eip-7546)) architecture, providing developers with powerful tools to build and maintain complex decentralized systems.

> [!WARNING]
> This is still in the development version, which means it is an early version intended for testing and feedback purposes. Please be cautious when using this version in production environments, as it may contain bugs, incomplete features, or unexpected behavior.

## Features

- **Upgradeability**: Meta Contracts can be upgraded without changing their address, allowing for seamless improvements and bug fixes.
- **Modularity**: The framework separates contract logic into distinct, manageable components, enhancing code organization and reusability.
- **Scalability**: Meta Contracts are designed to handle growth efficiently, making them suitable for large-scale applications.
- **Flexibility**: Developers can easily extend and customize Meta Contracts to suit specific project needs.
- **Testability**: The modular structure of Meta Contracts facilitates comprehensive testing, including unit tests for individual functions and integration tests for the entire system.

## Getting Started

### Prerequisites

To use mc, you need to have [Foundry](https://github.com/foundry-rs/foundry) installed.

### Quick Start

Just run this:

```bash
forge init <Your Project Name> -t metacontract/template
```

After the installation, run the following command to test the _Counter_ sample project and see how it works:

```bash
cd <Your Project Name>
forge test
```

If you want to learn more about meta contract installation, please refer to [installation guide](https://mc-book.ecdysis.xyz/guides/setup/installation).

## Documentation

The [MC Book](https://mc-book.ecdysis.xyz/) serves as a comprehensive guide for developing with the meta contract. Also, you can find the markdown documents in [docs](./site/docs) directory.

## Contributing

We welcome contributions from the community! If you'd like to contribute to mc, please check out our [Contributing Guide](./CONTRIBUTING.md) for detailed instructions on how to:
- Report issues and bugs
- Submit feature requests
- Create pull requests
- Follow our [project management guidelines](https://mc-book.ecdysis.xyz/guides/project-management)
- Participate in discussions and decision-making

We appreciate your help in making meta contract even better!

## License
This meta contract is released under the [MIT License](./LICENSE).

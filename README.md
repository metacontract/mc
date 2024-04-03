# Meta Contract
A meta contract is a powerful framework for smart contract development, designed to enhance developer productivity and contract maintainability. Built on the principles of the *ERC-7546: UCS* (Upgradeable Clone Standard), this ***mc*** library provides a robust architecture for creating and managing upgradeable smart contracts.

> [!WARNING]
> This is an alpha release of the Meta Contract (mc) library, which means it is an early version intended for testing and feedback purposes. Please be cautious when using this version in production environments, as it may contain bugs, incomplete features, or unexpected behavior.

## Features
- **Upgradeable Contracts**: Create smart contracts that can be easily upgraded, allowing for continuous improvement and bug fixes without contract migration.
- **Modular Design**: A meta contract promotes a modular approach to contract development, enabling code reuse and reducing complexity.
- **Standard Functions**: Utilize a rich library of standard functions to streamline contract development and ensure consistency across your projects.
- **Development Kit**: Leverage the mc's Development Kit (DevKit) to simplify contract deployment, testing, and interaction.
- **Comprehensive Documentation**: Benefit from extensive documentation and guides to help you get started and make the most of mc's features.

## Getting Started
### Prerequisites
To use mc, you need to have the following software installed:
- [Foundry](https://github.com/foundry-rs/foundry) - a blazing fast, portable and modular toolkit for Ethereum application development.

### Installation
The mc can be installed using Foundry's `forge` command with useful template:

```sh
forge init <Your Project Name> -t metacontract/template
```

You can also install only this repository at your project root using:
```sh
forge install metacontract/mc
```

## Documentation
The [MC Book](https://mc-book.ecdysis.xyz/) serves as a comprehensive guide for developing with the meta contract. It covers a wide range of topics, including:
- Architecture overview
- Setting up your development environment
- Creating and deploying upgradeable contracts
- Using standard functions and libraries
- Testing and debugging your contracts
- Best practices and guidelines
You can find the source code for the MC Book on GitHub at [metacontract/book](https://github.com/metacontract/book).

## Contributing
We welcome contributions from the community! If you'd like to contribute to mc, please check out our [Contributing Guide](./CONTRIBUTING.md) for detailed instructions on how to:
- Report issues and bugs
- Submit feature requests
- Create pull requests
- Follow our coding style and guidelines
- Participate in discussions and decision-making
We appreciate your help in making mc even better!

## License
This mc is released under the [MIT License](./LICENSE).

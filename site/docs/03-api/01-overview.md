---
keywords: [devkit, overview, features]
tags: [devkit, overview, features]
last_update:
  date: 2024-10-28
  author: Meta Contract Development Team
---

# Overview

The Meta Contract DevKit is a comprehensive suite of tools and libraries designed to streamline the development process for Meta Contract projects. It provides developers with powerful utilities for scripting, testing, and managing the lifecycle of smart contract objects within the Meta Contract ecosystem.

## Key Features

1. **Testing Helpers**: Provides a set of functions and modifiers to simulate various scenarios and streamline the testing process.

2. **Scripting Utilities**: Facilitates deployment and upgrade scripts and interaction sequences with built-in transaction broadcasting capabilities.

3. **Object Lifecycle Management**: Offers a robust system for managing the states and transitions of core Meta Contract objects (Function, Bundle, Proxy, Dictionary) to efficiently handle the core architecture known as UCS.

4. **Integration with Foundry**: Seamlessly integrates with the Foundry development environment, enhancing its capabilities for Meta Contract development.

5. **Customizable Configurations**: Allows developers to easily configure and adapt the development environment to their specific project needs.

## Components

The DevKit consists of two base contracts:

- **MCTest**: A base contract for writing and running tests. Within contracts that inherit from MCTest, you can utilize the primary object `mc` for various testing functionalities.

- **MCScript**: A base contract for deployment and interaction scripts. Contracts inheriting from MCScript can also use the primary object `mc` to facilitate deployment and interaction processes.

## How to Use

To start using the Meta Contract DevKit, refer to the [Usage Guide](./02-usage.md) for detailed instructions on installation, setup, and basic usage patterns.

For a deep dive into the API and available functions, check out the [DevKit API Details](./03-api-details/index.md).

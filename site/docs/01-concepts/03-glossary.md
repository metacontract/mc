---
keywords: [glossary, definitions, concepts, meta-contract, architecture, proxy, dictionary, function-contracts, upgradeability, cloneability, ucs]
tags: [glossary, definitions, concepts, meta-contract, architecture, proxy, dictionary, function-contracts, upgradeability, cloneability, ucs]
last_update:
  date: 2024-10-28
  author: Meta Contract Development Team
---

# Glossary

## Meta Contract

A Foundry-based framework for creating flexible, upgradeable, and scalable blockchain applications using the UCS architecture.

## UCS

Architecture for creating scalable contracts, introduced as [ERC-7546](https://eips.ethereum.org/EIPS/eip-7546).

## Proxy Contract

Manages state and delegates function calls to Function Contracts.

## Dictionary Contract

Registry mapping function selectors to Function Contracts, allowing upgrades.

## Function Contracts

Stateless contracts implementing specific functionalities, upgradeable independently.

## Function Delegation

Process of delegating calls to Function Contracts based on selectors.

## MCTest

Functions and modifiers for testing scenarios.

## MCScript

Deployment and upgrade scripts with transaction broadcasting.

## DevKit

Tools and libraries for developing Meta Contract projects, aiding in scripting, testing, and lifecycle management.

## mc

Core object in DevKit for testing and scripting functionalities.

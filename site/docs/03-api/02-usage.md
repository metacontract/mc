---
keywords: [devkit, usage, scripting, testing, UCS]
tags: [devkit, usage, scripting, testing, UCS]
last_update:
  date: 2024-10-28
  author: Meta Contract Development Team
---

# Usage Guide

This guide provides an overview of key functions and modifiers in the Meta Contract DevKit, focusing on their usage in scripting and testing scenarios.

## Primary Object

The primary object `mc` is available in both `MCTest` and `MCScript` base contracts. It provides a set of functions and modifiers for testing and scripting.

### mc.init

This function initializes the **bundle** with a given name, which is a set of functions acting as a proxy for the current meta contract. It prepares the bundle for use in both testing and scripting scenarios.

- Example usage:
    ```solidity
    function setUp() public {
        mc.init("MyBundle");
    }
    ```

### mc.use

This function sets the **function** with a given name, selector and address to be used for the current bundle.

- Example usage:
    ```solidity
    function setUp() public {
        mc.use("MyFunctionA", MyFunctionA.myFunctionA.selector, address(new MyFunctionA()));
        mc.use("MyFunctionB", MyFunctionB.myFunctionB.selector, address(new MyFunctionB()));
    }
    ```

### mc.deploy

This function deploys all contracts (including the bundled functions, dictionary and proxy) with a given init bytecode.

- Example usage:
    ```solidity
    function setUp() public {
        mc.deploy(abi.encodeCall(Initialize.initialize, (params1, params2)));
    }
    ```

### mc.toProxyAddress

This function returns the address of the proxy contract.

- Example usage:
    ```solidity
    function setUp() public {
        address myMetaContract = mc.toProxyAddress();
    }
    ```

## For Testing

For writing tests, you'll use the `MCTest` base contract. Here are some key functions and modifiers:

### startPrankWithDeployer

This modifier is used in testing to simulate transactions or function calls from the deployer's address.

```solidity
modifier startPrankWithDeployer();
```

**Example:**
```solidity
function setUp() public startPrankWithDeployer {
    // Test setup logic here
}
```

### setDictionary

This function allows manual setting or updating of the dictionary contract address for a target contract in tests.

```solidity
function setDictionary(address target, address dictionary) internal;
```

**Example:**
```solidity
setDictionary(proxy, dictionary);
```

### ignorePrecompiles

This function excludes precompiled contracts from consideration in certain test cases.

```solidity
function ignorePrecompiles(address target) internal;
```

**Example:**
```solidity
ignorePrecompiles(dictionary);
```

## For Scripting

When writing deployment or interaction scripts, you'll typically use the `MCScript` base contract. Here's a key modifier you'll often use:

### startBroadcastWithDeployerPrivKey

This modifier is used in scripting to broadcast transactions using the deployer's private key.

```solidity
modifier startBroadcastWithDeployerPrivKey();
```

**Example:**
```solidity
function run() public startBroadcastWithDeployerPrivKey {
    // Deployment script logic here
}
```

## Object Lifecycle Management

The DevKit provides a system for managing the lifecycle of core Meta Contract objects (Function, Bundle, Proxy, Dictionary) to efficiently handle the core architecture known as UCS.

### Core Objects
- Function
- Bundle
- Proxy
- Dictionary

### States
- ***Uninitialized***: The initial state of an object when it is created but not yet initialized.
- ***Building***: The state where the object is being constructed, and its member variables are being set.
- ***Built***: The state where the object is fully constructed and ready for use.
- ***Locked***: The state where the object is locked and cannot be modified.

### Methods
Key methods for lifecycle management include:

1. `startBuilding()`
    - Transitions the object from the _Uninitialized_ or _Built_ state to the _Building_ state.
    - Called when the object's member variables need to be modified.
    - Allows the object to be modified even if it was previously in the _Built_ state.
2. `finishBuilding()`
    - Attempts to transition the object from the _Building_ state to the _Built_ state.
    - Called after the object's member variables have been modified.
    - Checks if all the member variables are in a valid state.
        - If successful, transitions the object to the _Built_ state.
        - If unsuccessful, outputs a warning and keeps the object in the _Building_ state.
3. `lock()`
    - Transitions the object from the _Built_ state to the _Locked_ state.
    - Prevents any further modifications to the object.

### Diagram
```mermaid
stateDiagram-v2
    state Uninitialized
    state Building
    state Built
    state Locked
    state try <<choice>>
    Uninitialized --> Building: startBuilding()
    Building --> Building: startBuilding()
    Building --> try: finishBuilding()
    try --> Built: success
    try --> Building: failure
    Built --> Locked: lock()
    Built --> Building: startBuilding()

    classDef uninitialized fill:#FFD700,color:#333
    classDef building fill:#FFA500,color:#333
    classDef built fill:#7FFF00,color:#333
    classDef locked fill:#87CEEB,color:#333
    class Uninitialized uninitialized
    class Building building
    class Built built
    class Locked locked
```

## Best Practices

1. Always use the appropriate base contract (`MCTest` for testing, `MCScript` for scripting) to ensure access to all relevant DevKit features.
2. Leverage the object lifecycle management system to maintain the integrity of your Meta Contract objects throughout their usage.
3. Use the provided modifiers and functions to simulate different scenarios in your tests, ensuring comprehensive coverage of your contract's behavior.

For more advanced usage patterns and detailed API documentation, refer to the [DevKit API Details](./03-api-details/index.md) section.

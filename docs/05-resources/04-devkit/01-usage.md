# Usage

<!-- ## MCScript
- [startBroadcastWithDeployerPrivKey](./start-broadcast-with-deployer-priv-key) (modifier) -->

## startBroadcastWithDeployerPrivKey

### Signature
```solidity
modifier startBroadcastWithDeployerPrivKey();
```

### Description
This modifier facilitates the broadcasting of transactions with the deployer's private key during scripting. It's essential for scripting deployment and interaction sequences that require authentication as the deployer.

### Example
```solidity
function run() public startBroadcastWithDeployerPrivKey {}
```

<!-- ## MCTest

- [startPrankWithDeployer](./start-prank-with-deployer) (modifier)
- [setDictionary](./set-dictionary)
- [ignorePrecompiles](./ignore-precompile) -->

## startPrankWithDeployer

### Signature
```solidity
modifier startPrankWithDeployer();
```

### Description
This modifier is used to simulate transactions or function calls from the deployer's address during testing.

### Example
```solidity
function setUp() public startPrankWithDeployer {}
```

## setDictionary

### Signature
```solidity
function setDictionary(address target, address dictionary) internal;
```

### Description
Allows for the manual setting or updating for the `target address` of the `dictionary` contract used in tests. This method is crucial for testing contracts with different configurations or dependencies.

### Example
```solidity
setDictionary(proxy, dictionary);
```

## ignorePrecompiles

### Signature
```solidity
function ignorePrecompiles(address target) internal;
```

### Description
Excludes precompiled contracts from being considered in certain test cases. This method helps in focusing tests on the contract's logic by ignoring irrelevant external factors.

### Example
```solidity
ignorePrecompiles(dictionary);
```

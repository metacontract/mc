# IDictionaryCore
[Git Source](https://github.com/metacontract/mc/blob/20954f1387efa0bc72b42d3e78a22f9f845eebbd/src/devkit/Flattened.sol)


## Functions
### getImplementation


```solidity
function getImplementation(bytes4 selector) external view returns (address);
```

## Events
### NewFunctionSelectorAdded

```solidity
event NewFunctionSelectorAdded(bytes4 newSelector);
```

### ImplementationDeleted

```solidity
event ImplementationDeleted(bytes4 selector);
```

### ImplementationUpgraded

```solidity
event ImplementationUpgraded(bytes4 selector, address implementation);
```

## Errors
### ImplementationNotFound

```solidity
error ImplementationNotFound(bytes4 selector);
```

### InvalidImplementation

```solidity
error InvalidImplementation(address implementation);
```


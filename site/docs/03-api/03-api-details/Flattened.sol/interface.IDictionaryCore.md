# IDictionaryCore
[Git Source](https://github.com/metacontract/mc/blob/main/src/devkit/Flattened.sol)


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


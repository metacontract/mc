# IDictionaryCore
[Git Source](https://github.com/metacontract/mc/blob/df7a49283d8212c99bebd64a186325e91d34c075/resources/devkit/api-reference/Flattened.sol)


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


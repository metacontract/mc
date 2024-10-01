# IDictionaryCore
[Git Source](https://github.com/metacontract/mc/blob/8438d83ed04f942f1b69f22b0cb556723d88a8f9/resources/devkit/api-reference/Flattened.sol)


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


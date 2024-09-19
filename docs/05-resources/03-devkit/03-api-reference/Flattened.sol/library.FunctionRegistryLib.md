# FunctionRegistryLib
[Git Source](https://github.com/metacontract/mc/blob/20ed737f21a46d89afffe1322a75b1ecfcacff9a/src/devkit/Flattened.sol)


## Functions
### register

--------------------------
🗳️ Register Function
----------------------------


```solidity
function register(FunctionRegistry storage registry, string memory name, bytes4 selector, address implementation)
    internal
    returns (FunctionRegistry storage);
```

### find

----------------------
🔍 Find Function
------------------------


```solidity
function find(FunctionRegistry storage registry, string memory name) internal returns (Function storage func);
```

### findCurrent


```solidity
function findCurrent(FunctionRegistry storage registry) internal returns (Function storage func);
```


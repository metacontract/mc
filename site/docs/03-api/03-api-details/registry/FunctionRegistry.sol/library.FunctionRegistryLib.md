# FunctionRegistryLib
[Git Source](https://github.com/metacontract/mc/blob/7db22f6d7abc05705d21c7601fb406ca49c18557/src/devkit/registry/FunctionRegistry.sol)


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


# FunctionRegistryLib
[Git Source](https://github.com/metacontract/mc/blob/20954f1387efa0bc72b42d3e78a22f9f845eebbd/src/devkit/registry/FunctionRegistry.sol)


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


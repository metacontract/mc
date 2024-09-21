# FunctionRegistryLib
[Git Source](https://github.com/metacontract/mc/blob/c3fc2b414d37afc92bb1cf2e606b4b2bede47403/resources/devkit/api-reference/Flattened.sol)


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


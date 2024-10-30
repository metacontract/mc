# GetFunctions
[Git Source](https://github.com/metacontract/mc/blob/main/src/devkit/Flattened.sol)

< MC Standard Function >

**Notes:**
- v0.1.0

- none


## Functions
### getFunctions


```solidity
function getFunctions() external view returns (Function[] memory);
```

## Structs
### Function
DO NOT USE STORAGE DIRECTLY !!!


```solidity
struct Function {
    bytes4 selector;
    address implementation;
}
```


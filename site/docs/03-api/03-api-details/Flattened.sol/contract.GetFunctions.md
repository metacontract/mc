# GetFunctions
[Git Source](https://github.com/metacontract/mc/blob/20954f1387efa0bc72b42d3e78a22f9f845eebbd/src/devkit/Flattened.sol)

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


# GetFunctions
[Git Source](https://github.com/metacontract/mc/blob/93e4f2d4a013f48ae1db91ed21bff3eb8a27ce1d/src/devkit/Flattened.sol)

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


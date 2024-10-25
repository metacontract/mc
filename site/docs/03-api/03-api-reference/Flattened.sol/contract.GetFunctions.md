# GetFunctions
[Git Source](https://github.com/metacontract/mc/blob/df7a49283d8212c99bebd64a186325e91d34c075/resources/devkit/api-reference/Flattened.sol)

< MC Standard Function >


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


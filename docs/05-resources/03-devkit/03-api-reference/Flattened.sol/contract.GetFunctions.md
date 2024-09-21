# GetFunctions
[Git Source](https://github.com/metacontract/mc/blob/c3fc2b414d37afc92bb1cf2e606b4b2bede47403/resources/devkit/api-reference/Flattened.sol)

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


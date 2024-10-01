# GetFunctions
[Git Source](https://github.com/metacontract/mc/blob/8438d83ed04f942f1b69f22b0cb556723d88a8f9/plugin-functions/std/functions/GetFunctions.sol)

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


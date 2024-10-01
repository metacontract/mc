# Dummy
[Git Source](https://github.com/metacontract/mc/blob/df7a49283d8212c99bebd64a186325e91d34c075/resources/devkit/api-reference/Flattened.sol)


## Functions
### bundleName


```solidity
function bundleName() internal pure returns (string memory);
```

### functionSelector


```solidity
function functionSelector() internal pure returns (bytes4);
```

### functionAddress


```solidity
function functionAddress() internal returns (address);
```

### facadeAddress


```solidity
function facadeAddress() internal returns (address);
```

### setBundle


```solidity
function setBundle(MCDevKit storage mc) internal;
```

### dictionary


```solidity
function dictionary(MCDevKit storage mc) internal returns (address);
```

### dictionary


```solidity
function dictionary(MCDevKit storage mc, MCTest.Function[] memory functions) internal returns (address);
```

### contractAddr


```solidity
function contractAddr() internal returns (address);
```


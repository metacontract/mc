# Dummy
[Git Source](https://github.com/metacontract/mc/blob/b874bc295b567a7e9bd6d6c63dfe84df116a2f3a/src/devkit/test/dummy/Dummy.sol)


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


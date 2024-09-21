# Dummy
[Git Source](https://github.com/metacontract/mc/blob/c3fc2b414d37afc92bb1cf2e606b4b2bede47403/resources/devkit/api-reference/test/dummy/Dummy.sol)


## Functions
### bundleName


```solidity
function bundleName() internal returns (string memory);
```

### functionSelector


```solidity
function functionSelector() internal returns (bytes4);
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


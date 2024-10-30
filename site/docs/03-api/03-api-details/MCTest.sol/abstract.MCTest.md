# MCTest
[Git Source](https://github.com/metacontract/mc/blob/20954f1387efa0bc72b42d3e78a22f9f845eebbd/src/devkit/MCTest.sol)

**Inherits:**
[MCTestBase](../Flattened.sol/abstract.MCTestBase.md), OZProxy


## State Variables
### implementations

```solidity
mapping(bytes4 selector => address) implementations;
```


### target

```solidity
address target = address(this);
```


### functions

```solidity
Function[] internal functions;
```


### dictionary

```solidity
address dictionary;
```


### receiver

```solidity
address receiver = address(new Receive());
```


## Functions
### _use


```solidity
function _use(bytes4 selector_, address impl_) internal;
```

### _setDictionary


```solidity
function _setDictionary(address dictionary_) internal;
```

### _implementation


```solidity
function _implementation() internal view override returns (address implementation);
```

### receive


```solidity
receive() external payable;
```

## Structs
### Function

```solidity
struct Function {
    bytes4 selector;
    address implementation;
}
```


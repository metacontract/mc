# MCTest
[Git Source](https://github.com/metacontract/mc/blob/0cf91165f9ec2cbeeba800a4baf4e81e2df5c3bb/src/devkit/Flattened.sol)

**Inherits:**
[MCTestBase](/src/devkit/Flattened.sol/abstract.MCTestBase.md), [Proxy_0](/src/devkit/Flattened.sol/abstract.Proxy_0.md)


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


## Functions
### constructor


```solidity
constructor();
```

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
function _implementation() internal view override returns (address);
```

## Structs
### Function

```solidity
struct Function {
    bytes4 selector;
    address implementation;
}
```

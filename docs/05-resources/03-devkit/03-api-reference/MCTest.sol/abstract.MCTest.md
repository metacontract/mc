# MCTest
[Git Source](https://github.com/metacontract/mc/blob/d41f04df9ea19494be75c66f344b8104caf03cd2/resources/devkit/api-reference/MCTest.sol)

**Inherits:**
[MCTestBase](/resources/devkit/api-reference/Flattened.sol/abstract.MCTestBase), OZProxy


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
function _implementation() internal view override returns (address implementation);
```

## Structs
### Function

```solidity
struct Function {
    bytes4 selector;
    address implementation;
}
```


# MCTest
[Git Source](https://github.com/metacontract/mc/blob/7db22f6d7abc05705d21c7601fb406ca49c18557/src/devkit/Flattened.sol)

**Inherits:**
[MCTestBase](abstract.MCTestBase.md), [Proxy_0](abstract.Proxy_0.md)


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


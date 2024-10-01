# MCTest
[Git Source](https://github.com/metacontract/mc/blob/8438d83ed04f942f1b69f22b0cb556723d88a8f9/resources/devkit/api-reference/Flattened.sol)

**Inherits:**
[MCTestBase](/resources/devkit/api-reference/Flattened.sol/abstract.MCTestBase), [Proxy_0](/resources/devkit/api-reference/Flattened.sol/abstract.Proxy_0)


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


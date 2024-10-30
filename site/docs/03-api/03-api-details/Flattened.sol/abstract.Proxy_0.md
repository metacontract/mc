# Proxy_0
[Git Source](https://github.com/metacontract/mc/blob/b874bc295b567a7e9bd6d6c63dfe84df116a2f3a/src/devkit/Flattened.sol)

*This abstract contract provides a fallback function that delegates all calls to another contract using the EVM
instruction `delegatecall`. We refer to the second contract as the _implementation_ behind the proxy, and it has to
be specified by overriding the virtual [_implementation](/src/devkit/Flattened.sol/abstract.Proxy_0.md#_implementation) function.
Additionally, delegation to the implementation can be triggered manually through the {_fallback} function, or to a
different contract through the {_delegate} function.
The success and return data of the delegated call will be returned back to the caller of the proxy.*


## Functions
### _delegate

*Delegates the current call to `implementation`.
This function does not return to its internal call site, it will return directly to the external caller.*


```solidity
function _delegate(address implementation) internal virtual;
```

### _implementation

*This is a virtual function that should be overridden so it returns the address to which the fallback
function and [_fallback](/src/devkit/Flattened.sol/abstract.Proxy_0.md#_fallback) should delegate.*


```solidity
function _implementation() internal view virtual returns (address);
```

### _fallback

*Delegates the current call to the address returned by `_implementation()`.
This function does not return to its internal call site, it will return directly to the external caller.*


```solidity
function _fallback() internal virtual;
```

### fallback

*Fallback function that delegates calls to the address returned by `_implementation()`. Will run if no other
function in the contract matches the call data.*


```solidity
fallback() external payable virtual;
```


# SimpleMockProxyLib
[Git Source](https://github.com/metacontract/mc/blob/8438d83ed04f942f1b69f22b0cb556723d88a8f9/resources/devkit/api-reference/test/mocks/SimpleMockProxy.sol)


## State Variables
### STORAGE_LOCATION

```solidity
bytes32 internal constant STORAGE_LOCATION = 0x64a9f0903a8f864d59bc40808555c0090d6ada027fd81884feeb2af9acdbc200;
```


## Functions
### Storage


```solidity
function Storage() internal pure returns (SimpleMockProxyStorage storage ref);
```

### set


```solidity
function set(bytes4 selector, address implementation) internal;
```

### getImplementation


```solidity
function getImplementation(bytes4 selector) internal view returns (address);
```

## Structs
### SimpleMockProxyStorage

```solidity
struct SimpleMockProxyStorage {
    mapping(bytes4 selector => address) implementations;
}
```


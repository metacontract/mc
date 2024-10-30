# SimpleMockProxyLib
[Git Source](https://github.com/metacontract/mc/blob/b874bc295b567a7e9bd6d6c63dfe84df116a2f3a/src/devkit/Flattened.sol)


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
**Note:**
erc7021:mc.mock.proxy


```solidity
struct SimpleMockProxyStorage {
    mapping(bytes4 selector => address) implementations;
}
```


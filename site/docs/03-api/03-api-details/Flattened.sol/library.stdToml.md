# stdToml
[Git Source](https://github.com/metacontract/mc/blob/df7a49283d8212c99bebd64a186325e91d34c075/resources/devkit/api-reference/Flattened.sol)


## State Variables
### vm

```solidity
VmSafe private constant vm = VmSafe(address(uint160(uint256(keccak256("hevm cheat code")))));
```


## Functions
### keyExists


```solidity
function keyExists(string memory toml, string memory key) internal view returns (bool);
```

### parseRaw


```solidity
function parseRaw(string memory toml, string memory key) internal pure returns (bytes memory);
```

### readUint


```solidity
function readUint(string memory toml, string memory key) internal pure returns (uint256);
```

### readUintArray


```solidity
function readUintArray(string memory toml, string memory key) internal pure returns (uint256[] memory);
```

### readInt


```solidity
function readInt(string memory toml, string memory key) internal pure returns (int256);
```

### readIntArray


```solidity
function readIntArray(string memory toml, string memory key) internal pure returns (int256[] memory);
```

### readBytes32


```solidity
function readBytes32(string memory toml, string memory key) internal pure returns (bytes32);
```

### readBytes32Array


```solidity
function readBytes32Array(string memory toml, string memory key) internal pure returns (bytes32[] memory);
```

### readString


```solidity
function readString(string memory toml, string memory key) internal pure returns (string memory);
```

### readStringArray


```solidity
function readStringArray(string memory toml, string memory key) internal pure returns (string[] memory);
```

### readAddress


```solidity
function readAddress(string memory toml, string memory key) internal pure returns (address);
```

### readAddressArray


```solidity
function readAddressArray(string memory toml, string memory key) internal pure returns (address[] memory);
```

### readBool


```solidity
function readBool(string memory toml, string memory key) internal pure returns (bool);
```

### readBoolArray


```solidity
function readBoolArray(string memory toml, string memory key) internal pure returns (bool[] memory);
```

### readBytes


```solidity
function readBytes(string memory toml, string memory key) internal pure returns (bytes memory);
```

### readBytesArray


```solidity
function readBytesArray(string memory toml, string memory key) internal pure returns (bytes[] memory);
```

### readUintOr


```solidity
function readUintOr(string memory toml, string memory key, uint256 defaultValue) internal view returns (uint256);
```

### readUintArrayOr


```solidity
function readUintArrayOr(string memory toml, string memory key, uint256[] memory defaultValue)
    internal
    view
    returns (uint256[] memory);
```

### readIntOr


```solidity
function readIntOr(string memory toml, string memory key, int256 defaultValue) internal view returns (int256);
```

### readIntArrayOr


```solidity
function readIntArrayOr(string memory toml, string memory key, int256[] memory defaultValue)
    internal
    view
    returns (int256[] memory);
```

### readBytes32Or


```solidity
function readBytes32Or(string memory toml, string memory key, bytes32 defaultValue) internal view returns (bytes32);
```

### readBytes32ArrayOr


```solidity
function readBytes32ArrayOr(string memory toml, string memory key, bytes32[] memory defaultValue)
    internal
    view
    returns (bytes32[] memory);
```

### readStringOr


```solidity
function readStringOr(string memory toml, string memory key, string memory defaultValue)
    internal
    view
    returns (string memory);
```

### readStringArrayOr


```solidity
function readStringArrayOr(string memory toml, string memory key, string[] memory defaultValue)
    internal
    view
    returns (string[] memory);
```

### readAddressOr


```solidity
function readAddressOr(string memory toml, string memory key, address defaultValue) internal view returns (address);
```

### readAddressArrayOr


```solidity
function readAddressArrayOr(string memory toml, string memory key, address[] memory defaultValue)
    internal
    view
    returns (address[] memory);
```

### readBoolOr


```solidity
function readBoolOr(string memory toml, string memory key, bool defaultValue) internal view returns (bool);
```

### readBoolArrayOr


```solidity
function readBoolArrayOr(string memory toml, string memory key, bool[] memory defaultValue)
    internal
    view
    returns (bool[] memory);
```

### readBytesOr


```solidity
function readBytesOr(string memory toml, string memory key, bytes memory defaultValue)
    internal
    view
    returns (bytes memory);
```

### readBytesArrayOr


```solidity
function readBytesArrayOr(string memory toml, string memory key, bytes[] memory defaultValue)
    internal
    view
    returns (bytes[] memory);
```

### serialize


```solidity
function serialize(string memory jsonKey, string memory rootObject) internal returns (string memory);
```

### serialize


```solidity
function serialize(string memory jsonKey, string memory key, bool value) internal returns (string memory);
```

### serialize


```solidity
function serialize(string memory jsonKey, string memory key, bool[] memory value) internal returns (string memory);
```

### serialize


```solidity
function serialize(string memory jsonKey, string memory key, uint256 value) internal returns (string memory);
```

### serialize


```solidity
function serialize(string memory jsonKey, string memory key, uint256[] memory value) internal returns (string memory);
```

### serialize


```solidity
function serialize(string memory jsonKey, string memory key, int256 value) internal returns (string memory);
```

### serialize


```solidity
function serialize(string memory jsonKey, string memory key, int256[] memory value) internal returns (string memory);
```

### serialize


```solidity
function serialize(string memory jsonKey, string memory key, address value) internal returns (string memory);
```

### serialize


```solidity
function serialize(string memory jsonKey, string memory key, address[] memory value) internal returns (string memory);
```

### serialize


```solidity
function serialize(string memory jsonKey, string memory key, bytes32 value) internal returns (string memory);
```

### serialize


```solidity
function serialize(string memory jsonKey, string memory key, bytes32[] memory value) internal returns (string memory);
```

### serialize


```solidity
function serialize(string memory jsonKey, string memory key, bytes memory value) internal returns (string memory);
```

### serialize


```solidity
function serialize(string memory jsonKey, string memory key, bytes[] memory value) internal returns (string memory);
```

### serialize


```solidity
function serialize(string memory jsonKey, string memory key, string memory value) internal returns (string memory);
```

### serialize


```solidity
function serialize(string memory jsonKey, string memory key, string[] memory value) internal returns (string memory);
```

### write


```solidity
function write(string memory jsonKey, string memory path) internal;
```

### write


```solidity
function write(string memory jsonKey, string memory path, string memory valueKey) internal;
```


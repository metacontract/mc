# stdJson
[Git Source](https://github.com/metacontract/mc/blob/c3fc2b414d37afc92bb1cf2e606b4b2bede47403/resources/devkit/api-reference/Flattened.sol)


## State Variables
### vm

```solidity
VmSafe private constant vm = VmSafe(address(uint160(uint256(keccak256("hevm cheat code")))));
```


## Functions
### keyExists


```solidity
function keyExists(string memory json, string memory key) internal view returns (bool);
```

### parseRaw


```solidity
function parseRaw(string memory json, string memory key) internal pure returns (bytes memory);
```

### readUint


```solidity
function readUint(string memory json, string memory key) internal pure returns (uint256);
```

### readUintArray


```solidity
function readUintArray(string memory json, string memory key) internal pure returns (uint256[] memory);
```

### readInt


```solidity
function readInt(string memory json, string memory key) internal pure returns (int256);
```

### readIntArray


```solidity
function readIntArray(string memory json, string memory key) internal pure returns (int256[] memory);
```

### readBytes32


```solidity
function readBytes32(string memory json, string memory key) internal pure returns (bytes32);
```

### readBytes32Array


```solidity
function readBytes32Array(string memory json, string memory key) internal pure returns (bytes32[] memory);
```

### readString


```solidity
function readString(string memory json, string memory key) internal pure returns (string memory);
```

### readStringArray


```solidity
function readStringArray(string memory json, string memory key) internal pure returns (string[] memory);
```

### readAddress


```solidity
function readAddress(string memory json, string memory key) internal pure returns (address);
```

### readAddressArray


```solidity
function readAddressArray(string memory json, string memory key) internal pure returns (address[] memory);
```

### readBool


```solidity
function readBool(string memory json, string memory key) internal pure returns (bool);
```

### readBoolArray


```solidity
function readBoolArray(string memory json, string memory key) internal pure returns (bool[] memory);
```

### readBytes


```solidity
function readBytes(string memory json, string memory key) internal pure returns (bytes memory);
```

### readBytesArray


```solidity
function readBytesArray(string memory json, string memory key) internal pure returns (bytes[] memory);
```

### readUintOr


```solidity
function readUintOr(string memory json, string memory key, uint256 defaultValue) internal view returns (uint256);
```

### readUintArrayOr


```solidity
function readUintArrayOr(string memory json, string memory key, uint256[] memory defaultValue)
    internal
    view
    returns (uint256[] memory);
```

### readIntOr


```solidity
function readIntOr(string memory json, string memory key, int256 defaultValue) internal view returns (int256);
```

### readIntArrayOr


```solidity
function readIntArrayOr(string memory json, string memory key, int256[] memory defaultValue)
    internal
    view
    returns (int256[] memory);
```

### readBytes32Or


```solidity
function readBytes32Or(string memory json, string memory key, bytes32 defaultValue) internal view returns (bytes32);
```

### readBytes32ArrayOr


```solidity
function readBytes32ArrayOr(string memory json, string memory key, bytes32[] memory defaultValue)
    internal
    view
    returns (bytes32[] memory);
```

### readStringOr


```solidity
function readStringOr(string memory json, string memory key, string memory defaultValue)
    internal
    view
    returns (string memory);
```

### readStringArrayOr


```solidity
function readStringArrayOr(string memory json, string memory key, string[] memory defaultValue)
    internal
    view
    returns (string[] memory);
```

### readAddressOr


```solidity
function readAddressOr(string memory json, string memory key, address defaultValue) internal view returns (address);
```

### readAddressArrayOr


```solidity
function readAddressArrayOr(string memory json, string memory key, address[] memory defaultValue)
    internal
    view
    returns (address[] memory);
```

### readBoolOr


```solidity
function readBoolOr(string memory json, string memory key, bool defaultValue) internal view returns (bool);
```

### readBoolArrayOr


```solidity
function readBoolArrayOr(string memory json, string memory key, bool[] memory defaultValue)
    internal
    view
    returns (bool[] memory);
```

### readBytesOr


```solidity
function readBytesOr(string memory json, string memory key, bytes memory defaultValue)
    internal
    view
    returns (bytes memory);
```

### readBytesArrayOr


```solidity
function readBytesArrayOr(string memory json, string memory key, bytes[] memory defaultValue)
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


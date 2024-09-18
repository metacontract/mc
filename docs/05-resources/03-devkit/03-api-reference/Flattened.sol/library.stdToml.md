# stdToml
[Git Source](https://github.com/metacontract/mc/blob/0cf91165f9ec2cbeeba800a4baf4e81e2df5c3bb/src/devkit/Flattened.sol)


## State Variables
### vm

```solidity
VmSafe private constant vm = VmSafe(address(uint160(uint256(keccak256("hevm cheat code")))));
```


## Functions
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


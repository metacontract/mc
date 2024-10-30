# StorageSlot
[Git Source](https://github.com/metacontract/mc/blob/7db22f6d7abc05705d21c7601fb406ca49c18557/src/devkit/Flattened.sol)

*Library for reading and writing primitive types to specific storage slots.
Storage slots are often used to avoid storage conflict when dealing with upgradeable contracts.
This library helps with reading and writing to such slots without the need for inline assembly.
The functions in this library return Slot structs that contain a `value` member that can be used to read or write.
Example usage to set ERC1967 implementation slot:
```solidity
contract ERC1967 {
bytes32 internal constant _IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;
function _getImplementation() internal view returns (address) {
return StorageSlot.getAddressSlot(_IMPLEMENTATION_SLOT).value;
}
function _setImplementation(address newImplementation) internal {
require(newImplementation.code.length > 0);
StorageSlot.getAddressSlot(_IMPLEMENTATION_SLOT).value = newImplementation;
}
}
```*


## Functions
### getAddressSlot

*Returns an `AddressSlot` with member `value` located at `slot`.*


```solidity
function getAddressSlot(bytes32 slot) internal pure returns (AddressSlot storage r);
```

### getBooleanSlot

*Returns an `BooleanSlot` with member `value` located at `slot`.*


```solidity
function getBooleanSlot(bytes32 slot) internal pure returns (BooleanSlot storage r);
```

### getBytes32Slot

*Returns an `Bytes32Slot` with member `value` located at `slot`.*


```solidity
function getBytes32Slot(bytes32 slot) internal pure returns (Bytes32Slot storage r);
```

### getUint256Slot

*Returns an `Uint256Slot` with member `value` located at `slot`.*


```solidity
function getUint256Slot(bytes32 slot) internal pure returns (Uint256Slot storage r);
```

### getStringSlot

*Returns an `StringSlot` with member `value` located at `slot`.*


```solidity
function getStringSlot(bytes32 slot) internal pure returns (StringSlot storage r);
```

### getStringSlot

*Returns an `StringSlot` representation of the string storage pointer `store`.*


```solidity
function getStringSlot(string storage store) internal pure returns (StringSlot storage r);
```

### getBytesSlot

*Returns an `BytesSlot` with member `value` located at `slot`.*


```solidity
function getBytesSlot(bytes32 slot) internal pure returns (BytesSlot storage r);
```

### getBytesSlot

*Returns an `BytesSlot` representation of the bytes storage pointer `store`.*


```solidity
function getBytesSlot(bytes storage store) internal pure returns (BytesSlot storage r);
```

## Structs
### AddressSlot

```solidity
struct AddressSlot {
    address value;
}
```

### BooleanSlot

```solidity
struct BooleanSlot {
    bool value;
}
```

### Bytes32Slot

```solidity
struct Bytes32Slot {
    bytes32 value;
}
```

### Uint256Slot

```solidity
struct Uint256Slot {
    uint256 value;
}
```

### StringSlot

```solidity
struct StringSlot {
    string value;
}
```

### BytesSlot

```solidity
struct BytesSlot {
    bytes value;
}
```


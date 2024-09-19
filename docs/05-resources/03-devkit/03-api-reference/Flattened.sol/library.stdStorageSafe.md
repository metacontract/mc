# stdStorageSafe
[Git Source](https://github.com/metacontract/mc/blob/20ed737f21a46d89afffe1322a75b1ecfcacff9a/src/devkit/Flattened.sol)


## State Variables
### vm

```solidity
Vm private constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))));
```


### UINT256_MAX

```solidity
uint256 constant UINT256_MAX = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
```


## Functions
### sigs


```solidity
function sigs(string memory sigStr) internal pure returns (bytes4);
```

### getCallParams


```solidity
function getCallParams(StdStorage storage self) internal view returns (bytes memory);
```

### callTarget


```solidity
function callTarget(StdStorage storage self) internal view returns (bool, bytes32);
```

### checkSlotMutatesCall


```solidity
function checkSlotMutatesCall(StdStorage storage self, bytes32 slot) internal returns (bool);
```

### findOffset


```solidity
function findOffset(StdStorage storage self, bytes32 slot, bool left) internal returns (bool, uint256);
```

### findOffsets


```solidity
function findOffsets(StdStorage storage self, bytes32 slot) internal returns (bool, uint256, uint256);
```

### find


```solidity
function find(StdStorage storage self) internal returns (FindData storage);
```

### find

find an arbitrary storage slot given a function sig, input data, address of the contract and a value to check against


```solidity
function find(StdStorage storage self, bool _clear) internal returns (FindData storage);
```

### target


```solidity
function target(StdStorage storage self, address _target) internal returns (StdStorage storage);
```

### sig


```solidity
function sig(StdStorage storage self, bytes4 _sig) internal returns (StdStorage storage);
```

### sig


```solidity
function sig(StdStorage storage self, string memory _sig) internal returns (StdStorage storage);
```

### with_calldata


```solidity
function with_calldata(StdStorage storage self, bytes memory _calldata) internal returns (StdStorage storage);
```

### with_key


```solidity
function with_key(StdStorage storage self, address who) internal returns (StdStorage storage);
```

### with_key


```solidity
function with_key(StdStorage storage self, uint256 amt) internal returns (StdStorage storage);
```

### with_key


```solidity
function with_key(StdStorage storage self, bytes32 key) internal returns (StdStorage storage);
```

### enable_packed_slots


```solidity
function enable_packed_slots(StdStorage storage self) internal returns (StdStorage storage);
```

### depth


```solidity
function depth(StdStorage storage self, uint256 _depth) internal returns (StdStorage storage);
```

### read


```solidity
function read(StdStorage storage self) private returns (bytes memory);
```

### read_bytes32


```solidity
function read_bytes32(StdStorage storage self) internal returns (bytes32);
```

### read_bool


```solidity
function read_bool(StdStorage storage self) internal returns (bool);
```

### read_address


```solidity
function read_address(StdStorage storage self) internal returns (address);
```

### read_uint


```solidity
function read_uint(StdStorage storage self) internal returns (uint256);
```

### read_int


```solidity
function read_int(StdStorage storage self) internal returns (int256);
```

### parent


```solidity
function parent(StdStorage storage self) internal returns (uint256, bytes32);
```

### root


```solidity
function root(StdStorage storage self) internal returns (uint256);
```

### bytesToBytes32


```solidity
function bytesToBytes32(bytes memory b, uint256 offset) private pure returns (bytes32);
```

### flatten


```solidity
function flatten(bytes32[] memory b) private pure returns (bytes memory);
```

### clear


```solidity
function clear(StdStorage storage self) internal;
```

### getMaskByOffsets


```solidity
function getMaskByOffsets(uint256 offsetLeft, uint256 offsetRight) internal pure returns (uint256 mask);
```

### getUpdatedSlotValue


```solidity
function getUpdatedSlotValue(bytes32 curValue, uint256 varValue, uint256 offsetLeft, uint256 offsetRight)
    internal
    pure
    returns (bytes32 newValue);
```

## Events
### SlotFound

```solidity
event SlotFound(address who, bytes4 fsig, bytes32 keysHash, uint256 slot);
```

### WARNING_UninitedSlot

```solidity
event WARNING_UninitedSlot(address who, uint256 slot);
```


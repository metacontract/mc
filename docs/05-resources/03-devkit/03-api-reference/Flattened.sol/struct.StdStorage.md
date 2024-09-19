# StdStorage
[Git Source](https://github.com/metacontract/mc/blob/20ed737f21a46d89afffe1322a75b1ecfcacff9a/src/devkit/Flattened.sol)


```solidity
struct StdStorage {
    mapping(address => mapping(bytes4 => mapping(bytes32 => FindData))) finds;
    bytes32[] _keys;
    bytes4 _sig;
    uint256 _depth;
    address _target;
    bytes32 _set;
    bool _enable_packed_slots;
    bytes _calldata;
}
```


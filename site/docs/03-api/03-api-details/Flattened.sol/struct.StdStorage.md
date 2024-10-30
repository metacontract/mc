# StdStorage
[Git Source](https://github.com/metacontract/mc/blob/7db22f6d7abc05705d21c7601fb406ca49c18557/src/devkit/Flattened.sol)


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


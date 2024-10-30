# StdAssertions
[Git Source](https://github.com/metacontract/mc/blob/20954f1387efa0bc72b42d3e78a22f9f845eebbd/src/devkit/Flattened.sol)


## State Variables
### vm

```solidity
Vm private constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))));
```


### _failed

```solidity
bool private _failed;
```


## Functions
### failed


```solidity
function failed() public view returns (bool);
```

### fail


```solidity
function fail() internal virtual;
```

### assertTrue


```solidity
function assertTrue(bool data) internal pure virtual;
```

### assertTrue


```solidity
function assertTrue(bool data, string memory err) internal pure virtual;
```

### assertFalse


```solidity
function assertFalse(bool data) internal pure virtual;
```

### assertFalse


```solidity
function assertFalse(bool data, string memory err) internal pure virtual;
```

### assertEq


```solidity
function assertEq(bool left, bool right) internal pure virtual;
```

### assertEq


```solidity
function assertEq(bool left, bool right, string memory err) internal pure virtual;
```

### assertEq


```solidity
function assertEq(uint256 left, uint256 right) internal pure virtual;
```

### assertEq


```solidity
function assertEq(uint256 left, uint256 right, string memory err) internal pure virtual;
```

### assertEqDecimal


```solidity
function assertEqDecimal(uint256 left, uint256 right, uint256 decimals) internal pure virtual;
```

### assertEqDecimal


```solidity
function assertEqDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) internal pure virtual;
```

### assertEq


```solidity
function assertEq(int256 left, int256 right) internal pure virtual;
```

### assertEq


```solidity
function assertEq(int256 left, int256 right, string memory err) internal pure virtual;
```

### assertEqDecimal


```solidity
function assertEqDecimal(int256 left, int256 right, uint256 decimals) internal pure virtual;
```

### assertEqDecimal


```solidity
function assertEqDecimal(int256 left, int256 right, uint256 decimals, string memory err) internal pure virtual;
```

### assertEq


```solidity
function assertEq(address left, address right) internal pure virtual;
```

### assertEq


```solidity
function assertEq(address left, address right, string memory err) internal pure virtual;
```

### assertEq


```solidity
function assertEq(bytes32 left, bytes32 right) internal pure virtual;
```

### assertEq


```solidity
function assertEq(bytes32 left, bytes32 right, string memory err) internal pure virtual;
```

### assertEq32


```solidity
function assertEq32(bytes32 left, bytes32 right) internal pure virtual;
```

### assertEq32


```solidity
function assertEq32(bytes32 left, bytes32 right, string memory err) internal pure virtual;
```

### assertEq


```solidity
function assertEq(string memory left, string memory right) internal pure virtual;
```

### assertEq


```solidity
function assertEq(string memory left, string memory right, string memory err) internal pure virtual;
```

### assertEq


```solidity
function assertEq(bytes memory left, bytes memory right) internal pure virtual;
```

### assertEq


```solidity
function assertEq(bytes memory left, bytes memory right, string memory err) internal pure virtual;
```

### assertEq


```solidity
function assertEq(bool[] memory left, bool[] memory right) internal pure virtual;
```

### assertEq


```solidity
function assertEq(bool[] memory left, bool[] memory right, string memory err) internal pure virtual;
```

### assertEq


```solidity
function assertEq(uint256[] memory left, uint256[] memory right) internal pure virtual;
```

### assertEq


```solidity
function assertEq(uint256[] memory left, uint256[] memory right, string memory err) internal pure virtual;
```

### assertEq


```solidity
function assertEq(int256[] memory left, int256[] memory right) internal pure virtual;
```

### assertEq


```solidity
function assertEq(int256[] memory left, int256[] memory right, string memory err) internal pure virtual;
```

### assertEq


```solidity
function assertEq(address[] memory left, address[] memory right) internal pure virtual;
```

### assertEq


```solidity
function assertEq(address[] memory left, address[] memory right, string memory err) internal pure virtual;
```

### assertEq


```solidity
function assertEq(bytes32[] memory left, bytes32[] memory right) internal pure virtual;
```

### assertEq


```solidity
function assertEq(bytes32[] memory left, bytes32[] memory right, string memory err) internal pure virtual;
```

### assertEq


```solidity
function assertEq(string[] memory left, string[] memory right) internal pure virtual;
```

### assertEq


```solidity
function assertEq(string[] memory left, string[] memory right, string memory err) internal pure virtual;
```

### assertEq


```solidity
function assertEq(bytes[] memory left, bytes[] memory right) internal pure virtual;
```

### assertEq


```solidity
function assertEq(bytes[] memory left, bytes[] memory right, string memory err) internal pure virtual;
```

### assertEqUint


```solidity
function assertEqUint(uint256 left, uint256 right) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(bool left, bool right) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(bool left, bool right, string memory err) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(uint256 left, uint256 right) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(uint256 left, uint256 right, string memory err) internal pure virtual;
```

### assertNotEqDecimal


```solidity
function assertNotEqDecimal(uint256 left, uint256 right, uint256 decimals) internal pure virtual;
```

### assertNotEqDecimal


```solidity
function assertNotEqDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(int256 left, int256 right) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(int256 left, int256 right, string memory err) internal pure virtual;
```

### assertNotEqDecimal


```solidity
function assertNotEqDecimal(int256 left, int256 right, uint256 decimals) internal pure virtual;
```

### assertNotEqDecimal


```solidity
function assertNotEqDecimal(int256 left, int256 right, uint256 decimals, string memory err) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(address left, address right) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(address left, address right, string memory err) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(bytes32 left, bytes32 right) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(bytes32 left, bytes32 right, string memory err) internal pure virtual;
```

### assertNotEq32


```solidity
function assertNotEq32(bytes32 left, bytes32 right) internal pure virtual;
```

### assertNotEq32


```solidity
function assertNotEq32(bytes32 left, bytes32 right, string memory err) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(string memory left, string memory right) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(string memory left, string memory right, string memory err) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(bytes memory left, bytes memory right) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(bytes memory left, bytes memory right, string memory err) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(bool[] memory left, bool[] memory right) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(bool[] memory left, bool[] memory right, string memory err) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(uint256[] memory left, uint256[] memory right) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(uint256[] memory left, uint256[] memory right, string memory err) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(int256[] memory left, int256[] memory right) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(int256[] memory left, int256[] memory right, string memory err) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(address[] memory left, address[] memory right) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(address[] memory left, address[] memory right, string memory err) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(bytes32[] memory left, bytes32[] memory right) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(bytes32[] memory left, bytes32[] memory right, string memory err) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(string[] memory left, string[] memory right) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(string[] memory left, string[] memory right, string memory err) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(bytes[] memory left, bytes[] memory right) internal pure virtual;
```

### assertNotEq


```solidity
function assertNotEq(bytes[] memory left, bytes[] memory right, string memory err) internal pure virtual;
```

### assertLt


```solidity
function assertLt(uint256 left, uint256 right) internal pure virtual;
```

### assertLt


```solidity
function assertLt(uint256 left, uint256 right, string memory err) internal pure virtual;
```

### assertLtDecimal


```solidity
function assertLtDecimal(uint256 left, uint256 right, uint256 decimals) internal pure virtual;
```

### assertLtDecimal


```solidity
function assertLtDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) internal pure virtual;
```

### assertLt


```solidity
function assertLt(int256 left, int256 right) internal pure virtual;
```

### assertLt


```solidity
function assertLt(int256 left, int256 right, string memory err) internal pure virtual;
```

### assertLtDecimal


```solidity
function assertLtDecimal(int256 left, int256 right, uint256 decimals) internal pure virtual;
```

### assertLtDecimal


```solidity
function assertLtDecimal(int256 left, int256 right, uint256 decimals, string memory err) internal pure virtual;
```

### assertGt


```solidity
function assertGt(uint256 left, uint256 right) internal pure virtual;
```

### assertGt


```solidity
function assertGt(uint256 left, uint256 right, string memory err) internal pure virtual;
```

### assertGtDecimal


```solidity
function assertGtDecimal(uint256 left, uint256 right, uint256 decimals) internal pure virtual;
```

### assertGtDecimal


```solidity
function assertGtDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) internal pure virtual;
```

### assertGt


```solidity
function assertGt(int256 left, int256 right) internal pure virtual;
```

### assertGt


```solidity
function assertGt(int256 left, int256 right, string memory err) internal pure virtual;
```

### assertGtDecimal


```solidity
function assertGtDecimal(int256 left, int256 right, uint256 decimals) internal pure virtual;
```

### assertGtDecimal


```solidity
function assertGtDecimal(int256 left, int256 right, uint256 decimals, string memory err) internal pure virtual;
```

### assertLe


```solidity
function assertLe(uint256 left, uint256 right) internal pure virtual;
```

### assertLe


```solidity
function assertLe(uint256 left, uint256 right, string memory err) internal pure virtual;
```

### assertLeDecimal


```solidity
function assertLeDecimal(uint256 left, uint256 right, uint256 decimals) internal pure virtual;
```

### assertLeDecimal


```solidity
function assertLeDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) internal pure virtual;
```

### assertLe


```solidity
function assertLe(int256 left, int256 right) internal pure virtual;
```

### assertLe


```solidity
function assertLe(int256 left, int256 right, string memory err) internal pure virtual;
```

### assertLeDecimal


```solidity
function assertLeDecimal(int256 left, int256 right, uint256 decimals) internal pure virtual;
```

### assertLeDecimal


```solidity
function assertLeDecimal(int256 left, int256 right, uint256 decimals, string memory err) internal pure virtual;
```

### assertGe


```solidity
function assertGe(uint256 left, uint256 right) internal pure virtual;
```

### assertGe


```solidity
function assertGe(uint256 left, uint256 right, string memory err) internal pure virtual;
```

### assertGeDecimal


```solidity
function assertGeDecimal(uint256 left, uint256 right, uint256 decimals) internal pure virtual;
```

### assertGeDecimal


```solidity
function assertGeDecimal(uint256 left, uint256 right, uint256 decimals, string memory err) internal pure virtual;
```

### assertGe


```solidity
function assertGe(int256 left, int256 right) internal pure virtual;
```

### assertGe


```solidity
function assertGe(int256 left, int256 right, string memory err) internal pure virtual;
```

### assertGeDecimal


```solidity
function assertGeDecimal(int256 left, int256 right, uint256 decimals) internal pure virtual;
```

### assertGeDecimal


```solidity
function assertGeDecimal(int256 left, int256 right, uint256 decimals, string memory err) internal pure virtual;
```

### assertApproxEqAbs


```solidity
function assertApproxEqAbs(uint256 left, uint256 right, uint256 maxDelta) internal pure virtual;
```

### assertApproxEqAbs


```solidity
function assertApproxEqAbs(uint256 left, uint256 right, uint256 maxDelta, string memory err) internal pure virtual;
```

### assertApproxEqAbsDecimal


```solidity
function assertApproxEqAbsDecimal(uint256 left, uint256 right, uint256 maxDelta, uint256 decimals)
    internal
    pure
    virtual;
```

### assertApproxEqAbsDecimal


```solidity
function assertApproxEqAbsDecimal(uint256 left, uint256 right, uint256 maxDelta, uint256 decimals, string memory err)
    internal
    pure
    virtual;
```

### assertApproxEqAbs


```solidity
function assertApproxEqAbs(int256 left, int256 right, uint256 maxDelta) internal pure virtual;
```

### assertApproxEqAbs


```solidity
function assertApproxEqAbs(int256 left, int256 right, uint256 maxDelta, string memory err) internal pure virtual;
```

### assertApproxEqAbsDecimal


```solidity
function assertApproxEqAbsDecimal(int256 left, int256 right, uint256 maxDelta, uint256 decimals)
    internal
    pure
    virtual;
```

### assertApproxEqAbsDecimal


```solidity
function assertApproxEqAbsDecimal(int256 left, int256 right, uint256 maxDelta, uint256 decimals, string memory err)
    internal
    pure
    virtual;
```

### assertApproxEqRel


```solidity
function assertApproxEqRel(uint256 left, uint256 right, uint256 maxPercentDelta) internal pure virtual;
```

### assertApproxEqRel


```solidity
function assertApproxEqRel(uint256 left, uint256 right, uint256 maxPercentDelta, string memory err)
    internal
    pure
    virtual;
```

### assertApproxEqRelDecimal


```solidity
function assertApproxEqRelDecimal(uint256 left, uint256 right, uint256 maxPercentDelta, uint256 decimals)
    internal
    pure
    virtual;
```

### assertApproxEqRelDecimal


```solidity
function assertApproxEqRelDecimal(
    uint256 left,
    uint256 right,
    uint256 maxPercentDelta,
    uint256 decimals,
    string memory err
) internal pure virtual;
```

### assertApproxEqRel


```solidity
function assertApproxEqRel(int256 left, int256 right, uint256 maxPercentDelta) internal pure virtual;
```

### assertApproxEqRel


```solidity
function assertApproxEqRel(int256 left, int256 right, uint256 maxPercentDelta, string memory err)
    internal
    pure
    virtual;
```

### assertApproxEqRelDecimal


```solidity
function assertApproxEqRelDecimal(int256 left, int256 right, uint256 maxPercentDelta, uint256 decimals)
    internal
    pure
    virtual;
```

### assertApproxEqRelDecimal


```solidity
function assertApproxEqRelDecimal(
    int256 left,
    int256 right,
    uint256 maxPercentDelta,
    uint256 decimals,
    string memory err
) internal pure virtual;
```

### checkEq0


```solidity
function checkEq0(bytes memory left, bytes memory right) internal pure returns (bool);
```

### assertEq0


```solidity
function assertEq0(bytes memory left, bytes memory right) internal pure virtual;
```

### assertEq0


```solidity
function assertEq0(bytes memory left, bytes memory right, string memory err) internal pure virtual;
```

### assertNotEq0


```solidity
function assertNotEq0(bytes memory left, bytes memory right) internal pure virtual;
```

### assertNotEq0


```solidity
function assertNotEq0(bytes memory left, bytes memory right, string memory err) internal pure virtual;
```

### assertEqCall


```solidity
function assertEqCall(address target, bytes memory callDataA, bytes memory callDataB) internal virtual;
```

### assertEqCall


```solidity
function assertEqCall(address targetA, bytes memory callDataA, address targetB, bytes memory callDataB)
    internal
    virtual;
```

### assertEqCall


```solidity
function assertEqCall(address target, bytes memory callDataA, bytes memory callDataB, bool strictRevertData)
    internal
    virtual;
```

### assertEqCall


```solidity
function assertEqCall(
    address targetA,
    bytes memory callDataA,
    address targetB,
    bytes memory callDataB,
    bool strictRevertData
) internal virtual;
```

## Events
### log

```solidity
event log(string);
```

### logs

```solidity
event logs(bytes);
```

### log_address

```solidity
event log_address(address);
```

### log_bytes32

```solidity
event log_bytes32(bytes32);
```

### log_int

```solidity
event log_int(int256);
```

### log_uint

```solidity
event log_uint(uint256);
```

### log_bytes

```solidity
event log_bytes(bytes);
```

### log_string

```solidity
event log_string(string);
```

### log_named_address

```solidity
event log_named_address(string key, address val);
```

### log_named_bytes32

```solidity
event log_named_bytes32(string key, bytes32 val);
```

### log_named_decimal_int

```solidity
event log_named_decimal_int(string key, int256 val, uint256 decimals);
```

### log_named_decimal_uint

```solidity
event log_named_decimal_uint(string key, uint256 val, uint256 decimals);
```

### log_named_int

```solidity
event log_named_int(string key, int256 val);
```

### log_named_uint

```solidity
event log_named_uint(string key, uint256 val);
```

### log_named_bytes

```solidity
event log_named_bytes(string key, bytes val);
```

### log_named_string

```solidity
event log_named_string(string key, string val);
```

### log_array

```solidity
event log_array(uint256[] val);
```

### log_array

```solidity
event log_array(int256[] val);
```

### log_array

```solidity
event log_array(address[] val);
```

### log_named_array

```solidity
event log_named_array(string key, uint256[] val);
```

### log_named_array

```solidity
event log_named_array(string key, int256[] val);
```

### log_named_array

```solidity
event log_named_array(string key, address[] val);
```


# Formatter
[Git Source](https://github.com/metacontract/mc/blob/20954f1387efa0bc72b42d3e78a22f9f845eebbd/src/devkit/types/Formatter.sol)

==================
🗒️ Formatter
====================


## Functions
### toString

==================
🧩 Function
====================


```solidity
function toString(Function memory func) internal pure returns (string memory message);
```

### toString

===============
🗂️ Bundle
=================


```solidity
function toString(Bundle storage bundle) internal view returns (string memory message);
```

### toLocation

=================
⛓️ Process
===================


```solidity
function toLocation(Process memory process) internal pure returns (string memory);
```

### formatPid


```solidity
function formatPid(uint256 pid) internal pure returns (string memory);
```

### toStart


```solidity
function toStart(Process memory process, uint256 pid) internal pure returns (string memory);
```

### toFinish


```solidity
function toFinish(Process memory process, uint256 pid) internal pure returns (string memory);
```

### toMessage


```solidity
function toMessage(string memory head, string memory body) internal pure returns (string memory);
```

### append

===================
🧱 Primitives
=====================
📝 String


```solidity
function append(string memory str, string memory addition) internal pure returns (string memory);
```

### append


```solidity
function append(string memory str, address addr) internal pure returns (string memory);
```

### append


```solidity
function append(string memory str, bytes4 selector) internal pure returns (string memory);
```

### append


```solidity
function append(string memory str, uint256 num) internal pure returns (string memory);
```

### br


```solidity
function br(string memory str) internal pure returns (string memory);
```

### sp


```solidity
function sp(string memory str) internal pure returns (string memory);
```

### indent


```solidity
function indent(string memory str) internal pure returns (string memory);
```

### comma


```solidity
function comma(string memory str) internal pure returns (string memory);
```

### comma


```solidity
function comma(string memory str, string memory addition) internal pure returns (string memory);
```

### comma


```solidity
function comma(string memory str, bytes4 b4) internal pure returns (string memory);
```

### comma


```solidity
function comma(string memory str, address addr) internal pure returns (string memory);
```

### dot


```solidity
function dot(string memory str) internal pure returns (string memory);
```

### addParens


```solidity
function addParens(string memory str) internal pure returns (string memory);
```

### parens


```solidity
function parens(string memory str) internal pure returns (string memory);
```

### brackL


```solidity
function brackL(string memory str) internal pure returns (string memory);
```

### brackR


```solidity
function brackR(string memory str) internal pure returns (string memory);
```

### toSequential


```solidity
function toSequential(string memory str, uint256 i) internal pure returns (string memory);
```

### toString


```solidity
function toString(address addr) internal pure returns (string memory);
```

### toBytes32


```solidity
function toBytes32(address addr) internal pure returns (bytes32);
```

### toString


```solidity
function toString(bytes4 selector) internal pure returns (string memory);
```

### toBytes


```solidity
function toBytes(string memory str) internal pure returns (bytes memory);
```

### substring


```solidity
function substring(string memory str, uint256 n) internal pure returns (string memory);
```


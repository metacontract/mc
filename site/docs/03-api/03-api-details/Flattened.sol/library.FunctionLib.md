# FunctionLib
[Git Source](https://github.com/metacontract/mc/blob/20954f1387efa0bc72b42d3e78a22f9f845eebbd/src/devkit/Flattened.sol)


## Functions
### assignName

--------------------
📛 Assign Name
----------------------


```solidity
function assignName(Function storage func, string memory name) internal returns (Function storage);
```

### assignSelector

------------------------
🎯 Assign Selector
--------------------------


```solidity
function assignSelector(Function storage func, bytes4 selector) internal returns (Function storage);
```

### assignImplementation

------------------------------
🎨 Assign Implementation
--------------------------------


```solidity
function assignImplementation(Function storage func, address implementation) internal returns (Function storage);
```

### assign

---------------
🌈 Assign
-----------------


```solidity
function assign(Function storage func, string memory name, bytes4 selector, address implementation)
    internal
    returns (Function storage);
```

### fetch

-----------------------
📨 Fetch Function
-------------------------


```solidity
function fetch(Function storage func, string memory envKey) internal returns (Function storage);
```


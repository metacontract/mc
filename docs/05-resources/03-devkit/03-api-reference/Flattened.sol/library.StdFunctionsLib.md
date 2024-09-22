# StdFunctionsLib
[Git Source](https://github.com/metacontract/mc/blob/d41f04df9ea19494be75c66f344b8104caf03cd2/resources/devkit/api-reference/Flattened.sol)


## Functions
### complete

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
🟢 Complete Standard Functions
📨 Fetch Standard Functions from Env
🚀 Deploy Standard Functions If Not Exists
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
------------------------------------
🟢 Complete Standard Functions
--------------------------------------


```solidity
function complete(StdFunctions storage std) internal returns (StdFunctions storage);
```

### fetch

-----------------------------------------
📨 Fetch Standard Functions from Env
-------------------------------------------


```solidity
function fetch(StdFunctions storage std) internal returns (StdFunctions storage);
```

### fetch_InitSetAdmin

===== Each Std Function =====


```solidity
function fetch_InitSetAdmin(StdFunctions storage std) internal returns (StdFunctions storage);
```

### fetch_GetFunctions


```solidity
function fetch_GetFunctions(StdFunctions storage std) internal returns (StdFunctions storage);
```

### fetch_Clone


```solidity
function fetch_Clone(StdFunctions storage std) internal returns (StdFunctions storage);
```

### deployIfNotExists

-----------------------------------------------
🚀 Deploy Standard Functions If Not Exists
TODO versioning
-------------------------------------------------


```solidity
function deployIfNotExists(StdFunctions storage std) internal returns (StdFunctions storage);
```

### deployIfNotExists_InitSetAdmin

===== Each Std Function =====


```solidity
function deployIfNotExists_InitSetAdmin(StdFunctions storage std) internal returns (StdFunctions storage);
```

### deployIfNotExists_GetFunctions


```solidity
function deployIfNotExists_GetFunctions(StdFunctions storage std) internal returns (StdFunctions storage);
```

### deployIfNotExists_Clone


```solidity
function deployIfNotExists_Clone(StdFunctions storage std) internal returns (StdFunctions storage);
```

# Logger
[Git Source](https://github.com/metacontract/mc/blob/20954f1387efa0bc72b42d3e78a22f9f845eebbd/src/devkit/Flattened.sol)

===============
📊 Logger
=================


## State Variables
### CRITICAL

```solidity
string constant CRITICAL = "\u001b[91m[\xF0\x9F\x9A\xA8CRITICAL]\u001b[0m";
```


### ERROR

```solidity
string constant ERROR = "\u001b[91m[\u2716 ERROR]\u001b[0m\n\t";
```


### WARN

```solidity
string constant WARN = "\u001b[93m[WARNING]\u001b[0m";
```


### INFO

```solidity
string constant INFO = "\u001b[92m[INFO]\u001b[0m";
```


### DEBUG

```solidity
string constant DEBUG = "\u001b[94m[DEBUG]\u001b[0m";
```


## Functions
### log

------------------
💬 Logging
--------------------


```solidity
function log(string memory message) internal pure;
```

### log


```solidity
function log(string memory header, string memory message) internal pure;
```

### logException


```solidity
function logException(string memory messageHead, string memory messageBody) internal view;
```

### logCritical


```solidity
function logCritical(string memory messageHead) internal pure;
```

### logError


```solidity
function logError(string memory message) internal view;
```

### logWarn


```solidity
function logWarn(string memory message) internal view;
```

### logInfo


```solidity
function logInfo(string memory message) internal view;
```

### logDebug


```solidity
function logDebug(string memory message) internal view;
```

### exportTo

-------------------
💾 Export Log
---------------------


```solidity
function exportTo(string memory fileName) internal;
```

### currentLevel


```solidity
function currentLevel() internal view returns (Level);
```

### shouldLog


```solidity
function shouldLog(Level level) internal view returns (bool);
```

### isDisable


```solidity
function isDisable() internal view returns (bool);
```

## Enums
### Level

```solidity
enum Level {
    Critical,
    Error,
    Warn,
    Info,
    Debug
}
```


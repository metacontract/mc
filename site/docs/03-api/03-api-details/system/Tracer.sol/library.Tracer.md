# Tracer
[Git Source](https://github.com/metacontract/mc/blob/b874bc295b567a7e9bd6d6c63dfe84df116a2f3a/src/devkit/system/Tracer.sol)


## Functions
### start

----------------------------
📈 Execution Tracking
------------------------------


```solidity
function start(string memory libName, string memory funcName, string memory params) internal returns (uint256 pid);
```

### finish


```solidity
function finish(uint256 pid) internal;
```

### traceErrorLocations


```solidity
function traceErrorLocations() internal view returns (string memory locations);
```

### startProcess

-----------
🌞 mc
-------------


```solidity
function startProcess(MCDevKit storage, string memory name, string memory params) internal returns (uint256);
```

### startProcess


```solidity
function startProcess(MCDevKit storage mc, string memory name) internal returns (uint256);
```

### finishProcess


```solidity
function finishProcess(MCDevKit storage mc, uint256 pid) internal returns (MCDevKit storage);
```

### finishProcess


```solidity
function finishProcess(string memory str, uint256 pid) internal returns (string memory);
```

### startProcess

------------------
🧩 Function
--------------------


```solidity
function startProcess(Function storage, string memory name, string memory params) internal returns (uint256);
```

### startProcess


```solidity
function startProcess(Function storage func, string memory name) internal returns (uint256);
```

### finishProcess


```solidity
function finishProcess(Function storage func, uint256 pid) internal returns (Function storage);
```

### startProcess

--------------------------
🧩 Functions Registry
----------------------------


```solidity
function startProcess(FunctionRegistry storage, string memory name, string memory params) internal returns (uint256);
```

### startProcess


```solidity
function startProcess(FunctionRegistry storage functions, string memory name) internal returns (uint256);
```

### finishProcess


```solidity
function finishProcess(FunctionRegistry storage functions, uint256 pid) internal returns (FunctionRegistry storage);
```

### startProcess

----------------
🗂️ Bundle
------------------


```solidity
function startProcess(Bundle storage, string memory name, string memory params) internal returns (uint256);
```

### startProcess


```solidity
function startProcess(Bundle storage bundle, string memory name) internal returns (uint256);
```

### finishProcess


```solidity
function finishProcess(Bundle storage bundle, uint256 pid) internal returns (Bundle storage);
```

### startProcess

--------------------------
🧩 Bundle Registry
----------------------------


```solidity
function startProcess(BundleRegistry storage, string memory name, string memory params) internal returns (uint256);
```

### startProcess


```solidity
function startProcess(BundleRegistry storage bundle, string memory name) internal returns (uint256);
```

### finishProcess


```solidity
function finishProcess(BundleRegistry storage bundle, uint256 pid) internal returns (BundleRegistry storage);
```

### startProcess

-------------------------
🏛 Standard Registry
---------------------------


```solidity
function startProcess(StdRegistry storage, string memory name, string memory params) internal returns (uint256);
```

### startProcess


```solidity
function startProcess(StdRegistry storage std, string memory name) internal returns (uint256);
```

### finishProcess


```solidity
function finishProcess(StdRegistry storage std, uint256 pid) internal returns (StdRegistry storage);
```

### startProcess

--------------------------
🏰 Standard Functions
----------------------------


```solidity
function startProcess(StdFunctions storage, string memory name, string memory params) internal returns (uint256);
```

### startProcess


```solidity
function startProcess(StdFunctions storage std, string memory name) internal returns (uint256);
```

### finishProcess


```solidity
function finishProcess(StdFunctions storage std, uint256 pid) internal returns (StdFunctions storage);
```

### startProcess

---------------
🏠 Proxy
-----------------


```solidity
function startProcess(Proxy memory, string memory name, string memory params) internal returns (uint256);
```

### startProcess


```solidity
function startProcess(Proxy memory, string memory name) internal returns (uint256);
```

### finishProcess


```solidity
function finishProcess(Proxy memory proxy, uint256 pid) internal returns (Proxy memory);
```

### finishProcessInStorage


```solidity
function finishProcessInStorage(Proxy storage proxy, uint256 pid) internal returns (Proxy storage);
```

### startProcess

----------------------
🏠 Proxy Registry
------------------------


```solidity
function startProcess(ProxyRegistry storage, string memory name, string memory params) internal returns (uint256);
```

### startProcess


```solidity
function startProcess(ProxyRegistry storage proxies, string memory name) internal returns (uint256);
```

### finishProcess


```solidity
function finishProcess(ProxyRegistry storage proxies, uint256 pid) internal returns (ProxyRegistry storage);
```

### startProcess

-------------------
📚 Dictionary
---------------------


```solidity
function startProcess(Dictionary memory, string memory name, string memory params) internal returns (uint256);
```

### startProcess


```solidity
function startProcess(Dictionary memory, string memory name) internal returns (uint256);
```

### finishProcess


```solidity
function finishProcess(Dictionary memory dictionary, uint256 pid) internal returns (Dictionary memory);
```

### finishProcessInStorage


```solidity
function finishProcessInStorage(Dictionary storage dictionary, uint256 pid) internal returns (Dictionary storage);
```

### startProcess

----------------------------
📚 Dictionary Registry
------------------------------


```solidity
function startProcess(DictionaryRegistry storage, string memory name, string memory params)
    internal
    returns (uint256);
```

### startProcess


```solidity
function startProcess(DictionaryRegistry storage dictionaries, string memory name) internal returns (uint256);
```

### finishProcess


```solidity
function finishProcess(DictionaryRegistry storage dictionaries, uint256 pid)
    internal
    returns (DictionaryRegistry storage);
```

### startProcess

------------------------
📸 Current Context
--------------------------


```solidity
function startProcess(Current storage, string memory name, string memory params) internal returns (uint256);
```

### startProcess


```solidity
function startProcess(Current storage current, string memory name) internal returns (uint256);
```

### finishProcess


```solidity
function finishProcess(Current storage current, uint256 pid) internal returns (Current storage);
```


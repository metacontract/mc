# MCMockLib
[Git Source](https://github.com/metacontract/mc/blob/20ed737f21a46d89afffe1322a75b1ecfcacff9a/src/devkit/utils/global/MCMockLib.sol)

🎭 Mock
🌞 Mocking Meta Contract
🏠 Mocking Proxy
📚 Mocking Dictionary


## Functions
### createMockProxy

-----------------------------
🌞 Mocking Meta Contract
-------------------------------
---------------------
🏠 Mocking Proxy
-----------------------


```solidity
function createMockProxy(MCDevKit storage mc, Bundle storage bundle, bytes memory initData)
    internal
    returns (Proxy storage mockProxy);
```

### createMockProxy


```solidity
function createMockProxy(MCDevKit storage mc, Bundle storage bundle) internal returns (Proxy storage mockProxy);
```

### createMockProxy


```solidity
function createMockProxy(MCDevKit storage mc, bytes memory initData) internal returns (Proxy storage mockProxy);
```

### createMockProxy


```solidity
function createMockProxy(MCDevKit storage mc) internal returns (Proxy storage mockProxy);
```

### createMockDictionary

-------------------------
📚 Mocking Dictionary
---------------------------


```solidity
function createMockDictionary(MCDevKit storage mc, Bundle storage bundle, address owner)
    internal
    returns (Dictionary storage mockDictionary);
```

### createMockDictionary


```solidity
function createMockDictionary(MCDevKit storage mc) internal returns (Dictionary storage mockDictionary);
```

### createMockDictionary


```solidity
function createMockDictionary(MCDevKit storage mc, Bundle storage bundle)
    internal
    returns (Dictionary storage mockDictionary);
```

### createMockDictionary


```solidity
function createMockDictionary(MCDevKit storage mc, address owner)
    internal
    returns (Dictionary storage mockDictionary);
```


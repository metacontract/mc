# MCMockLib
[Git Source](https://github.com/metacontract/mc/blob/7db22f6d7abc05705d21c7601fb406ca49c18557/src/devkit/Flattened.sol)

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
    returns (Proxy_2 storage mockProxy);
```

### createMockProxy


```solidity
function createMockProxy(MCDevKit storage mc, Bundle storage bundle) internal returns (Proxy_2 storage mockProxy);
```

### createMockProxy


```solidity
function createMockProxy(MCDevKit storage mc, bytes memory initData) internal returns (Proxy_2 storage mockProxy);
```

### createMockProxy


```solidity
function createMockProxy(MCDevKit storage mc) internal returns (Proxy_2 storage mockProxy);
```

### createMockDictionary

-------------------------
📚 Mocking Dictionary
---------------------------


```solidity
function createMockDictionary(MCDevKit storage mc, Bundle storage bundle, address owner)
    internal
    returns (Dictionary_1 storage mockDictionary);
```

### createMockDictionary


```solidity
function createMockDictionary(MCDevKit storage mc) internal returns (Dictionary_1 storage mockDictionary);
```

### createMockDictionary


```solidity
function createMockDictionary(MCDevKit storage mc, Bundle storage bundle)
    internal
    returns (Dictionary_1 storage mockDictionary);
```

### createMockDictionary


```solidity
function createMockDictionary(MCDevKit storage mc, address owner)
    internal
    returns (Dictionary_1 storage mockDictionary);
```


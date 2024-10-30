# DictionaryLib
[Git Source](https://github.com/metacontract/mc/blob/20954f1387efa0bc72b42d3e78a22f9f845eebbd/src/devkit/Flattened.sol)


## Functions
### assignName

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
📛 Assign Name
🚀 Deploy Dictionary
📩 Load Dictionary
🔂 Duplicate Dictionary
🧩 Set Function or Bundle
🪟 Upgrade Facade
🤖 Create Dictionary Mock
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--------------------
📛 Assign Name
----------------------


```solidity
function assignName(Dictionary_1 memory dictionary, string memory name) internal returns (Dictionary_1 memory);
```

### deploy

-------------------------
🚀 Deploy Dictionary
- Verifiable
- Immutable
- Beacon
---------------------------


```solidity
function deploy(address owner) internal returns (Dictionary_1 memory dictionary);
```

### deployImmutable


```solidity
function deployImmutable(Function[] storage functions, address facade)
    internal
    returns (Dictionary_1 memory dictionary);
```

### deployBeacon


```solidity
function deployBeacon(address implementation, address owner) internal returns (Dictionary_1 memory dictionary);
```

### load

-----------------------
📩 Load Dictionary
-------------------------


```solidity
function load(string memory name, address dictionaryAddr) internal returns (Dictionary_1 memory dictionary);
```

### duplicate

----------------------------
🔂 Duplicate Dictionary
------------------------------


```solidity
function duplicate(Dictionary_1 storage dictionary, address owner)
    internal
    returns (Dictionary_1 memory duplicatedDictionary);
```

### set

-----------------------------
🧩 Set Function or Bundle
-------------------------------


```solidity
function set(Dictionary_1 memory dictionary, bytes4 selector, address implementation)
    internal
    returns (Dictionary_1 memory);
```

### set


```solidity
function set(Dictionary_1 memory dictionary, Function memory func) internal returns (Dictionary_1 memory);
```

### set


```solidity
function set(Dictionary_1 memory dictionary, Bundle storage bundle) internal returns (Dictionary_1 memory);
```

### upgradeFacade

----------------------
🪟 Upgrade Facade
------------------------


```solidity
function upgradeFacade(Dictionary_1 memory dictionary, address newFacade) internal returns (Dictionary_1 memory);
```

### createMock

------------------------------
🤖 Create Dictionary Mock
--------------------------------


```solidity
function createMock(Bundle storage bundle, address owner) internal returns (Dictionary_1 memory dictionary);
```


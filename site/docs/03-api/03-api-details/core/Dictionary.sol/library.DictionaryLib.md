# DictionaryLib
[Git Source](https://github.com/metacontract/mc/blob/main/src/devkit/core/Dictionary.sol)


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
function assignName(Dictionary memory dictionary, string memory name) internal returns (Dictionary memory);
```

### deploy

-------------------------
🚀 Deploy Dictionary
- Verifiable
- Immutable
- Beacon
---------------------------


```solidity
function deploy(address owner) internal returns (Dictionary memory dictionary);
```

### deployImmutable


```solidity
function deployImmutable(Function[] storage functions, address facade)
    internal
    returns (Dictionary memory dictionary);
```

### deployBeacon


```solidity
function deployBeacon(address implementation, address owner) internal returns (Dictionary memory dictionary);
```

### load

-----------------------
📩 Load Dictionary
-------------------------


```solidity
function load(string memory name, address dictionaryAddr) internal returns (Dictionary memory dictionary);
```

### duplicate

----------------------------
🔂 Duplicate Dictionary
------------------------------


```solidity
function duplicate(Dictionary storage dictionary, address owner)
    internal
    returns (Dictionary memory duplicatedDictionary);
```

### set

-----------------------------
🧩 Set Function or Bundle
-------------------------------


```solidity
function set(Dictionary memory dictionary, bytes4 selector, address implementation)
    internal
    returns (Dictionary memory);
```

### set


```solidity
function set(Dictionary memory dictionary, Function memory func) internal returns (Dictionary memory);
```

### set


```solidity
function set(Dictionary memory dictionary, Bundle storage bundle) internal returns (Dictionary memory);
```

### upgradeFacade

----------------------
🪟 Upgrade Facade
------------------------


```solidity
function upgradeFacade(Dictionary memory dictionary, address newFacade) internal returns (Dictionary memory);
```

### createMock

------------------------------
🤖 Create Dictionary Mock
--------------------------------


```solidity
function createMock(Bundle storage bundle, address owner) internal returns (Dictionary memory dictionary);
```


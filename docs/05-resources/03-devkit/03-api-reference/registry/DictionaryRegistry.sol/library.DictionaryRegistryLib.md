# DictionaryRegistryLib
[Git Source](https://github.com/metacontract/mc/blob/20ed737f21a46d89afffe1322a75b1ecfcacff9a/src/devkit/registry/DictionaryRegistry.sol)


## Functions
### register

---------------------------
🗳️ Register Dictionary
-----------------------------


```solidity
function register(DictionaryRegistry storage registry, Dictionary memory _dictionary)
    internal
    returns (Dictionary storage dictionary);
```

### find

------------------------
🔍 Find Dictionary
--------------------------


```solidity
function find(DictionaryRegistry storage registry, string memory name)
    internal
    returns (Dictionary storage dictionary);
```

### findCurrent


```solidity
function findCurrent(DictionaryRegistry storage registry) internal returns (Dictionary storage dictionary);
```

### genUniqueName

-----------------------------
🏷 Generate Unique Name
-------------------------------


```solidity
function genUniqueName(DictionaryRegistry storage registry, string memory baseName)
    internal
    returns (string memory name);
```

### genUniqueMockName


```solidity
function genUniqueMockName(DictionaryRegistry storage registry, string memory baseName)
    internal
    returns (string memory name);
```


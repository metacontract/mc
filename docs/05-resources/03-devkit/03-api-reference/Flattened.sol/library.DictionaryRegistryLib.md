# DictionaryRegistryLib
[Git Source](https://github.com/metacontract/mc/blob/d41f04df9ea19494be75c66f344b8104caf03cd2/resources/devkit/api-reference/Flattened.sol)


## Functions
### register

---------------------------
🗳️ Register Dictionary
-----------------------------


```solidity
function register(DictionaryRegistry storage registry, Dictionary_1 memory _dictionary)
    internal
    returns (Dictionary_1 storage dictionary);
```

### find

------------------------
🔍 Find Dictionary
--------------------------


```solidity
function find(DictionaryRegistry storage registry, string memory name)
    internal
    returns (Dictionary_1 storage dictionary);
```

### findCurrent


```solidity
function findCurrent(DictionaryRegistry storage registry) internal returns (Dictionary_1 storage dictionary);
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


# DictionaryRegistryLib
[Git Source](https://github.com/metacontract/mc/blob/93e4f2d4a013f48ae1db91ed21bff3eb8a27ce1d/src/devkit/Flattened.sol)


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


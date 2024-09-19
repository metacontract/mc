# BundleRegistryLib
[Git Source](https://github.com/metacontract/mc/blob/20ed737f21a46d89afffe1322a75b1ecfcacff9a/src/devkit/Flattened.sol)


## Functions
### init

---------------------
🌱 Init Bundle
-----------------------


```solidity
function init(BundleRegistry storage registry, string memory name) internal returns (BundleRegistry storage);
```

### ensureInit


```solidity
function ensureInit(BundleRegistry storage registry) internal returns (BundleRegistry storage);
```

### find

--------------------
🔍 Find Bundle
----------------------


```solidity
function find(BundleRegistry storage registry, string memory name) internal returns (Bundle storage bundle);
```

### findCurrent


```solidity
function findCurrent(BundleRegistry storage registry) internal returns (Bundle storage bundle);
```

### genUniqueName

-----------------------------
🏷 Generate Unique Name
-------------------------------


```solidity
function genUniqueName(BundleRegistry storage registry) internal returns (string memory name);
```


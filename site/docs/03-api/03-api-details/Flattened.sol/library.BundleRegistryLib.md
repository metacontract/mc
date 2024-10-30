# BundleRegistryLib
[Git Source](https://github.com/metacontract/mc/blob/93e4f2d4a013f48ae1db91ed21bff3eb8a27ce1d/src/devkit/Flattened.sol)


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


# BundleRegistryLib
[Git Source](https://github.com/metacontract/mc/blob/20954f1387efa0bc72b42d3e78a22f9f845eebbd/src/devkit/registry/BundleRegistry.sol)


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


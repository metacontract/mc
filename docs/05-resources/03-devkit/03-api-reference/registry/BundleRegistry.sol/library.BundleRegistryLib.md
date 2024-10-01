# BundleRegistryLib
[Git Source](https://github.com/metacontract/mc/blob/8438d83ed04f942f1b69f22b0cb556723d88a8f9/resources/devkit/api-reference/registry/BundleRegistry.sol)


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


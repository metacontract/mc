# BundleRegistryLib
[Git Source](https://github.com/metacontract/mc/blob/d41f04df9ea19494be75c66f344b8104caf03cd2/resources/devkit/api-reference/registry/BundleRegistry.sol)


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


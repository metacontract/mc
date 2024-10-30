# ProxyRegistryLib
[Git Source](https://github.com/metacontract/mc/blob/20954f1387efa0bc72b42d3e78a22f9f845eebbd/src/devkit/Flattened.sol)


## Functions
### register

-----------------------
🗳️ Register Proxy
-------------------------


```solidity
function register(ProxyRegistry storage registry, string memory name, Proxy_2 memory _proxy)
    internal
    returns (Proxy_2 storage proxy);
```

### find

-------------------
🔍 Find Proxy
---------------------


```solidity
function find(ProxyRegistry storage registry, string memory name) internal returns (Proxy_2 storage proxy);
```

### findCurrent


```solidity
function findCurrent(ProxyRegistry storage registry) internal returns (Proxy_2 storage proxy);
```

### genUniqueName

-----------------------------
🏷 Generate Unique Name
-------------------------------


```solidity
function genUniqueName(ProxyRegistry storage registry) internal returns (string memory name);
```

### genUniqueMockName


```solidity
function genUniqueMockName(ProxyRegistry storage registry, string memory baseName)
    internal
    returns (string memory name);
```


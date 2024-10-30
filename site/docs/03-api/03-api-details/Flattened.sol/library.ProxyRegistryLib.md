# ProxyRegistryLib
[Git Source](https://github.com/metacontract/mc/blob/93e4f2d4a013f48ae1db91ed21bff3eb8a27ce1d/src/devkit/Flattened.sol)


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


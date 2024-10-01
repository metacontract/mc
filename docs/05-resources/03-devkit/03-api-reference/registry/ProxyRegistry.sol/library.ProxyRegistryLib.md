# ProxyRegistryLib
[Git Source](https://github.com/metacontract/mc/blob/df7a49283d8212c99bebd64a186325e91d34c075/resources/devkit/api-reference/registry/ProxyRegistry.sol)


## Functions
### register

-----------------------
🗳️ Register Proxy
-------------------------


```solidity
function register(ProxyRegistry storage registry, string memory name, Proxy memory _proxy)
    internal
    returns (Proxy storage proxy);
```

### find

-------------------
🔍 Find Proxy
---------------------


```solidity
function find(ProxyRegistry storage registry, string memory name) internal returns (Proxy storage proxy);
```

### findCurrent


```solidity
function findCurrent(ProxyRegistry storage registry) internal returns (Proxy storage proxy);
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


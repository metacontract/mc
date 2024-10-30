# NameGenerator
[Git Source](https://github.com/metacontract/mc/blob/b874bc295b567a7e9bd6d6c63dfe84df116a2f3a/src/devkit/utils/mapping/NameGenerator.sol)

=======================
🏷️ Name Generator
=========================


## State Variables
### MOCK

```solidity
string constant MOCK = "Mock";
```


## Functions
### genUniqueName

------------------------
🗂️ Bundle Mapping
--------------------------


```solidity
function genUniqueName(mapping(string => Bundle) storage bundle, string memory baseName)
    internal
    view
    returns (string memory name);
```

### genUniqueName


```solidity
function genUniqueName(mapping(string => Bundle) storage bundle) internal view returns (string memory name);
```

### genUniqueName

-------------------------
🧩 Function Mapping
---------------------------


```solidity
function genUniqueName(mapping(string => Function) storage func, string memory baseName)
    internal
    view
    returns (string memory name);
```

### genUniqueName


```solidity
function genUniqueName(mapping(string => Function) storage func) internal view returns (string memory name);
```

### genUniqueName

---------------------------
📚 Dictionary Mapping
-----------------------------


```solidity
function genUniqueName(mapping(string => Dictionary) storage dictionary, string memory baseName)
    internal
    view
    returns (string memory name);
```

### genUniqueName


```solidity
function genUniqueName(mapping(string => Dictionary) storage dictionary) internal view returns (string memory name);
```

### genUniqueDuplicatedName


```solidity
function genUniqueDuplicatedName(mapping(string => Dictionary) storage dictionary)
    internal
    view
    returns (string memory name);
```

### genUniqueMockName


```solidity
function genUniqueMockName(mapping(string => Dictionary) storage dictionary, string memory baseName)
    internal
    view
    returns (string memory name);
```

### genUniqueName

-----------------------
🏠 Proxy Mapping
-------------------------


```solidity
function genUniqueName(mapping(string => Proxy) storage proxy, string memory baseName)
    internal
    view
    returns (string memory name);
```

### genUniqueName


```solidity
function genUniqueName(mapping(string => Proxy) storage proxy) internal view returns (string memory name);
```

### genUniqueMockName


```solidity
function genUniqueMockName(mapping(string => Proxy) storage proxy, string memory baseName)
    internal
    view
    returns (string memory name);
```


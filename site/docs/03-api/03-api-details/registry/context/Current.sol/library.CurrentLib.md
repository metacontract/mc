# CurrentLib
[Git Source](https://github.com/metacontract/mc/blob/b874bc295b567a7e9bd6d6c63dfe84df116a2f3a/src/devkit/registry/context/Current.sol)


## Functions
### update

-------------------------------
🔄 Update Current Context
---------------------------------


```solidity
function update(Current storage current, string memory name) internal;
```

### reset

------------------------------
🧹 Reset Current Context
--------------------------------


```solidity
function reset(Current storage current) internal;
```

### find

------------------
🔍 Find Name
--------------------


```solidity
function find(Current storage current) internal returns (string memory name);
```


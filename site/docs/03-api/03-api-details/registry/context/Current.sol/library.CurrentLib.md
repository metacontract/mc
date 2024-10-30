# CurrentLib
[Git Source](https://github.com/metacontract/mc/blob/7db22f6d7abc05705d21c7601fb406ca49c18557/src/devkit/registry/context/Current.sol)


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


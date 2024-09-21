# CurrentLib
[Git Source](https://github.com/metacontract/mc/blob/c3fc2b414d37afc92bb1cf2e606b4b2bede47403/resources/devkit/api-reference/registry/context/Current.sol)


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


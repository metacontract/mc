# CurrentLib
[Git Source](https://github.com/metacontract/mc/blob/0cf91165f9ec2cbeeba800a4baf4e81e2df5c3bb/src/devkit/registry/context/Current.sol)


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

